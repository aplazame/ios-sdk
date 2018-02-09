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
paymentContext.requestCheckout(from: self, checkout: checkout, delegate: self, onPresent: {
     // Stop activity indicator       
})
```
The minimun information checkout object has to contain in order to work is: 
- `order`: the object that store all information related with the order. It has to contain, at least:
  - `shippingInfo`
  - `costumer`

```swift
let checkout = Checkout.create(order)
```

To create this `order` object use the following code:
```swift
let order = Order.create("orderID", locale: .current, taxRate: 20, totalAmount: 2000, discount: -362)
```
*NOTE:* orderID has to be different if any field changes.
`locale` is used to get the currency in this case.

To add `shippingInfo` and `costumer` to the order:
```swift
let address = Address.create("Fernando", lastName: "Cabello", street: "Torre Picasso, Plaza Pablo Ruiz Picasso 1", city: "Madrid", state: "Madrid", countryLocale: .current, postcode: "28020")
checkout.shippingInfo = .create("Fernando", price: 500, address: address)

checkout.customer = .create("140", email: "dev@aplazame.com", gender: .male, type: .existing)
```
Order also contains other field as:
- `articles`
- `discount`
- `discountRate`
- `cartDiscount`

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
redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

About
-----

https://aplazame.com/

