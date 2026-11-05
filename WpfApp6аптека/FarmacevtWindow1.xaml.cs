using System;
using System.Collections.ObjectModel;
using System.Windows;
using System.Windows.Input;
using Microsoft.Data.SqlClient;

namespace WpfApp
{
    public partial class FarmacevtWindow : Window
    {
        private readonly string connString =
            @"Data Source=олеся\SQLEXPRESS;Initial Catalog=аптека1;Integrated Security=True;TrustServerCertificate=True";

        private ObservableCollection<Tovar> товары = new ObservableCollection<Tovar>();
        private ObservableCollection<KorzinaItem> корзина = new ObservableCollection<KorzinaItem>();
        private string фио;
        private decimal текущаяСкидка = 0; // 0.1 = 10%



        private void CmbDiscount_SelectionChanged(object sender, System.Windows.Controls.SelectionChangedEventArgs e)
        {
            // Если список еще не загрузился, ничего не делаем
            if (cmbDiscount.SelectedItem == null) return;

            // Получаем выбранный элемент
            var selectedItem = cmbDiscount.SelectedItem as System.Windows.Controls.ComboBoxItem;

            // Берем значение скидки из скрытого тега (Tag)
            if (selectedItem != null && selectedItem.Tag != null)
            {
                // Заменяем точку на запятую перед переводом в число
                текущаяСкидка = decimal.Parse(selectedItem.Tag.ToString().Replace('.', ','));
            }

            // Пересчитываем сумму
            ОбновитьКорзину();
        }


        public FarmacevtWindow(string фио)

        {
            InitializeComponent();
            this.фио = фио;
            lblWelcome.Text = $"{фио}";

            dgProducts.ItemsSource = товары;
            dgCart.ItemsSource = корзина;

            ЗагрузитьТовары();
        }

        private void ЗагрузитьТовары()
        {
            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    // ★ Добавили срок_годности ★
                    string query = @"
                SELECT Т.наименование, Т.мнн, СП.id_серии,
                       СП.цена_розничная,
                       СП.остаток_зал AS остаток,
                       СП.срок_годности
                FROM Товары Т
                JOIN Серии_партии СП ON Т.id_товара = СП.id_товара
                WHERE Т.активен = 1 AND СП.в_наличии = 1
                  AND СП.остаток_зал > 0
                ORDER BY СП.срок_годности ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        товары.Clear();
                        while (r.Read())
                        {
                            товары.Add(new Tovar
                            {
                                IdСерии = (int)r["id_серии"],
                                Наименование = r["наименование"].ToString(),
                                МНН = r["мнн"].ToString(),
                                Цена = (decimal)r["цена_розничная"],
                                Остаток = (int)r["остаток"],
                                СрокГодности = r["срок_годности"] != DBNull.Value
                                    ? Convert.ToDateTime(r["срок_годности"])
                                    : DateTime.MaxValue
                            });
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка загрузки товаров:\n{ex.Message}");
            }
            int просрочено = товары.Count(t => t.Просрочен);
            int скороИстекает = товары.Count(t => t.СкороИстекает);

            if (просрочено > 0)
                lblExpiredInfo.Text = $" Просрочено: {просрочено}    Истекает: {скороИстекает}";
            else if (скороИстекает > 0)
                lblExpiredInfo.Text = $" Скоро истекает: {скороИстекает}";
            else
                lblExpiredInfo.Text = " Все товары годны";
        }

        private void BtnSearch_Click(object sender, RoutedEventArgs e)
        {
            string s = txtSearch.Text.Trim().ToLower();
            if (string.IsNullOrEmpty(s)) { ЗагрузитьТовары(); return; }

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();
                    // ★ И здесь берем ТОЛЬКО остаток_зал ★
                    string query = @"
    SELECT Т.наименование, Т.мнн, СП.id_серии,
           СП.цена_розничная,
           СП.остаток_зал AS остаток,
           СП.срок_годности
    FROM Товары Т
    JOIN Серии_партии СП ON Т.id_товара = СП.id_товара
    WHERE Т.активен = 1 AND СП.в_наличии = 1
      AND СП.остаток_зал > 0
      AND (LOWER(Т.наименование) LIKE @s
        OR LOWER(Т.мнн) LIKE @s
        OR Т.штрихкод LIKE @s)
    ORDER BY СП.срок_годности ASC";

                    using (SqlCommand cmd = new SqlCommand(query, conn))
                    {
                        cmd.Parameters.AddWithValue("@s", "%" + s + "%");
                        using (SqlDataReader r = cmd.ExecuteReader())
                        {
                            товары.Clear();
                            while (r.Read())
                            {
                                товары.Add(new Tovar
                                {
                                    IdСерии = (int)r["id_серии"],
                                    Наименование = r["наименование"].ToString(),
                                    МНН = r["мнн"].ToString(),
                                    Цена = (decimal)r["цена_розничная"],
                                    Остаток = (int)r["остаток"],
                                     СрокГодности = r["срок_годности"] != DBNull.Value
                                    ? Convert.ToDateTime(r["срок_годности"])
                                  : DateTime.MaxValue
                                });
                            }
                        }
                    }
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка поиска:\n{ex.Message}");
            }
        }

        private void DgProducts_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (dgProducts.SelectedItem is Tovar t)
                ДобавитьВКорзину(t);
        }

        private void ДобавитьВКорзину(Tovar t)

        {
            if (t.Просрочен)
            {
                MessageBox.Show(
                    $"Товар «{t.Наименование}» ПРОСРОЧЕН (годен до {t.СрокГодности:dd.MM.yyyy}).\nПродажа запрещена!",
                    "Просроченный товар",
                    MessageBoxButton.OK, MessageBoxImage.Warning);
                return;
            }

            if (t.СкороИстекает)
            {
                var ответ = MessageBox.Show(
                    $"Товар «{t.Наименование}» истекает {t.СрокГодности:dd.MM.yyyy}.\nПродолжить?",
                    "Внимание",
                    MessageBoxButton.YesNo, MessageBoxImage.Question);
                if (ответ != MessageBoxResult.Yes) return;
            }

           
                foreach (var item in корзина)
            {
                if (item.IdСерии == t.IdСерии)
                {
                    if (item.Количество < t.Остаток)
                    {
                        item.Количество++;
                        item.Сумма = item.Количество * item.Цена;
                        ОбновитьКорзину();
                    }
                    else MessageBox.Show("Недостаточно товара в зале!");
                    return;
                }
            }

            корзина.Add(new KorzinaItem
            {
                IdСерии = t.IdСерии,
                Наименование = t.Наименование,
                Цена = t.Цена,
                Количество = 1,
                Сумма = t.Цена
            });
            ОбновитьКорзину();
        }

        private void ОбновитьКорзину()
        {
            decimal итого = 0;
            foreach (var i in корзина) итого += i.Сумма;

            // Вычитаем скидку
            decimal скидкаВРублях = итого * текущаяСкидка;
            decimal итогоСоСкидкой = итого - скидкаВРублях;

            // Выводим красивую сумму
            lblTotal.Text = итогоСоСкидкой.ToString("N2") + " ₽";

            // (Необязательно) Можно выводить сумму скидки, если хотите
            // lblDiscount.Text = скидкаВРублях.ToString("N2");

            dgCart.ItemsSource = null;
            dgCart.ItemsSource = корзина;
        }

        private void BtnRemove_Click(object sender, RoutedEventArgs e)
        {
            if (dgCart.SelectedItem is KorzinaItem item)
            {
                корзина.Remove(item);
                ОбновитьКорзину();
            }
        }

        private void BtnClear_Click(object sender, RoutedEventArgs e)
        {
            if (корзина.Count == 0) return;
            if (MessageBox.Show("Очистить корзину?", "Подтверждение",
                MessageBoxButton.YesNo) == MessageBoxResult.Yes)
            {
                корзина.Clear();
                ОбновитьКорзину();
            }
        }

        private void BtnCheckout_Click(object sender, RoutedEventArgs e)
        {
            if (корзина.Count == 0)
            {
                MessageBox.Show("Корзина пуста!");
                return;
            }

            try
            {
                using (SqlConnection conn = new SqlConnection(connString))
                {
                    conn.Open();

                    // 1. Находим сотрудника
                    int idСотр = 0;
                    using (SqlCommand cmd = new SqlCommand("SELECT id_сотрудника FROM Сотрудники WHERE фио = @ф", conn))
                    {
                        cmd.Parameters.AddWithValue("@ф", фио);
                        var res = cmd.ExecuteScalar();
                        if (res != null) idСотр = (int)res;
                    }

                    if (idСотр == 0)
                    {
                        MessageBox.Show("Сотрудник не найден в БД!");
                        return;
                    }

                    // 2. Считаем сумму
                    decimal итого = 0;
                    foreach (var i in корзина) итого += i.Сумма;
                    decimal скидкаВРублях = итого * текущаяСкидка;
                    decimal итогоСоСкидкой = итого - скидкаВРублях;

                    // 3. СНАЧАЛА создаем Чек (Шапку продажи)
                    int idПродажи = 0;

                    // ★ Получаем выбранный способ оплаты ★
                    string типОплаты = "Наличные"; // по умолчанию
                    if (cmbPayment.SelectedItem != null)
                    {
                        типОплаты = (cmbPayment.SelectedItem as System.Windows.Controls.ComboBoxItem).Content.ToString();
                    }

                    using (SqlCommand cmd = new SqlCommand(@"
                INSERT INTO Продажи (id_покупателя, id_сотрудника, сумма_итого, сумма_скидки, тип_оплаты, статус)
                VALUES (NULL, @с, @с2, @скидка, @оплата, N'Закрыт');
                SELECT SCOPE_IDENTITY();", conn))
                    {
                        cmd.Parameters.AddWithValue("@с", idСотр);
                        cmd.Parameters.AddWithValue("@с2", итогоСоСкидкой);
                        cmd.Parameters.AddWithValue("@скидка", скидкаВРублях);
                        cmd.Parameters.AddWithValue("@оплата", типОплаты); // ★ Передаем оплату в базу ★

                        idПродажи = Convert.ToInt32(cmd.ExecuteScalar());
                    }
                    // 4. ТЕПЕРЬ добавляем в него товары
                    foreach (var i in корзина)
                    {
                        using (SqlCommand cmd = new SqlCommand(@"
                    INSERT INTO Позиции_продажи (id_продажи, id_серии, количество, цена_продажи, сумма)
                    VALUES (@p, @s, @k, @c, @sm)", conn))
                        {
                            cmd.Parameters.AddWithValue("@p", idПродажи);
                            cmd.Parameters.AddWithValue("@s", i.IdСерии);
                            cmd.Parameters.AddWithValue("@k", i.Количество);
                            cmd.Parameters.AddWithValue("@c", i.Цена);
                            cmd.Parameters.AddWithValue("@sm", i.Сумма);
                            cmd.ExecuteNonQuery();
                        }

                        // 5. Списываем товар из зала
                        using (SqlCommand cmd = new SqlCommand(@"
                    UPDATE Серии_партии SET остаток_зал = остаток_зал - @k WHERE id_серии = @s", conn))
                        {
                            cmd.Parameters.AddWithValue("@k", i.Количество);
                            cmd.Parameters.AddWithValue("@s", i.IdСерии);
                            cmd.ExecuteNonQuery();
                        }
                    }

                    MessageBox.Show($"Продажа {idПродажи} оформлена!\nИтого к оплате: {итогоСоСкидкой:N2} ₽");

                    корзина.Clear();
                    ОбновитьКорзину();
                    ЗагрузитьТовары();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show($"Ошибка оформления:\n{ex.Message}");
            }
        }

        private void BtnLogout_Click(object sender, RoutedEventArgs e)
        {
            new MainWindow().Show();
            this.Close();
        }
    }

    public class Tovar
    {
        public int IdСерии { get; set; }
        public string Наименование { get; set; }
        public string МНН { get; set; }
        public decimal Цена { get; set; }
        public int Остаток { get; set; }

        public DateTime СрокГодности { get; set; }

        // Просрочен — сегодня больше срока годности
        public bool Просрочен => СрокГодности.Date < DateTime.Today;

        // Скоро истекает — осталось ≤ 30 дней (и ещё не просрочен)
        public bool СкороИстекает =>
            !Просрочен && (СрокГодности.Date - DateTime.Today).TotalDays <= 30;

        // Текст для колонки
        public string СрокГодностиText => СрокГодности.ToString("dd.MM.yyyy");

        // Статус для колонки
        public string Статус
        {
            get
            {
                if (Просрочен) return " ПРОСРОЧЕН";
                if (СкороИстекает) return " Скоро истекает";
                return " Годен";
            }
        }
    }

    public class KorzinaItem
    {
        public int IdСерии { get; set; }
        public string Наименование { get; set; }
        public decimal Цена { get; set; }
        public int Количество { get; set; }
        public decimal Сумма { get; set; }
    }
}