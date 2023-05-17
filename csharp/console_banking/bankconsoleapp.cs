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
            //loop through the deposits array
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
                //change the color of the text to red
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



//create a namespace called ConsoleApp then a class called program
namespace ConsoleApp
{
    class Program
    {

        //create a methoed called GetData, which takes in a string called filename and read a json file
        static BankAccount GetData(string filename)
        {
            //read the json file
            var json = File.ReadAllText(filename);
            //deserialize the json file
            BankAccount? account = JsonSerializer.Deserialize<BankAccount>(json);
            if (account == null)
            {
                throw new Exception("Account is null");
            }
            return account;
        }

        //create a funtion that take in a new balance and a oldbalance and return the difference
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
            //change the color of the text to blue
            Console.ForegroundColor = ConsoleColor.Blue;
            Console.WriteLine($"Total deposited: {account.totalDeposited}");
            //change the color of the text to red
            Console.ForegroundColor = ConsoleColor.Red;
            Console.WriteLine($"Total withdrawn: {account.totalWithdrawn}");
            //change the color of the text to magenta
            Console.ForegroundColor = ConsoleColor.Magenta;
            account.saveChanges();
        }
    }
}