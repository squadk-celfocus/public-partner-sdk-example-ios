
Pod::Spec.new do |spec|
  spec.name         = "VPartnerLib"
  spec.version      = "2.1.0"
  spec.summary      = "VPartnerLib is a SDK that allows Partners to easily integrate Vodafone World into their apps."

  spec.description  = <<-DESC
	The SDK will allow partners to centralize and do everything related with their devices under one app. This means:
* Onboard users into the Vodafone CIoT Platform, being the users Vodafone or Non-Vodafone.
* Manage their device subscriptions. This includes, adding, editing, removing and perform paying operations related to their devices and subscriptions.
                   DESC

  spec.homepage     = "https://github.com/squadk-celfocus/public-partner-sdk-example-ios"
  spec.license      = { :type => 'Copyright', :text => <<-LICENSE
                   Copyright 2022
                   Permission is granted to Vodafone.
                  LICENSE
                }
  spec.author             = { "Matheus Fogiatto" => "matheus.fogiatto@vodafone.com" }
  spec.source       = { :git => "https://github.com/squadk-celfocus/public-partner-sdk-example-ios.git", :tag => "2.1.0" }
  spec.static_framework = true
  spec.ios.vendored_frameworks = "VPartnerLib.xcframework", "SecLibFramework.xcframework", "IdtmLib.xcframework", "FirebaseInstanceID.xcframework"
  spec.pod_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' }
  spec.user_target_xcconfig = { 'EXCLUDED_ARCHS[sdk=iphonesimulator*]' => 'arm64' } 
  spec.requires_arc = true
  spec.platform = :ios
  spec.swift_version = "4.2"
  spec.ios.deployment_target  = '12.0'
  spec.dependency 'ReactiveCocoa'
  spec.dependency 'ReactiveSwift', '~> 6.1'
  spec.dependency 'ASN1Decoder'
  spec.dependency 'PhoneNumberKit', '~> 3.3'
  spec.dependency 'Firebase/Core', '~> 7.0'
  spec.dependency 'FirebaseCoreDiagnostics', '~> 7.0'
  spec.dependency 'Firebase/Installations', '~> 7.0'
  spec.dependency 'Firebase/Messaging', '~> 7.0'
  spec.dependency 'JumioMobileSDK', '~>3.7.1'
end