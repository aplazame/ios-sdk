[![CocoaPods Compatible](https://img.shields.io/cocoapods/v/Aplazame-iOS-SDK.svg)](https://img.shields.io/cocoapods/v/Aplazame-iOS-SDK.svg)
[![Carthage compatible](https://img.shields.io/badge/Carthage-compatible-4BC51D.svg?style=flat)](https://github.com/Carthage/Carthage)
# Aplazame #

<Description>

[tb-Aplazame]: https://aplazame.com/

## Installation ##

### [Carthage] ###

[Carthage]: https://github.com/Carthage/Carthage

```
github "Aplazame/ios-sdk"
```

Then run `carthage update`.

Follow the current instructions in [Carthage's README][carthage-installation]
for up to date installation instructions.

[carthage-installation]: https://github.com/Carthage/Carthage#adding-frameworks-to-an-application

### [CocoaPods] ###

[CocoaPods]: http://cocoapods.org

Add the following to your [Podfile](http://guides.cocoapods.org/using/the-podfile.html):

```ruby
pod 'Aplazame-iOS-SDK'
```

Then run `pod install` with CocoaPods 1.0 or newer.

### How to use ###
First at all you need to create an instance of `APZPaymentContext` with the `APZConfig` object:
```swift
let config = APZConfig(accessToken: token, environment: .sandbox)

let paymentContext = APZPaymentContext(config: APZConfig(accessToken: "your-token-here", environment: .sandbox | .production))
```

Then you can check if Aplazame is available for your order. The best way to do it is to call:
```swift
paymentContext.checkAvailability(amount: 12050, currency: "EUR") { (status) in
  switch status {
    case .available:
      // Enable checkout button for instance
    case .notAvailable, .undefined:
      // Hide the checkout button for instance
    }
  }
```

After this check you need to request the checkout presentation. `AplazameSDK` needs 3 objects ito do this:
- `checkout`: it is the object where all information regarding with checkout is.
- `delegate`: class that will receive payment flow callbacks.
- `onReady`: will be called when the checkout is ready to be presented.

```swift
// Start activity indicator
paymentContext.requestCheckout(checkout: checkout, delegate: self, onReady: { vc in
  // Stop activity indicator
  self.navigationController?.pushViewController(vc, animated: true)
})
```
or the SDK provides a helper method with a default presentation:
```swift
// Start activity indicator
paymentContext.requestCheckout(from: self, checkout: createCheckout(), delegate: self, onPresent: {
     // Stop activity indicator       
})

func createCheckout() -> [String: Any] {	
	let article: [String: Any] = [
		"id": "89793238462643383279",                             // The article ID.
		"name": "Reloj en oro blanco de 18 quilates y diamantes", // Article name.
		"url": "http://shop.example.com/product.html",            // Article url.
		"image_url": "http://shop.example.com/product_image.png", // Article image url.
		"quantity": 2,                                            // Article quantity.
		"price": 402000,                                          // Article price (tax is not included). (4,020.00 €)
		"description": "Movimiento de cuarzo de alta precisión",  // Article description.
		"tax_rate": 2100,                                         // Article tax rate. (21.00 %)
		"discount": 500,                                          // The discount amount of the article. (5.00 €)
		"discount_rate": 200,                                     // The rate discount of the article. (2.00 %)
	]

	/*
	 * Articles collection
	 */
	let articles: [[String: Any]] = [
		article,
		// ... rest of articles in the shopping cart.
	]
	
	/*
	 * Order model
	 */
	let order: [String: Any] = [
		"id": "28475648233786783165", // Your order ID.
		"currency": "EUR",            // Currency code of the order.
		"tax_rate": 2100,             // Order tax rate. (21.00 %)
		"total_amount": 402000,       // Order total amount. (4,620.00 €)
		"articles": articles,         // Articles in cart.
		"discount": 16000,            // The discount amount of the order. (160.00 €)
		"discount_rate": 200,         // The rate discount of the order. (2.00 %)
		"cart_discount": 050,         // The discount amount of the cart. (0.50 €)
		"cart_discount_rate": 300,    // The rate discount of the cart. (3.00 %)
	]
	
	/*
	 * Customer address model
	 */
	let customerAddress: [String: Any] = [
		"first_name": "John",                              // Address first name.
		"last_name": "Coltrane",                           // Address last name.
		"street": "Plaza del Angel nº10",                  // Address street.
		"city": "Madrid",                                  // Address city.
		"state": "Madrid",                                 // Address state.
		"country": "ES",                                   // Address country code.
		"postcode": "28012",                               // Address postcode.
		"phone": "616123456",                              // Address phone number.
		"alt_phone": "+34917909930",                       // Address alternative phone.
		"address_addition": "Cerca de la plaza Santa Ana", // Address addition.
	]
	
	/*
	 * Customer model
	 */
	let customer: [String: Any] = [
		"id": "1618",                          // Customer ID.
		"email": "dev@aplazame.com",           // The customer email.
		"type": "e",                           // Customer type, the choices are g:guest, n:new, e:existing.
		"gender": 0,                           // Customer gender, the choices are 0: not known, 1: male, 2:female, 3: not applicable.
		"first_name": "John",                  // Customer first name.
		"last_name": "Coltrane",               // Customer last name.
		"birthday": "1990-08-21",              // Customer birthday.
		"language": "es",                      // Customer language preferences.
		"date_joined": "2014-08-21T13:56:45Z", // A datetime designating when the customer account was created.
		"last_login": "2014-08-27T19:57:56Z",  // A datetime of the customer last login.
		"address": customerAddress,            // Customer address.
	]
	
	
	/*
	 * Billing address model
	 */
	let billingAddress: [String: Any] = [
		"first_name": "Bill",                        // Billing first name.
		"last_name": "Evans",                        // Billing last name.
		"street": "Calle de Las Huertas 22",         // Billing street.
		"city": "Madrid",                            // Billing city.
		"state": "Madrid",                           // Billing state.
		"country": "ES",                             // Billing country code.
		"postcode": "28014",                         // Billing postcode.
		"phone": "+34914298407",                     // Billing phone number.
		"address_addition":  "Cerca de la pizzería", // Billing address addition.
	]
	
	
	/*
	 * Shipping info model
	 */
	let shippingInfo: [String: Any] = [
		"first_name": "Django",                            // Shipping first name.
		"last_name": "Reinhard",                           // Shipping last name.
		"street": "Plaza del Angel nº10" ,                 // Shipping street.
		"city": "Madrid",                                  // Shipping city.
		"state": "Madrid",                                 // Shipping state.
		"country": "ES",                                   // Shipping country code.
		"postcode": "28012",                               // Shipping postcode.
		"name": "Planet Express",                          // Shipping name.
		"price": 500,                                      // Shipping price (tax is not included). (5.00 €)
		"phone": "616123456",                              // Shipping phone number.
		"alt_phone": "+34917909930",                       // Shipping alternative phone.
		"address_addition": "Cerca de la plaza Santa Ana", // Shipping address addition.
		"tax_rate": 2100,                                  // Shipping tax rate. (21.00 %)
		"discount": 100,                                   // The discount amount of the shipping. (1.00 €)
		"discount_rate": 200,                              // The rate discount of the shipping. (2.00 %)
	]
	
	
	/*
	 * Checkout model
	 */
	let checkout: [String: Any] = [
		"toc": true,
		"order": order,
		"customer": customer,
		"billing": billingAddress,
		"shipping": shippingInfo,
	]
	
	return checkout
}
```

Check the [demo project](/Aplazame-ios-sdk-demo) to see an example of their use.

Next, you will need an object that conform to `APZPaymentContextDelegate` protocol. This object will receive the following calls:

```swift
extension ViewController: APZPaymentContextDelegate {
  func checkoutDidClose(checkoutVC: UIViewController, with reason: APZCheckoutCloseReason) {
    print("checkoutDidCloseWithReason \(reason.rawValue)")
    checkoutVC.dismiss(animated: true, completion: nil)
  }
    
  func checkoutStatusChanged(with status: APZCheckoutStatus) {
    print("checkoutStatusChanged \(status.rawValue)")
  }
}
```

License
-------

Aplazame is Copyright (c) 2017 Aplazame, inc. It is free software, and may be
redistributed under the terms specified in the [LICENSE](/LICENSE.txt) file.

About
-----

https://aplazame.com/

