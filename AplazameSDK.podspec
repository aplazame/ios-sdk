Pod::Spec.new do |spec|
    spec.name                   = "AplazameSDK"
    spec.authors                = "Aplazame, Inc."
    spec.version                = "0.0.1"
    spec.summary                = "Integrate Aplazame SDK into your iOS app"
    spec.homepage               = "https://github.com/Aplazame/ios-sdk"
    spec.license                = { :type => "BSD-3-Clause", :file => "LICENSE.txt" }
    spec.source                 = { :git => "https://github.com/Aplazame/ios-sdk.git", :tag => spec.version }
    spec.platform               = :ios, "8.0"
    spec.ios.deployment_target  = "8.0"
    spec.vendored_frameworks    = "AplazameSDK.framework"
    spec.public_header_files    = "AplazameSDK.framework/Headers/*.h"
end