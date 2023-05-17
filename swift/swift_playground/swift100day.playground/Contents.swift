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
let username = usr["usrname"]
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
        "firstName": "Taylor",
        "lastName": "Swift"
    ]
}

let userDict = getUserDict()
print("Name: \(userDict["firstName", default: "Anonymous"]) \(userDict["lastName", default: "Anonymous"])")


//returns a tuple
func getUserTuple() -> (firstName: String, lastName: String) {
    (firstName: "Taylor", lastName: "Swift")
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
    //pwdresult = try checkPassword(password: badpwd)
    //pwdresult = try checkPassword(password: weakpwd)
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


