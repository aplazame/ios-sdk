import XCTest
@testable import AplazameSDK

class CheckoutTests: XCTestCase {
    
    fileprivate let basicConfig = APZConfig.createBasicConfig()
    
    func testOrderCreation_AddArticles() {
        var order = APZOrder.createRandomOrder()
        let fakeURL = URL(string: "http://www.google.com")!
        order.addArticle(.create("id1", name: "article 1", description: "description", url: fakeURL, imageUrl: fakeURL, price: 1000))
        order.addArticle(.create("id2", name: "article 2", description: "description", url: fakeURL, imageUrl: fakeURL, price: 2000))
        
        XCTAssertTrue(order.articles.count == 2, "2 Articles should be in APZOrder")
        XCTAssertNotNil(order.record["articles"])
    }
    
    func testCreateCheckout_WithBillingInfo() {
        var checkout = APZCheckout.create(.createRandomOrder())
        checkout.billingInfo = .createRandomAddress()
        
        XCTAssertNotNil(checkout.record(with: basicConfig)["billing"])
    }
    
    func testCreateCheckout_WithShippingInfo() {
        var checkout = APZCheckout.create(.createRandomOrder())
        checkout.shippingInfo = APZShippingInfo.create("Name", price: 1000, address: .createRandomAddress())
        
        XCTAssertNotNil(checkout.record(with: basicConfig)["shipping"])
    }
    
    func testCreateCheckout_WithCustomer() {
        var checkout = APZCheckout.create(.createRandomOrder())
        checkout.customer = .create("id", email: "email@mail.com", gender: .male, type: .new)
        
        XCTAssertNotNil(checkout.record(with: basicConfig)["customer"])
    }
}

