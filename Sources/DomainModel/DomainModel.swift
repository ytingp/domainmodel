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
        self.amount = amount
        self.currency = currency
    }
    func convert(_ newCurr: String) -> (amount: Int, currency: String) {
        var amount = 0
        var currency = ""
        if self.currency == "USD" {
            if newCurr == "GBP" {
                amount = self.amount / 2
                currency = "GBP"
            } else if newCurr == "EUR" {
                amount = (self.amount * 1) + (self.amount / 2)
                currency = "EUR"
                func convert(_ curr: String) -> (amount: Int, currency: String) {
                    return (amount: amount, currency: curr)
                }

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
        return (amount: amount, currency: currency)
        
    }
    
    func add(_ count: Money) -> (amount: Int, currency: String) {
        var total = 0
        if count.currency == "USD" && self.currency == "USD" {
            total = count.amount + self.amount
        }
        
        if count.currency == "GBP" && self.currency == "USD" {
            let newAmount = count.convert("GDB").amount
            total = newAmount + self.amount
        }
        return (amount: total, currency: count.currency)
    }
}

////////////////////////////////////
// Job
//
/*public class Job {
    let title: String
    let type: JobType
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
            let wage = Int(double)
            return wage * time
        case .Salary(let uInt):
            return Int(uInt)
        }
    }
    
    func raise(byAmount: Int) -> Int {
        Int(self.type.Salary(UInt)
        
    }
    
    func raise(byAmount: Double) -> Int {
        return -1
    }
    
    func raise(byPercent: Double) -> Int {
        return 1200
    }
}

////////////////////////////////////
// Person
//
public class Person {
}

////////////////////////////////////
// Family
//
public class Family {
}*/
