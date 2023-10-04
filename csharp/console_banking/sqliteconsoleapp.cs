using System; 
using System.Data.SQLite;
using System.IO;

 
            //create a database file
            string filename = "bank.db";
            if (!File.Exists(filename))
            {
                SQLiteConnection.CreateFile(filename);
            }
            //create a connection to the database
            string connectionString = $"Data Source={filename};Version=3;";
            SQLiteConnection connection = new SQLiteConnection(connectionString);
            //open the connection
            connection.Open();
            //create a table
            string sql = "CREATE TABLE IF NOT EXISTS accounts (id INTEGER PRIMARY KEY, balance DECIMAL(10,2), deposits DECIMAL(10,2), withdrawals DECIMAL(10,2))";
            SQLiteCommand command = new SQLiteCommand(sql, connection);
            command.ExecuteNonQuery();
            //insert a record
            sql = "INSERT INTO accounts (balance, deposits, withdrawals) VALUES (10000.0, '0', '0')";
            command = new SQLiteCommand(sql, connection);
            command.ExecuteNonQuery();
            //read the record
            sql = "SELECT * FROM accounts";
            command = new SQLiteCommand(sql, connection);
            SQLiteDataReader reader = command.ExecuteReader();
            while (reader.Read())
            {
                Console.WriteLine($"Balance: {reader["balance"]}");
                Console.WriteLine($"Deposits: {reader["deposits"]}");
                Console.WriteLine($"Withdrawals: {reader["withdrawals"]}");
            }
            //close the connection
            connection.Close();
        }

