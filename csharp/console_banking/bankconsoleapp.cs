using System ;
using System.Text.Json;

public class BankAccount
{
    public decimal totalDeposited = 0;
    public decimal totalWithdrawn = 0;
    public void saveChanges()
    {
        string filename = "records.json";
        string jsonString = JsonSerializer.Serialize(this);
        File.WriteAllText(filename, jsonString);
        Console.WriteLine("Changes saved");
    }
    public void UpdateBalance( ){

            foreach (var deposit in Deposits)
            {
                //change the color of the text to blue
                Console.ForegroundColor = ConsoleColor.Blue;
                Console.WriteLine($"Deposit: {deposit}");
                totalDeposited += deposit;
                DepositFunds(deposit);
            }
            Console.ForegroundColor = ConsoleColor.Red;
            Console.Write("Withdrawals: ");
            foreach (var withdrawal in Withdrawals)
            {
                Console.Write($"{withdrawal}, ");
                totalWithdrawn += withdrawal;
                WithdrawFunds(withdrawal);
            }
    }
    private void DepositFunds(decimal amount)
    {
        Balance += amount;
    }

    private void WithdrawFunds(decimal amount)
    {
        Balance -= amount;
    }
    public decimal Balance { get; set; }
    public decimal[] Deposits { get; set; }
    public decimal[] Withdrawals { get; set; }
    // RECORDS PROPERTY stores an array of deposits, withdrawals  
    
}



namespace ConsoleApp
{
    class Program
    {
        /// <summary>
        /// GetData method reads a json file and deserializes it
        /// </summary>
        /// <param name="filename">the name of the file to read</param>
        /// <returns>BankAccount object</returns>
        /// <exception cref="Exception">throws an exception if the file is null or there was an error retrieving the file</exception>
        static BankAccount GetData(string filename)
        {
            //read the json file
            var json = File.ReadAllText(filename);
            //deserialize the json file
            BankAccount? account = JsonSerializer.Deserialize<BankAccount>(json);
            if (account == null)
            {
                throw new Exception("Account is null or there was an error retrieving the file");
            }
            return account;
        }

        static decimal GetDifference(decimal newBalance, decimal oldBalance)
        {
            return newBalance - oldBalance;
        }

        /// <summary>
        /// main method is the entry point of the program
        /// </summary>
        static void Main(string[] args)
        {
            Console.ForegroundColor = ConsoleColor.Magenta;
            BankAccount account = GetData("records.json");            
            Console.WriteLine($"Balance before changes: {account.Balance}");
            decimal oldBalance = account.Balance;
            account.UpdateBalance();
            Console.WriteLine();
            if(GetDifference(account.Balance, oldBalance) > 0)
            {
                Console.ForegroundColor = ConsoleColor.Green;
                Console.WriteLine($"Balance increased by: {GetDifference(account.Balance, oldBalance)}");
                Console.WriteLine($"Balance after changes: {account.Balance}");

            }
            else if(GetDifference(account.Balance, oldBalance) < 0)
            {
                Console.ForegroundColor = ConsoleColor.Red;
                Console.WriteLine($"Balance decreased by: {GetDifference(account.Balance, oldBalance)}");
                Console.WriteLine($"Balance after changes: {account.Balance}");

            }
            else
            {
                Console.ForegroundColor = ConsoleColor.Yellow;
                Console.WriteLine($"Balance unchanged");
                Console.WriteLine($"Balance after changes: {account.Balance}");

            }
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.WriteLine($"Total deposited: {account.totalDeposited}");

            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Total withdrawn: {account.totalWithdrawn}");

            Console.ForegroundColor = ConsoleColor.Magenta;
            account.saveChanges();
        }
    }
}