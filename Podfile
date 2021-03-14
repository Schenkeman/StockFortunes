# Uncomment the next line to define a global platform for your project
platform :ios, '11.0'

target 'StockFortunes' do
  # Comment the next line if you don't want to use dynamic frameworks
  use_frameworks!

  # Pods for StockFortunes
pod 'JGProgressHUD', '~>2.0.3'
pod 'Nuke', '~> 9.0'
pod 'Charts'

end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '11.0'
      end
    end
end
