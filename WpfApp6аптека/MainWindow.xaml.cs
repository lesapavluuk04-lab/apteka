using System;
using System.Windows;
using Microsoft.Data.SqlClient;

namespace WpfApp
{
    public partial class MainWindow : Window
    {
        
        string conn = @"Data Source=олеся\SQLEXPRESS;Initial Catalog=аптека1;Integrated Security=True;TrustServerCertificate=True";

        public MainWindow()
        {
            InitializeComponent();
        }

      
        private void BtnLogin_Click(object sender, RoutedEventArgs e)
        {
            string логин = txtLogin.Text.Trim();
            string пароль = txtPassword.Password;

            if (логин == "" || пароль == "")
            {
                lblStatus.Text = "Заполните логин и пароль!";
                return;
            }

            try
            {
                SqlConnection connection = new SqlConnection(conn);
                connection.Open();

                string запрос = "SELECT фио, роль FROM Сотрудники WHERE логин = @л AND пароль_hash = @п";
                SqlCommand command = new SqlCommand(запрос, connection);
                command.Parameters.AddWithValue("@л", логин);
                command.Parameters.AddWithValue("@п", пароль);

                SqlDataReader reader = command.ExecuteReader();

                if (reader.Read())
                {
                    string фио = reader["фио"].ToString() !;
                    string роль = reader["роль"].ToString() !;

                    reader.Close();
                    connection.Close();

                   
                    if (роль == "Администратор")
                    {
                        new AdminWindow(фио).Show();
                    }
                    else if (роль == "Фармацевт-кассир")
                    {
                        new FarmacevtWindow(фио).Show();
                    }
                    else
                    {
                        lblStatus.Text = "Роль не найдена";
                        return;
                    }

                    this.Close();
                }
                else
                {
                    lblStatus.Text = "Неверный логин или пароль!";
                    reader.Close();
                    connection.Close();
                }
            }
            catch (Exception ex)
            {
                MessageBox.Show("Ошибка: " + ex.Message);
            }
        }
    }
}