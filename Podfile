use_frameworks!
platform :ios, '14.0'

#pod "Introspect"
pod 'Xcore', :git => 'https://github.com/zmian/xcore'

target 'PhantomKit_Tests' do
#  pod 'PhantomKit', :path => './'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
      end
    end
end
