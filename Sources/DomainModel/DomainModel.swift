import Darwin
struct DomainModel {
    var text = "Hello, World!"
        // Leave this here; this value is also tested in the tests,
        // and serves to make sure that everything is working correctly
        // in the testing harness and framework.
}

////////////////////////////////////
// Money
//
public struct Money {
    var amount: Int
    var currency: String
    init(amount: Int, currency: String) {
        if(currency != "USD" || currency != "CAN" || currency != "EUR" || currency != "GBP") {
            self.amount = 0
            self.currency = "nil"
        } else {
            self.amount = amount
            self.currency = currency
        }
    }
    
    func convert(_ newCurr: String) -> Money {
        if(newCurr != "USD" || newCurr != "CAN" || newCurr != "EUR" || newCurr != "GBP") {
            return Money(amount: 0, currency: "nil")
        }
        var amount = 0
        var currency = ""
        if self.currency == "USD" {
            if newCurr == "GBP" {
                amount = self.amount / 2
                currency = "GBP"
            } else if newCurr == "EUR" {
                amount = (self.amount * 1) + (self.amount / 2)
                currency = "EUR"
            } else if newCurr == "CAN" {
                amount = (self.amount * 1) + (self.amount / 4)
                currency = "CAN"
            }
        } else if self.currency == "GBP" {
            if newCurr == "USD" {
                amount = self.amount * 2
                currency = "USD"
            }
        } else if self.currency == "EUR" {
            if newCurr == "USD" {
                amount = self.amount / 3 * 2
                currency = "USD"
            }
        } else if self.currency == "CAN" {
            if newCurr == "USD" {
                amount = self.amount / 5 * 4
                currency = "USD"
            }
        }
        return Money(amount: amount, currency: currency)
    }
    
    func add(_ count: Money) -> Money {
        var total = 0
        if count.currency == "USD" && self.currency == "USD" {
            total = count.amount + self.amount
        } else {
            let newAmount = count.convert(count.currency).amount
            total = newAmount + self.amount
        }
        return Money(amount: total, currency: count.currency)
    }
    func subtract(_ count: Money) -> Money {
        var total = 0
        if count.currency == "USD" && self.currency == "USD" {
            total = count.amount - self.amount
        }
        let newAmount = count.convert(self.currency).amount
        total = self.amount - newAmount
        
        return Money(amount: total, currency: self.currency)
    }
    
}

////////////////////////////////////
// Job
//
public class Job {
    var title: String
    var type: JobType
    
    init(title: String, type: JobType) {
        self.title = title
        self.type = type
    }
    public enum JobType {
        case Hourly(Double)
        case Salary(UInt)
    }
    func calculateIncome(_ time: Int) -> Int {
        switch type {
        case .Hourly(let double):
            let newTime = Double(time)
            return Int(double * newTime)
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    func raise(byAmount: Int) {
        switch type {
        case .Hourly(_):
            print("Hourly by Int")
        case .Salary(let uInt):
            let amount: UInt = UInt(byAmount)
            type = .Salary(uInt + amount)
        }
    }
    func raise(byAmount: Double) {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double + byAmount)
        case .Salary(let UInt):
            print(UInt)
        }
    }
    func raise(byPercent: Double) {
        switch type {
        case .Hourly(let double):
            type = .Hourly(double * byPercent + double)
        case .Salary(let uInt):
            let percent = UInt(byPercent * 100.0)
            type = .Salary(uInt + (uInt / percent))
        }
    }
}

////////////////////////////////////
// Person
//
public class Person {
    let firstName: String
    let lastName: String
    let age: Int
    
    init(firstName: String, lastName: String, age: Int) {
        self.firstName = firstName
        self.lastName = lastName
        self.age = age
    }
    
    var job: Job? = nil {
        didSet {
            if age < 16 {
                job = nil
            }
        }
    }
    var spouse: Person? = nil {
        didSet {
            if self.age < 18 {
                spouse = nil
            }
        }
    }
    func toString() -> String {
        let string = ("[Person: firstName:\(firstName) lastName:\(lastName) age:\(age) job:\(job?.title ?? "nil") spouse:\(spouse?.firstName ?? "nil")]")
        return string
    }
}

////////////////////////////////////
// Family
//
public class Family {
    var members: [Person] = []
    init(spouse1: Person, spouse2: Person) {
        if(spouse1.spouse == nil && spouse2.spouse == nil) {
            spouse1.spouse = spouse2
            spouse2.spouse = spouse1
            members = [spouse1, spouse2]
        }
    }
    
    func householdIncome() -> Int {
        var totalIncome = 0
        print(members)

        for member in members {
            let annualIncome = member.job?.calculateIncome(2000) ?? 0
            print(annualIncome)
            totalIncome += annualIncome
        }
        return totalIncome
    }
    func haveChild(_ child: Person) -> Bool{
        if members[0].age <= 21 || members[1].age <= 21 {
            return false
        } else {
            members.append(child)
            return true
        }
    }
}
