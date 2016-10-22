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
pod 'AplazameSDK-iOS'
```

Then run `pod install` with CocoaPods 1.0 or newer.

### How to use ###
`AplazameCheckoutViewController` needs two object in order to work:
- `checkout`: it is the object where all information regarding with checkout is.
- `delegate`: class that will receive payment flow callbacks.

```swift
AplazameSDK.present(from: navigationController!, checkout: checkout, delegate: self)
```

The minimun information checkout object has to contain in order to work is: 
- `config`: object that stores access token and environment (.Sanbox or .Production)
- `order`: the object that store all information related with the order. It has to contain, at least:
  - `shippingInfo`
  - `costumer`

```swift
let config = Config(accessToken: "your access token", environment: .Sandbox)
let checkout = Checkout.create(order, config: config)
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

checkout.customer = .create("140", email: "dev@aplazame.com", gender: .Male, type: .Existing)
```
Order also contains other field as:
- `articles`
- `discount`
- `discountRate`
- `cartDiscount`

Check the [demo project](https://github.com/aplazame/ios-sdk/tree/andresbrun-readme/Aplazame-ios-sdk-demo) to see an example of their use.

Next, you will need an object that conform to `AplazameCheckoutDelegate` protocol. this object will receive following calls:

```swift
extension ViewController: AplazameCheckoutDelegate {
    func checkoutDidCancel() {
         print("checkoutDidCancel")
    }
    
    func checkoutDidSuccess() {
         print("checkoutDidSuccess")
    }
    
    func checkoutFinished(with error: Error) {
        print("checkoutDidFinishWithError \(error.localizedDescription)")
    }

    func checkoutHandleCheckoutToken(token: String, handler: (success: Bool) -> Void) {
        print("checkoutHandleCheckoutToken \(token)")
        // Here is where token has to be verified with you own service
        handler(success: true)
    }
}
```

License
-------

Aplazame is Copyright (c) 2016 Aplazame, inc. It is free software, and may be
redistributed under the terms specified in the [LICENSE] file.

[LICENSE]: /LICENSE

About
-----

https://aplazame.com/

