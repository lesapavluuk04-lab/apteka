using Microsoft.Data.SqlClient;
using System;
using System.Data;
using System.Windows;
using System.Windows.Controls;
using System.Windows.Input;
using System.Windows.Media;

namespace WpfApp
{
    public partial class AdminWindow : Window
    {
        string conn = @"Data Source=олеся\SQLEXPRESS;Initial Catalog=аптека1;Integrated Security=True;TrustServerCertificate=True";
        string текущийРаздел = "";
        DataRowView редактируемаяСтрока = null;

        public AdminWindow(string фио)
        {
            InitializeComponent();
            lblWelcome.Text = "Администратор — " + фио;
        }

        private void BtnTovary_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Товары";
            lblTitle.Text = "Список товаров";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Visible;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Visible;

            lblExpiredInfo.Text = ""; // Очищаем счетчик

            Показать(@"SELECT 
             id_товара, 
             штрихкод, 
             наименование, 
             мнн, 
             производитель, 
             форма_выпуска, 
             дозировка, 
             упаковка, 
             категория 
           FROM Товары ORDER BY id_товара DESC");
        }

        private void BtnCeny_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Цены";
            lblTitle.Text = "Цены и остатки";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Collapsed;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Visible;

            // ★ ИСПРАВЛЕННЫЙ SQL-ЗАПРОС ★
            Показать(@"
                SELECT 
                    СП.id_серии, 
                    Т.наименование, 
                    СП.номер_серии, 
                    CONVERT(VARCHAR, П.дата_поступления, 104) AS дата_поступления,
                    СП.цена_закупочная, 
                    СП.цена_розничная, 
                    СП.остаток_зал AS остаток_склад, 
                    СП.остаток_зал AS остаток_зал,
                    CONVERT(VARCHAR, СП.срок_годности, 104) AS срок_годности,
                    
                    CASE 
                        WHEN СП.срок_годности < CAST(GETDATE() AS DATE) THEN N'⛔ ПРОСРОЧЕН'
                        WHEN DATEDIFF(DAY, GETDATE(), СП.срок_годности) <= 30 THEN N'⚠ Скоро истекает'
                        ELSE N'✔ Годен'
                    END AS статус_срок,

                    CAST(CASE WHEN СП.срок_годности < CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END AS BIT) AS Просрочен,
                    CAST(CASE WHEN СП.срок_годности >= CAST(GETDATE() AS DATE) 
                               AND DATEDIFF(DAY, GETDATE(), СП.срок_годности) <= 30 THEN 1 ELSE 0 END AS BIT) AS СкороИстекает
                FROM Серии_партии СП 
                JOIN Товары Т ON СП.id_товара = Т.id_товара
                LEFT JOIN Поставки П ON СП.id_поставки = П.id_поставки
                ORDER BY СП.срок_годности ASC");

            ОбновитьСчётчикПросрочки();
        }

        private void BtnPersonal_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Персонал";
            lblTitle.Text = "Наши сотрудники";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Visible;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Visible;

            lblExpiredInfo.Text = ""; // Очищаем счетчик

            Показать(@"SELECT 
             id_сотрудника, 
             фио, 
             должность, 
             роль, 
             логин, 
             телефон 
           FROM Сотрудники");
        }

        private void BtnPostavki_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Поставки";
            lblTitle.Text = "Поставки";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Visible;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Visible;

            lblExpiredInfo.Text = ""; // Очищаем счетчик

            Показать(@"SELECT 
                 id_поставки, 
                 id_поставщика, 
                 номер_накладной, 
                 CONVERT(VARCHAR, дата_поступления, 104) AS дата_поступления, 
                 сумма, 
                 статус 
               FROM Поставки ORDER BY дата_поступления DESC");
        }

        private void BtnProdazhi_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Продажи";
            lblTitle.Text = "Продажи";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Collapsed;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Collapsed;

            lblExpiredInfo.Text = ""; // Очищаем счетчик

            Показать(@"SELECT 
                 id_продажи, 
                 id_сотрудника, 
                 CONVERT(VARCHAR, дата_время, 105) + ' ' + CONVERT(VARCHAR, дата_время, 108) AS дата_время, 
                 сумма_итого, 
                 сумма_скидки, 
                 (сумма_итого - сумма_скидки) AS К_оплате, 
                 тип_оплаты, 
                 статус
               FROM Продажи ORDER BY дата_время DESC");
        }

        private void BtnOtcety_Click(object sender, RoutedEventArgs e)
        {
            текущийРаздел = "Отчёты";
            lblTitle.Text = "История продаж";
            СкрытьФорму();
            btnAdd.Visibility = Visibility.Collapsed;
            if (dgData.Columns.Count > 0)
                dgData.Columns[0].Visibility = Visibility.Collapsed;

            lblExpiredInfo.Text = ""; // Очищаем счетчик

            Показать(@"SELECT 
                   П.id_продажи, 
                   П.id_сотрудника, 
                   С.фио, 
                   CONVERT(VARCHAR, П.дата_время, 105) + ' ' + CONVERT(VARCHAR, П.дата_время, 108) AS дата_время,
                   Т.наименование, 
                   ПП.количество, 
                   ПП.сумма, 
                   П.сумма_итого
               FROM Продажи П
               JOIN Сотрудники С ON П.id_сотрудника = С.id_сотрудника
               JOIN Позиции_продажи ПП ON П.id_продажи = ПП.id_продажи
               JOIN Серии_партии СП ON ПП.id_серии = СП.id_серии
               JOIN Товары Т ON СП.id_товара = Т.id_товара
               ORDER BY П.дата_время DESC");
        }

        private void Показать(string запрос)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(запрос, c);
                    DataTable таблица = new DataTable();
                    adapter.Fill(таблица);

                    dgData.ItemsSource = null;
                    dgData.ItemsSource = таблица.DefaultView;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки: " + ex.Message);
            }
        }

        // ★ МЕТОД ДЛЯ ПОДСЧЕТА ПРОСРОЧКИ ★
        private void ОбновитьСчётчикПросрочки()
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();
                    string query = @"
                        SELECT 
                            SUM(CASE WHEN срок_годности < CAST(GETDATE() AS DATE) THEN 1 ELSE 0 END) AS Просрочено,
                            SUM(CASE WHEN срок_годности >= CAST(GETDATE() AS DATE) 
                                      AND DATEDIFF(DAY, GETDATE(), срок_годности) <= 30 THEN 1 ELSE 0 END) AS СкороИстекает
                        FROM Серии_партии 
                        WHERE в_наличии = 1";

                    SqlCommand cmd = new SqlCommand(query, c);
                    using (SqlDataReader r = cmd.ExecuteReader())
                    {
                        if (r.Read())
                        {
                            int просрочено = r["Просрочено"] != DBNull.Value ? Convert.ToInt32(r["Просрочено"]) : 0;
                            int скоро = r["СкороИстекает"] != DBNull.Value ? Convert.ToInt32(r["СкороИстекает"]) : 0;

                            if (просрочено > 0)
                                lblExpiredInfo.Text = $"⛔ Просрочено: {просрочено}   ⚠ Истекает: {скоро}";
                            else if (скоро > 0)
                                lblExpiredInfo.Text = $"⚠ Скоро истекает: {скоро}";
                            else
                                lblExpiredInfo.Text = "✔ Все товары годны";
                        }
                    }
                }
            }
            catch { }
        }

        private void BtnAdd_Click(object sender, RoutedEventArgs e)
        {
            if (текущийРаздел == "Отчёты") { MessageBox.Show("В отчёты нельзя добавлять."); return; }
            if (текущийРаздел == "") { MessageBox.Show("Выберите раздел!"); return; }

            редактируемаяСтрока = null;
            lblFormTitle.Text = "Добавить запись в «" + текущийРаздел + "»";
            ОчиститьПоля();
            ПостроитьПоля();
            pnlForm.Visibility = Visibility.Visible;
        }

        private void DgData_MouseDoubleClick(object sender, MouseButtonEventArgs e)
        {
            if (dgData.SelectedItem == null) return;

            if (текущийРаздел == "Отчёты" || текущийРаздел == "Продажи") return;

            редактируемаяСтрока = (DataRowView)dgData.SelectedItem;
            lblFormTitle.Text = " Редактировать запись";
            ПостроитьПоля();
            ЗаполнитьПоля(редактируемаяСтрока);
            pnlForm.Visibility = Visibility.Visible;
        }

        private void ПостроитьПоля()
        {
            pnlFields.Children.Clear();
            switch (текущийРаздел)
            {
                case "Товары":
                    ДобавитьПоле("Штрихкод:", "tbBarcode", 100);
                    ДобавитьПоле("Наименование:", "tbName", 150);
                    ДобавитьПоле("МНН:", "tbMNN", 120);
                    ДобавитьПоле("Производитель:", "tbProd", 120);
                    ДобавитьПоле("Форма выпуска:", "tbForm", 100);
                    ДобавитьПоле("Дозировка:", "tbDose", 80);
                    ДобавитьПоле("Упаковка:", "tbUpak", 80);
                    ДобавитьПоле("Категория:", "tbCat", 120);
                    break;

                case "Персонал":
                    ДобавитьПоле("ФИО:", "tbFIO", 180);
                    ДобавитьПоле("Должность:", "tbDolzh", 140);
                    ДобавитьПоле("Роль:", "tbRole", 150);
                    ДобавитьПоле("Логин:", "tbLogin", 120);
                    ДобавитьПоле("Телефон:", "tbPhone", 130);
                    break;

                case "Цены":
                    ДобавитьПоле("Цена закупки:", "tbЗакуп", 110);
                    ДобавитьПоле("Цена розница:", "tbРозница", 110);
                    ДобавитьПоле("Остаток склад:", "tbСклад", 100);
                    ДобавитьПоле("Остаток зал:", "tbЗал", 100);
                    break;

                case "Поставки":
                    ДобавитьПоле("Номер накладной:", "tbНакладная", 120);
                    ДобавитьПоле("Дата (ГГГГ-ММ-ДД):", "tbДата", 110);
                    ДобавитьПоле("Сумма:", "tbСумма", 80);
                    ДобавитьПоле("Статус:", "tbСтатус", 80);
                    ДобавитьВыпадающийСписок("Поставщик:", "cmbПоставщик", "SELECT id_поставщика, наименование FROM Поставщики", "id_поставщика");
                    ДобавитьВыпадающийСписок("Товар:", "cmbТовар", "SELECT id_товара, наименование FROM Товары", "id_товара");
                    ДобавитьПоле("Кол-во:", "tbКолво", 60);
                    ДобавитьПоле("Закупка:", "tbЗакуп", 80);
                    break;

                case "Продажи":
                    ДобавитьПоле("ID покупателя:", "tbПокуп", 100);
                    ДобавитьПоле("ID сотрудника:", "tbСотр", 100);
                    ДобавитьПоле("Сумма итого:", "tbСуммаИтого", 100);
                    ДобавитьПоле("Скидка:", "tbСкидка", 80);
                    ДобавитьПоле("Тип оплаты:", "tbОплата", 100);
                    break;
            }
        }

        private void ДобавитьПоле(string подпись, string имя, double ширина)
        {
            pnlFields.Children.Add(new TextBlock { Text = подпись, VerticalAlignment = VerticalAlignment.Center, Margin = new Thickness(5, 0, 3, 0), FontSize = 12 });
            pnlFields.Children.Add(new TextBox { Name = имя, Width = ширина, Height = 28, Margin = new Thickness(2, 0, 5, 0), Padding = new Thickness(5, 0, 5, 0), VerticalContentAlignment = VerticalAlignment.Center, FontSize = 12 });
        }

        private void ОчиститьПоля() { foreach (var child in pnlFields.Children) if (child is TextBox tb) tb.Text = ""; }

        private void ЗаполнитьПоля(DataRowView строка)
        {
            if (текущийРаздел == "Товары")
            {
                SetText("tbBarcode", строка["штрихкод"]); SetText("tbName", строка["наименование"]);
                SetText("tbMNN", строка["мнн"]); SetText("tbProd", строка["производитель"]);
                SetText("tbForm", строка["форма_выпуска"]); SetText("tbDose", строка["дозировка"]);
                SetText("tbUpak", строка["упаковка"]); SetText("tbCat", строка["категория"]);
            }
            else if (текущийРаздел == "Персонал")
            {
                SetText("tbFIO", строка["фио"]); SetText("tbDolzh", строка["должность"]);
                SetText("tbRole", строка["роль"]); SetText("tbLogin", строка["логин"]); SetText("tbPhone", строка["телефон"]);
            }
            else if (текущийРаздел == "Цены")
            {
                SetText("tbЗакуп", строка["цена_закупочная"]); SetText("tbРозница", строка["цена_розничная"]);
                SetText("tbСклад", строка["остаток_склад"]); SetText("tbЗал", строка["остаток_зал"]);
            }
        }

        private void SetText(string имя, object значение) { foreach (var child in pnlFields.Children) if (child is TextBox tb && tb.Name == имя) { tb.Text = значение?.ToString() ?? ""; return; } }
        private string GetText(string имя) { foreach (var child in pnlFields.Children) if (child is TextBox tb && tb.Name == имя) return tb.Text.Trim(); return ""; }

        private void BtnSave_Click(object sender, RoutedEventArgs e)
        {
            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();
                    if (текущийРаздел == "Товары")
                    {
                        string запрос = редактируемаяСтрока == null
                            ? @"INSERT INTO Товары (штрихкод, наименование, мнн, производитель, форма_выпуска, дозировка, упаковка, категория) 
                               VALUES (@б, @н, @м, @п, @ф, @д, @у, @к)"
                            : @"UPDATE Товары SET штрихкод=@б, наименование=@н, мнн=@м, производитель=@п, форма_выпуска=@ф, дозировка=@д, упаковка=@у, категория=@к WHERE id_товара=@id";

                        SqlCommand cmd = new SqlCommand(запрос, c);
                        cmd.Parameters.AddWithValue("@б", GetText("tbBarcode")); cmd.Parameters.AddWithValue("@н", GetText("tbName"));
                        cmd.Parameters.AddWithValue("@м", GetText("tbMNN")); cmd.Parameters.AddWithValue("@п", GetText("tbProd"));
                        cmd.Parameters.AddWithValue("@ф", GetText("tbForm")); cmd.Parameters.AddWithValue("@д", GetText("tbDose"));
                        cmd.Parameters.AddWithValue("@у", GetText("tbUpak")); cmd.Parameters.AddWithValue("@к", GetText("tbCat"));

                        if (редактируемаяСтрока != null) cmd.Parameters.AddWithValue("@id", редактируемаяСтрока["id_товара"]);
                        cmd.ExecuteNonQuery();
                        BtnTovary_Click(null, null);
                    }
                    else if (текущийРаздел == "Персонал")
                    {
                        string запрос = редактируемаяСтрока == null
                            ? @"INSERT INTO Сотрудники (фио, должность, роль, логин, пароль_hash, телефон) VALUES (@ф, @д, @р, @л, N'123', @т)"
                            : @"UPDATE Сотрудники SET фио=@ф, должность=@д, роль=@р, логин=@л, телефон=@т WHERE id_сотрудника=@id";

                        SqlCommand cmd = new SqlCommand(запрос, c);
                        cmd.Parameters.AddWithValue("@ф", GetText("tbFIO")); cmd.Parameters.AddWithValue("@д", GetText("tbDolzh"));
                        cmd.Parameters.AddWithValue("@р", GetText("tbRole")); cmd.Parameters.AddWithValue("@л", GetText("tbLogin"));
                        cmd.Parameters.AddWithValue("@т", GetText("tbPhone"));

                        if (редактируемаяСтрока != null) cmd.Parameters.AddWithValue("@id", редактируемаяСтрока["id_сотрудника"]);
                        cmd.ExecuteNonQuery();
                        BtnPersonal_Click(null, null);
                    }
                    else if (текущийРаздел == "Поставки")
                    {
                        string запрос = редактируемаяСтрока == null
                            ? @"INSERT INTO Поставки (id_поставщика, номер_накладной, дата_поступления, сумма, статус) 
           VALUES (@пост, @накл, @дата, @сумма, @статус); SELECT SCOPE_IDENTITY();"
                            : @"UPDATE Поставки SET id_поставщика=@пост, номер_накладной=@накл, дата_поступления=@дата, сумма=@сумма, статус=@статус WHERE id_поставки=@id; SELECT @id;";

                        SqlCommand cmd = new SqlCommand(запрос, c);
                        var cmbПост = GetComboBox("cmbПоставщик");
                        int idПост = cmbПост.SelectedValue != null ? (int)cmbПост.SelectedValue : 1;

                        cmd.Parameters.AddWithValue("@пост", idПост);
                        cmd.Parameters.AddWithValue("@накл", GetText("tbНакладная"));
                        cmd.Parameters.AddWithValue("@дата", DateTime.Parse(GetText("tbДата"), System.Globalization.CultureInfo.InvariantCulture));
                        string суммаТекст = GetText("tbСумма");
                        decimal сумма = string.IsNullOrEmpty(суммаТекст) ? 0 : decimal.Parse(суммаТекст.Replace('.', ','));
                        cmd.Parameters.AddWithValue("@сумма", сумма);
                        cmd.Parameters.AddWithValue("@статус", GetText("tbСтатус"));

                        if (редактируемаяСтрока != null) cmd.Parameters.AddWithValue("@id", редактируемаяСтрока["id_поставки"]);

                        int idПоставки = Convert.ToInt32(cmd.ExecuteScalar());

                        if (редактируемаяСтрока == null)
                        {
                            var cmbТов = GetComboBox("cmbТовар");
                            int idТовара = cmbТов.SelectedValue != null ? (int)cmbТов.SelectedValue : 1;

                            int колво = string.IsNullOrEmpty(GetText("tbКолво")) ? 0 : int.Parse(GetText("tbКолво"));
                            decimal закуп = string.IsNullOrEmpty(GetText("tbЗакуп")) ? 0 : decimal.Parse(GetText("tbЗакуп").Replace('.', ','));
                            decimal розница = закуп * 1.3m;

                            string запросПартия = @"
    INSERT INTO Серии_партии (id_товара, id_поставки, номер_серии, срок_годности, цена_закупочная, цена_розничная, остаток_склад, остаток_зал, в_наличии) 
    VALUES (@тов, @пост, @сер, DATEADD(year, 1, GETDATE()), @зак, @роз, 0, @кол, 1)";

                            SqlCommand cmdПартия = new SqlCommand(запросПартия, c);
                            cmdПартия.Parameters.AddWithValue("@тов", idТовара);
                            cmdПартия.Parameters.AddWithValue("@пост", idПоставки);
                            cmdПартия.Parameters.AddWithValue("@сер", "СЕР-" + DateTime.Now.Ticks.ToString().Substring(10));
                            cmdПартия.Parameters.AddWithValue("@зак", закуп);
                            cmdПартия.Parameters.AddWithValue("@роз", розница);
                            cmdПартия.Parameters.AddWithValue("@кол", колво);
                            cmdПартия.ExecuteNonQuery();
                        }

                        MessageBox.Show("Поставка сохранена, товар добавлен в Цены!");
                        BtnPostavki_Click(null, null);
                    }
                    else if (текущийРаздел == "Продажи")
                    {
                        string запрос = редактируемаяСтрока == null
                            ? @"INSERT INTO Продажи (id_покупателя, id_сотрудника, сумма_итого, сумма_скидки, тип_оплаты, статус) VALUES (@покуп, @сотр, @сумма, @скидка, @оплата, N'Закрыт')"
                            : @"UPDATE Продажи SET id_покупателя=@покуп, id_сотрудника=@сотр, сумма_итого=@сумма, сумма_скидки=@скидка, тип_оплаты=@оплата WHERE id_продажи=@id";

                        SqlCommand cmd = new SqlCommand(запрос, c);
                        string покуп = GetText("tbПокуп");
                        cmd.Parameters.AddWithValue("@покуп", string.IsNullOrEmpty(покуп) ? (object)DBNull.Value : int.Parse(покуп));
                        cmd.Parameters.AddWithValue("@сотр", int.Parse(GetText("tbСотр")));
                        cmd.Parameters.AddWithValue("@сумма", decimal.Parse(GetText("tbСуммаИтого").Replace('.', ',')));
                        cmd.Parameters.AddWithValue("@скидка", decimal.Parse(GetText("tbСкидка").Replace('.', ',')));
                        cmd.Parameters.AddWithValue("@оплата", GetText("tbОплата"));

                        if (редактируемаяСтрока != null) cmd.Parameters.AddWithValue("@id", редактируемаяСтрока["id_продажи"]);
                        cmd.ExecuteNonQuery();
                        BtnProdazhi_Click(null, null);
                    }
                    else if (текущийРаздел == "Цены")
                    {
                        if (редактируемаяСтрока == null) { MessageBox.Show("Цены можно только редактировать."); return; }
                        string запрос = @"UPDATE Серии_партии SET цена_закупочная=@зак, цена_розничная=@роз, остаток_склад=@ск, остаток_зал=@зал WHERE id_серии=@id";
                        SqlCommand cmd = new SqlCommand(запрос, c);
                        cmd.Parameters.AddWithValue("@зак", decimal.Parse(GetText("tbЗакуп").Replace('.', ',')));
                        cmd.Parameters.AddWithValue("@роз", decimal.Parse(GetText("tbРозница").Replace('.', ',')));
                        cmd.Parameters.AddWithValue("@ск", int.Parse(GetText("tbСклад")));
                        cmd.Parameters.AddWithValue("@зал", int.Parse(GetText("tbЗал")));
                        cmd.Parameters.AddWithValue("@id", редактируемаяСтрока["id_серии"]);
                        cmd.ExecuteNonQuery();
                        BtnCeny_Click(null, null);
                    }

                    MessageBox.Show("Сохранено!");
                    СкрытьФорму();
                }
            }
            catch (Exception ex) { MessageBox.Show("Ошибка: " + ex.Message); }
        }

        private void BtnCancel_Click(object sender, RoutedEventArgs e) { СкрытьФорму(); }
        private void СкрытьФорму() { pnlForm.Visibility = Visibility.Collapsed; редактируемаяСтрока = null; }
        private void BtnLogout_Click(object sender, RoutedEventArgs e) { new MainWindow().Show(); this.Close(); }

        private void BtnDeleteRow_Click(object sender, RoutedEventArgs e)
        {
            if (!(sender is Button btn) || !(btn.DataContext is DataRowView row)) return;

            if (текущийРаздел == "Продажи" || текущийРаздел == "Отчёты")
            {
                MessageBox.Show("В этом разделе удаление запрещено!");
                return;
            }

            if (MessageBox.Show("Удалить эту запись?", "Подтверждение", MessageBoxButton.YesNo, MessageBoxImage.Question) != MessageBoxResult.Yes)
                return;

            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();
                    string idField = "";
                    string tableName = "";
                    int idValue = 0;

                    switch (текущийРаздел)
                    {
                        case "Товары":
                            idField = "id_товара";
                            tableName = "Товары";
                            idValue = (int)row[idField];
                            using (SqlCommand cmd = new SqlCommand("DELETE FROM Серии_партии WHERE id_товара = @id", c))
                            { cmd.Parameters.AddWithValue("@id", idValue); cmd.ExecuteNonQuery(); }
                            break;

                        case "Персонал":
                            idField = "id_сотрудника";
                            tableName = "Сотрудники";
                            idValue = (int)row[idField];
                            break;

                        case "Цены":
                            idField = "id_серии";
                            tableName = "Серии_партии";
                            idValue = (int)row[idField];
                            using (SqlCommand cmd = new SqlCommand("DELETE FROM Позиции_продажи WHERE id_серии = @id", c))
                            { cmd.Parameters.AddWithValue("@id", idValue); cmd.ExecuteNonQuery(); }
                            break;

                        case "Поставки":
                            idField = "id_поставки";
                            tableName = "Поставки";
                            idValue = (int)row[idField];
                            using (SqlCommand cmd = new SqlCommand(@"
                        DELETE FROM Позиции_продажи 
                        WHERE id_серии IN (SELECT id_серии FROM Серии_партии WHERE id_поставки = @id)", c))
                            { cmd.Parameters.AddWithValue("@id", idValue); cmd.ExecuteNonQuery(); }
                            using (SqlCommand cmd = new SqlCommand("DELETE FROM Серии_партии WHERE id_поставки = @id", c))
                            { cmd.Parameters.AddWithValue("@id", idValue); cmd.ExecuteNonQuery(); }
                            break;

                        default:
                            return;
                    }

                    using (SqlCommand cmd = new SqlCommand($"DELETE FROM {tableName} WHERE {idField} = @id", c))
                    {
                        cmd.Parameters.AddWithValue("@id", idValue);
                        cmd.ExecuteNonQuery();
                    }
                }

                MessageBox.Show("Удалено!");
                ОбновитьТекущий();
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка удаления: " + ex.Message);
            }
        }

        private void ДобавитьВыпадающийСписок(string подпись, string имя, string запрос, string полеID)
        {
            pnlFields.Children.Add(new TextBlock
            {
                Text = подпись,
                VerticalAlignment = VerticalAlignment.Center,
                Margin = new Thickness(5, 0, 3, 0),
                FontSize = 12
            });

            ComboBox cmb = new ComboBox
            {
                Name = имя,
                Width = 150,
                Height = 28,
                Margin = new Thickness(2, 0, 5, 0),
                DisplayMemberPath = "наименование",
                SelectedValuePath = полеID
            };

            try
            {
                using (SqlConnection c = new SqlConnection(conn))
                {
                    c.Open();
                    SqlDataAdapter adapter = new SqlDataAdapter(запрос, c);
                    DataTable таблица = new DataTable();
                    adapter.Fill(таблица);
                    cmb.ItemsSource = таблица.DefaultView;

                    if (cmb.Items.Count > 0) cmb.SelectedIndex = 0;
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка загрузки списка: " + ex.Message);
            }

            pnlFields.Children.Add(cmb);
        }

        private ComboBox GetComboBox(string имя)
        {
            foreach (var child in pnlFields.Children)
            {
                if (child is ComboBox cmb && cmb.Name == имя)
                    return cmb;
            }
            return null;
        }

        private void ОбновитьТекущий()
        {
            switch (текущийРаздел)
            {
                case "Товары": BtnTovary_Click(null, null); break;
                case "Цены": BtnCeny_Click(null, null); break;
                case "Персонал": BtnPersonal_Click(null, null); break;
                case "Поставки": BtnPostavki_Click(null, null); break;
                case "Продажи": BtnProdazhi_Click(null, null); break;
                case "Отчёты": BtnOtcety_Click(null, null); break;
            }
        }
    }
}