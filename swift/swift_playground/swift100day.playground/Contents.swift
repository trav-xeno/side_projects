import UIKit
//const
let number = 19
//variable
var numberD: Double = 19.4

/* Values are never implicitly converted to another type. If you need to convert a value to a different type, explicitly make an instance of the desired type.
*/
let label = "The width is "
let width = 94
let widthLabel = label + String(width)


let apples = 3
let oranges = 5
let appleSummary = "I have \(apples) apples."
let fruitSummary = "I have \(apples + oranges) pieces of fruit."


let quotation = """
        Even though there's whitespace to the left,
        the actual lines aren't indented.
            Except for this line.
        Double quotes (") can appear without being escaped.

        I still have \(apples + oranges) pieces of fruit.
        """


var greeting = "Hello, playground"
print(greeting)
//array similar access to all but to remove you can use .remove(at: 1)
var ary = ["item1","item2"]
print(ary[0])
//can create an empty array like ary: string = [] you can add wtih append as well or empty [String: Int]()
var usr = [String: String]()
    usr["id", default:"unkown"]
    usr["usrname", default: "unknown"]
    usr["name", default:"unknown"]
usr["id"] = "123"
usr["usrname"] = "alyx123"
usr["name"] = "alyx"

var people = Set<String>()
people.insert("Denzel Washington")
people.insert("Tom Cruise")
people.insert("Nicolas Cage")
people.insert("Samuel L Jackson")

enum Weekday {
    case monday, tuesday, wednesday, thursday, friday,saturday,sunday
}
//example of handling optionals there is also if let and guard let, but  for this exmaple it works
let username = usr["usrname"] ?? "Nil"
print(Weekday.saturday)
print("username: \(username)")

//loop range 1..5 is one through 5 1..<5  1 to 5
// rnadom double Double.random(in: 0...1)   cahnge double to Int and boom whole number random inclusive range
func printTimesTables(number: Int) {
    for i in 1...number {
        print("\(i) x \(number) is \(i * number)")
    }
}

printTimesTables(number: 5)

//check same
func areLettersIdentical(string1: String, string2: String) -> Bool {
    return string1.sorted() == string2.sorted()
}
let result = areLettersIdentical(string1:"Borrow or rob", string2:"Borrow or rob")
print("are the strings the same \(result)")

//returns a dict swift doesn't know dicts values exsits so defulats are reqiured tuples not so much
func getUserDict() -> [String: String] {
    [
        "firstName": "neo",
        "lastName": "vim"
    ]
}

let userDict = getUserDict()
print("Name: \(userDict["firstName", default: "Anonymous"]) \(userDict["lastName", default: "Anonymous"])")


//returns a tuple
func getUserTuple() -> (firstName: String, lastName: String) {
    (firstName: "neo", lastName: "vim")
}

let userTuple = getUserTuple()
let (firstName, _) = getUserTuple()//ignores lastname part of the tuple
print("Name: \(userTuple.firstName) \(userTuple.lastName)")
print("first part of the tuple: \(firstName)")


/* instead of for you can omit it with _
 func printTimesTables(for number: Int) {
     for i in 1...12 {
         print("\(i) x \(number) is \(i * number)")
     }
 }

 printTimesTables(for: 5)
 There are three things in there you need to look at closely:

 We write for number: Int: the external name is for, the internal name is number, and it’s of type Int.
 When we call the function we use the external name for the parameter: printTimesTables(for: 5).
 Inside the function we use the internal name for the parameter: print("\(i) x \(number) is \(i * number)").
 */

//trhwoing errors
enum PasswordError: Error{
    case short,weak,obvious
}

func checkPassword(password:String) throws -> String {
    var pwdStatus = ""
    if password.count < 5 {
         throw PasswordError.short
     }

 
     if password == "12345" {
         throw PasswordError.obvious
     }

    let charset = CharacterSet(charactersIn: "!+=_@.#$%^&*")
    let letterDigit = CharacterSet.alphanumerics
    if password.rangeOfCharacter(from: charset) == nil {
        throw PasswordError.weak
    }
    
    if password.rangeOfCharacter(from: charset) != nil && password.count >= 8 {
        return "strong"
    } else if  password.count < 8 && password.count > 5 && password.rangeOfCharacter(from: letterDigit) != nil {
        return "Ok"
    } else if password.count < 10 && password.count > 8 {
         return "Good"
     } else {
         return "Excellent"
     }
    
}
let badpwd = "asdf"
let weakpwd = "asdfef333"
let mehpwd = "@dd333"
let perfectpwd = "@3dFe98#0er"
var pwdresult = ""
//Now try
do {
    pwdresult = try checkPassword(password: mehpwd)
    print(pwdresult)
    pwdresult = try checkPassword(password: perfectpwd)
    print(pwdresult)
} catch PasswordError.short {
        print("pwd too shrot")
} catch PasswordError.weak {
    print("pwd needs specail chacters")
} catch PasswordError.obvious {
    print("12345 is dumb stop")
}

//or this way
let pwdresult1 = (try? checkPassword(password: badpwd) ) ?? "fail"
let pwdresult2 = (try? checkPassword(password: weakpwd) ) ?? "failure"
print("is vaild pwdresult1: \(pwdresult1) is pwdresult2 valid: \(pwdresult2)")
//closures
let team = ["Gloria", "Suzanne", "Piper", "Tiffany", "Tasha"]
let captainFirstTeam = team.sorted { name1, name2 in
    if name1 == "Suzanne" {
        return true
    } else if name2 == "Suzanne" {
        return false
    }

    return name1 < name2
}
print(captainFirstTeam)
//short hand closure they have sort, map, filter where closures are used
let reverseTeam = team.sorted { $0 > $1 }
print(reverseTeam)



//func passing func
func generateNumber() -> Int {
    Int.random(in: 1...20)
}

func makeArray(size: Int, using generator: () -> Int) -> [Int] {
    var numbers = [Int]()

    for _ in 0..<size {
        let newNumber = generator()
        numbers.append(newNumber)
    }

    return numbers
}


let newRolls = makeArray(size: 20, using: generateNumber)
print(newRolls)

//structs
struct Element {
    let atomicNumber: Int
    let atomicMass: Double
    let name: String
    let symbol: String
    let group: String
    //add Electron Configuration, melting point, denisty for fun
    //remind mutating func for those that change data of struct
    func printSummary(){
        print("""
            Element
                \(atomicNumber)
                \(symbol)
            \(name)
            \(atomicMass) u
            \(group)
        """)
    }
    
}
let ti = Element(atomicNumber: 22, atomicMass: 47.867, name: "Titanium", symbol: "Ti", group: "Transition Metal")
ti.printSummary()

//justa basic account struct there should be safety checks and some immutable propteries along with a queue of pending transactions idk
struct BankAccount {
    private var balance: Double
    
    init(funds: Double){
        self.balance = funds
    }
    
    
    func accountBalance() -> Double{
        return balance
    }
    
    mutating func deposit(amount: Double) {
        balance += amount
    }
    

    mutating func withdraw(amount: Double) -> Bool {
        if balance >= amount {
            balance -= amount
            return true
        } else {
            return false
        }
    }
}
var account = BankAccount(funds:2000.0)

account.deposit(amount: 100.0)
let success = account.withdraw(amount: 240.55)

if success {
    print("Withdrew money successfully")
} else {
    print("Failed to withdraw the money. Not enough funds")
}
print("current balance \(account.accountBalance())")



//Generally speaking I know some of these design descions aren't great. I just wanted to mess around
enum Vehicle:String {
    case Bike, Car, Truck, Bus, Train, Walk
}
//swift version of interfaces called protocols completely fogot about this
protocol TransportationMode {
    var type: Vehicle { get }
    func estimateTime(for distance: Int) -> Int
    func travel(distance: Int)
}



//basic implements protocol
struct Car: TransportationMode {
    let type = Vehicle.Car
    func estimateTime(for distance: Int) -> Int {
        distance / 50
    }

    func travel(distance: Int) {
        print("I'm driving \(distance)km.")
    }

    func openSunroof() {
        print("It's a nice day!")
    }
}





func commute(distance: Int, using vehicle: TransportationMode) {
    if vehicle.estimateTime(for: distance) > 100 {
        print("That's too slow! I'll try a different vehicle.")
    } else {
        vehicle.travel(distance: distance)
    }
}

func getTravelEstimates(using vehicles: [TransportationMode], distance: Int) {
    for vehicle in vehicles {
        let estimate = vehicle.estimateTime(for: distance)
        print("\(vehicle.type): \(estimate) hours to travel \(distance)km")
    }
}

struct Bicycle: TransportationMode {
    let type = Vehicle.Bike
    var passengerCount = 1
    
    func estimateTime(for distance: Int) -> Int {
        distance / 10
    }

    func travel(distance: Int) {
        print("I'm cycling \(distance)km.")
    }
}



let car = Car()
let bike = Bicycle()
commute(distance: 100, using: car)
getTravelEstimates(using: [bike, car], distance: 89)


//practice on extensions forgot about these as well
//extneding type functionality similar to protoype in javascript
//trimed and trim naming convention (this as well) one returns new stored while trim does it inplace
extension String {
    //trimspaces returns new string
    func trimmedSpaces() -> String {
           self.trimmingCharacters(in: .whitespacesAndNewlines)
       }
    mutating func trimSpaces() {
        self = self.trimmedSpaces()
    }
    //might be useful for certain times but wanted to practice
    var lines: [String]{
        self.components(separatedBy: .newlines)
    }
}
let trimStr = "  trying out triming  "
let trimedStr = trimStr.trimmedSpaces()
print("String prior to trimming: \(trimStr) after: \(trimedStr)")
let multilineSTr = """
Wiriting code is fun.
But you really have to stay on top of tech changes and its easy to forget aspects.
Db's are more often then not a bottleneck.
Git is a god sent and a monster all in one happy contradiction.
Microservices can make certian projects easier or becomes a headache waiting to happen.
Java has some uses, but oh boy is it annoying to write everything in object and inheritance can create a nightmare if design patterns are viewed more like guidlines then sctrict set of rules.
My favorite programming languages are in no particular order, Go, Rust, Zig, Kotlin, Nim, python, javascript, Elixir, Ocaml, Haskell, and C#.
My favorite frameowkrs are, Svelte, Django, Fastapi, Spring boot(kotlin/java), Vue 3, Tauri, Angular, React, C# excosystem, Bevy, Pytorch, Pheonix, Hapi.js, Express.js, Meteor.js.
That should cover many technologies and to behonest things chagne to offten that these lists will most likely change.
"""
let lineCount = multilineSTr.lines.count
let linesInMsg = multilineSTr.lines

print("line count: \(lineCount)  ")
for line in linesInMsg {
    print(line)
}


 /* handling optionals one way
  guard let is similar but in reverse of if let   so else goes first then normal code after
  var username: String? = nil

  if let unwrappedName = username {
      print("We got a user: \(unwrappedName)")
  } else {
      print("The optional was empty.")
  }
  below handling multiple optionals
  */

let names = ["Arya", "Bran", "Robb", "Sansa"]

let chosen = names.randomElement()?.uppercased() ?? "No one"
print("Next in line: \(chosen)")


