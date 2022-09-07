## Overview
VPartnerLib is a SDK that allows Partners to easily integrate Vodafone World into their apps.
The SDK will allow partners to centralize and do everything related with their devices under one app. This means:

- Onboard users into the Vodafone CIoT Platform, being the users Vodafone or Non-Vodafone.
- Manage their device subscriptions. This includes, adding, editing, removing and perform paying operations related to their devices and subscriptions. 

The SDK is built under Vodafone's design system, but allows for the Partners to use their own logos and colours for a seamless experience. 

### Requirements
- XCode 12.5
- iOS 12.0+
- IDTM, SecLib and FirebaseInstanceID frameworks, [check Setup section](#setup)

### Supported Architectures
The following architectures are supported by VPartnerLib .xcframework
- arm64
- x86_64_simulator

## Setup
Start by taking a look at the example project provided in this Repo. 
You'll find a `setup.sh` script that will download the required frameworks into your project. Feel free to modify it to suit your needs.

**Usage:** `sh setup.sh`
The script prints on the terminal if something goes wrong or not. If something is wrong, feel free to [contact the SquaDK team](#contact).

### Cocoapods
As seen on `setup.sh`, the script also executes the `pod` configuration. Like mentioned above, you are free to modify the script, but you must guarantee the following pods are part of your `Podfile`:

```ruby
  pod 'ReactiveCocoa', '~> 10.1'
  pod 'ReactiveSwift', '~> 6.1'
  pod 'SwiftLint'
  pod 'ASN1Decoder'
  pod 'PhoneNumberKit', '~> 3.3'
  pod 'Firebase/Core'
  pod 'Firebase/Installations'
  pod 'Firebase/Messaging'
  pod 'JumioMobileSDK', '~>3.7.1'
```

Also, make sure you use `use_frameworks!` to avoid issues while building and running your project.

## Integration

### Keys
In order to run the SDK a `ClientID` and `GrantID` are necessary.
Each partner is entitled to one. Contact the SquaDK team in order to get these keys.

### GoogleService-info.plist
Since the SDK uses Firebase, a GoogleService-info.plist is required to run the `FirebaseApp.configure()` function. 
Therefore you'll need to [add Firebase to your project](#https://firebase.google.com/docs/ios/setup?hl=pt).

### Required Permissions
In order to run the SDK the following permissions are required under your `.plist` file:
- NSCameraUsageDescription
- NSContactsUsageDescription
- NSPhotoLibraryUsageDescription

## Usage

Please refer to `ViewController.swift` to check the function calls you'll require to see a usage example of the SDK. Bellow you can find a list with the functions provided by the SDK:

```swift
    /// Required setup of the mandatory fields
    /// - Parameters:
    ///   - clientID: identification of the client - required
    ///   - grantID: Grant identification - required
    ///   - partnerCode: Code of the Partner - required
    ///   - productCode: Code of the Product - required
    ///   - appIconName: Name of the image that partner wants to display on splashscreen - optional (default - nil)
    ///   - sponsorIconName: Name of the sponsor image that partner wants to display on splashscreen - optional (default - Connected by Vodafone white logo)
    ///   - Locale: Country code used for Terms & Conditions/Privacy & Policy URLs, before the IDTM Login (OPTIONS: uk, de, es, it, ze) (default - SIM card locale)
    public func requiredSetup(clientID: String, grantID: String, partnerCode: String, productCode: String, appIconName: String? = nil, sponsorIconName: String? = nil, locale: String? = nil)
    
    /// Required setup of the mandatory fields
    /// - Parameters:
    ///   - partnerPassword: Partner Password - required
    ///   - partnerCode: Code of the Partner - required
    ///   - productCode: Code of the Product - required
    ///   - appIconName: Name of the image that partner wants to display on splashscreen - optional (default - nil)
    ///   - sponsorIconName: Name of the sponsor image that partner wants to display on splashscreen - optional (default - Connected by Vodafone white logo)
    ///   - Locale: Country code used for Terms & Conditions/Privacy & Policy URLs, before the IDTM Login (OPTIONS: uk, de, es, it, ze) (default - SIM card locale)
    public func requiredSetup(partnerPassword: String, partnerCode: String, productCode: String, appIconName: String? = nil, sponsorIconName: String? = nil, locale: String? = nil)
    
    /// Configure a local theme
    /// - Parameter designConfig: the design theme if no design is passed it will accept the default
    public func configure(designConfig: VPartnerLib.ConfigurationsDesign = ConfigurationsDesign.defaultDesignConfiguration)
    
    /// Logout user
    /// - Returns: Boolean indicating if the logout from IDTM was successful or not
    public func logoutUserFromIDTM(completionHandler: @escaping (Bool) -> Void)
    
    /// Build entry point to the manager of subscription
    /// - Returns: Entry point controller
    @available(*, deprecated, message: "That function will be deprecated in new SDK versions, substituted for manageSubscriptions function with UIViewController parameter.")
    public func buildManageSubscriptionsViewController() -> UIViewController
    
    /// Build a entry point skipping the isn't of the device, already sent in the parameter
    /// - Parameter productID: product id to register
    /// - Parameter callback: the status of the Onboarding
    /// - OnboardingResponse: (success, pending or fail)
    /// - Returns: Entry point controller
    @available(*, deprecated, message: "That function will be deprecated in new SDK versions, substituted for manageSubscriptions function with UIViewController parameter.")
    public func buildAddDeviceViewController(productID: String, completion: @escaping VPartnerLib.OnboardingCompletionHandler) -> UIViewController
    
    /// Build entry point to add manually the device
    /// - Parameter callback: the status of the Onboarding
    /// - OnboardingResponse: (success, pending or fail)
    /// - Returns: Entry point controller
    @available(*, deprecated, message: "That function will be deprecated in new SDK versions, substituted for manageSubscriptions function with UIViewController parameter.")
    public func buildAddDeviceViewController(completion: @escaping VPartnerLib.OnboardingCompletionHandler) -> UIViewController
    
    /// Build entry point to add manually the device
    /// - Parameter vc: UIViewController that will be used to initialise the SDK
    /// - Parameter callback: the status of the Onboarding
    /// - OnboardingResponse: (success, pending or fail)
    public func addDevice(vc: UIViewController, completion: @escaping OnboardingCompletionHandler)
    
    /// Present the Onboarding Device flow skipping the manually add device screen, already sent in the parameter
    /// - Parameter productID: product id to register
    /// - Parameter vc: UIViewController that will be used to initialise the SDK
    /// - Parameter callback: the status of the Onboarding
    /// - OnboardingResponse: (success, pending or fail)
    public func addDevice(productID: String, vc: UIViewController, completion: @escaping OnboardingCompletionHandler)
```

## Changelog
Please refer to Changelog.md to keep track of the new releases of the SDK and what they bring.

## Contact
If you have any questions regarding our implementation guide and/or the SDK itself, please contact SquaDK team at squadk@celfocus.com. 

