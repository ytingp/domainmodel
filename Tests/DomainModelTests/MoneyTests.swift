import XCTest
@testable import DomainModel

class MoneyTests: XCTestCase {
  
  let tenUSD = Money(amount: 10, currency: "USD")
  let twelveUSD = Money(amount: 12, currency: "USD")
  let fiveGBP = Money(amount: 5, currency: "GBP")
  let fifteenEUR = Money(amount: 15, currency: "EUR")
  let fifteenCAN = Money(amount: 15, currency: "CAN")
  
  func testCanICreateMoney() {
    let oneUSD = Money(amount: 1, currency: "USD")
    XCTAssert(oneUSD.amount == 1)
    XCTAssert(oneUSD.currency == "USD")
    
    let tenGBP = Money(amount: 10, currency: "GBP")
    XCTAssert(tenGBP.amount == 10)
    XCTAssert(tenGBP.currency == "GBP")
  }
  
  func testUSDtoGBP() {
    let gbp = tenUSD.convert("GBP")
    XCTAssert(gbp.currency == "GBP")
    XCTAssert(gbp.amount == 5)
  }
  func testUSDtoEUR() {
    let eur = tenUSD.convert("EUR")
    XCTAssert(eur.currency == "EUR")
    XCTAssert(eur.amount == 15)
  }
  func testUSDtoCAN() {
    let can = twelveUSD.convert("CAN")
    XCTAssert(can.currency == "CAN")
    XCTAssert(can.amount == 15)
  }
 func testGBPtoUSD() {
    let usd = fiveGBP.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testEURtoUSD() {
    let usd = fifteenEUR.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 10)
  }
  func testCANtoUSD() {
    let usd = fifteenCAN.convert("USD")
    XCTAssert(usd.currency == "USD")
    XCTAssert(usd.amount == 12)
  }
  
  func testUSDtoEURtoUSD() {
    let eur = tenUSD.convert("EUR")
    let usd = eur.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoGBPtoUSD() {
    let gbp = tenUSD.convert("GBP")
    let usd = gbp.convert("USD")
    XCTAssert(tenUSD.amount == usd.amount)
    XCTAssert(tenUSD.currency == usd.currency)
  }
  func testUSDtoCANtoUSD() {
    let can = twelveUSD.convert("CAN")
    let usd = can.convert("USD")
    XCTAssert(twelveUSD.amount == usd.amount)
    XCTAssert(twelveUSD.currency == usd.currency)
  }
  
  func testAddUSDtoUSD() {
    let total = tenUSD.add(tenUSD)
    XCTAssert(total.amount == 20)
    XCTAssert(total.currency == "USD")
  }
  
  func testAddUSDtoGBP() {
    let total = tenUSD.add(fiveGBP)
    XCTAssert(total.amount == 10)
    XCTAssert(total.currency == "GBP")
  }
// Extra Credit
    func testSubUSDtoUSD() {
        let total = tenUSD.subtract(tenUSD)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    func testSubUSDtoGBP() {
        let total = tenUSD.subtract(fiveGBP)
        print(total)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
   func testSubUSDtoEUR() {
        let total = tenUSD.subtract(fifteenEUR)
        XCTAssert(total.amount == 0)
        XCTAssert(total.currency == "USD")
    }
    func testSubUSDtoCAN() {
        let total = tenUSD.subtract(fifteenCAN)
        print(total)
        XCTAssert(total.amount == -2)
        XCTAssert(total.currency == "USD")
    }
    func testAddUSDtoEUR() {
      let total = tenUSD.add(fifteenEUR)
      XCTAssert(total.amount == 10)
      XCTAssert(total.currency == "EUR")
    }
    func testAddUSDtoCAN() {
      let total = tenUSD.add(fifteenCAN)
      XCTAssert(total.amount == 10)
      XCTAssert(total.currency == "CAN")
    }
    func testUSDtoJPY() {
      let gbp = tenUSD.convert("JPY")
      XCTAssert(gbp.currency == "nil")
      XCTAssert(gbp.amount == 0)
    }
    // make this program only work with our own currencies
    func testCannotCreateMoney() {
      let oneUSD = Money(amount: 1, currency: "JPY")
      XCTAssert(oneUSD.amount == 0)
      XCTAssert(oneUSD.currency == "nil")
    }
    static var allTests = [
        ("testCanICreateMoney", testCanICreateMoney),

        ("testUSDtoGBP", testUSDtoGBP),
        ("testUSDtoEUR", testUSDtoEUR),
        ("testUSDtoCAN", testUSDtoCAN),
        ("testGBPtoUSD", testGBPtoUSD),
        ("testEURtoUSD", testEURtoUSD),
        ("testCANtoUSD", testCANtoUSD),
        ("testUSDtoEURtoUSD", testUSDtoEURtoUSD),
        ("testUSDtoGBPtoUSD", testUSDtoGBPtoUSD),
        ("testUSDtoCANtoUSD", testUSDtoCANtoUSD),
   
        ("testAddUSDtoUSD", testAddUSDtoUSD),
        ("testAddUSDtoGBP", testAddUSDtoGBP),
        
        //extra
        ("testSubUSDtoUSD", testSubUSDtoUSD),  //1
        ("testSubUSDtoGBP", testSubUSDtoGBP),  //2
        ("testSubUSDtoEUR", testSubUSDtoEUR),  //3
        ("testSubUSDtoCAN", testSubUSDtoCAN),  //4
        ("testAddUSDtoEUR", testAddUSDtoEUR),  //5
        ("testAddUSDtoCAN", testAddUSDtoCAN),  //6
        ("testUSDtoJPY", testUSDtoJPY),        //7
        ("testCannotCreateMoney", testCannotCreateMoney) //8
        
    ]
}

