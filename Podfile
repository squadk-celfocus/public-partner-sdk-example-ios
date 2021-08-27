source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

workspace 'PartnerIntegration'

target 'PartnerIntegration' do
  use_frameworks!

  pod 'ReactiveCocoa', '~> 10.1'
  pod 'ReactiveSwift', '~> 6.1'
  pod 'SwiftLint'
  pod "SwiftyMocky"
  pod 'OpenSSL-Universal'
  pod 'PhoneNumberKit', '~> 3.3'
  pod 'Firebase/Core'
  pod 'Firebase/Installations'
  pod 'Firebase/Messaging'
  pod 'JumioMobileSDK', '~>3.7.1'

end

# Post Install
deployment_target = '12.0'
post_install do |installer|
    installer.generated_projects.each do |project|
        project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
            end
        end
        project.build_configurations.each do |config|
            config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = deployment_target
        end
    end

    installer.pods_project.targets.each do |target|
      target.build_configurations.each do |config|
          config.build_settings['BUILD_LIBRARY_FOR_DISTRIBUTION'] = 'YES'
      end
    end
end