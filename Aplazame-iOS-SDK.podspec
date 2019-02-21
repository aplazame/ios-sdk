Pod::Spec.new do |spec|
    spec.name                   = "Aplazame-iOS-SDK"
    spec.authors                = "Aplazame, Inc."
    spec.version                = "0.4.1"
    spec.summary                = "Integrate Aplazame SDK into your iOS app"
    spec.homepage               = "https://github.com/Aplazame/ios-sdk"
    spec.license                = { :type => "BSD-3-Clause", :file => "LICENSE.txt" }
    spec.source                 = { :git => "https://github.com/Aplazame/ios-sdk.git", :tag => spec.version }
    spec.platform               = :ios, "9.0"
    spec.ios.deployment_target  = "9.0"
    spec.source_files           = 'Source/**/*.swift'
end
