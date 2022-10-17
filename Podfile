source 'https://github.com/CocoaPods/Specs.git'
platform :ios, '12.0'

workspace 'PartnerIntegration'

target 'PartnerIntegration' do
  use_frameworks!

  pod 'VPartnerLib'
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
