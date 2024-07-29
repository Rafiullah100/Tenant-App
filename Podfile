# Uncomment the next line to define a global platform for your project
# platform :ios, '9.0'

target 'Tenant' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for Tenant
  pod 'SVProgressHUD'
  pod 'SpinKit'
  pod 'SDWebImage', '~> 5.0'
  pod 'GoogleMaps'
  pod 'IQKeyboardManager' #iOS8 and later

end

post_install do |installer|
    installer.generated_projects.each do |project|
          project.targets.each do |target|
              target.build_configurations.each do |config|
                  config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '15.0'
               end
          end
   end
end
