using System;
using Microsoft.Data.Sqlite; 
using System.IO;

namespace sqliteapp {
    class Program
    {
        static void Main(string[] args)
        {
            //create a database file
            string filename = "bank.db";
            if (!File.Exists(filename))
            {
                Console.WriteLine("Creating database file...");
                SqliteConnectionStringBuilder connectionStringBuilder = new SqliteConnectionStringBuilder("Data Source=bank.db;Mode=ReadWriteCreate;");
            }
            //create a connection to the database
            string connectionString = $"Data Source={filename};";
            SqliteConnection connection = new SqliteConnection(connectionString);
            //open the connection
            connection.Open();
            //create a table
            string sql = "CREATE TABLE IF NOT EXISTS accounts (id INTEGER PRIMARY KEY, balance DECIMAL(10,2), deposits TEXT, withdrawals TEXT);";
            SqliteCommand command = new SqliteCommand(sql, connection);
            command.ExecuteNonQuery();
            //insert a record
            sql = "INSERT INTO accounts (balance, deposits, withdrawals) VALUES (10000.0, '[]', '[]');";
            command = new SqliteCommand(sql, connection);
            command.ExecuteNonQuery();
            //read the record
            sql = "SELECT * FROM accounts";
            command = new SqliteCommand(sql, connection);
            SqliteDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine($"Balance: {reader["balance"]}");
                Console.WriteLine($"Deposits: {reader["deposits"]}");
                Console.WriteLine($"Withdrawals: {reader["withdrawals"]}");
            }
            //close the connection
            connection.Close();
        }
    }
}


