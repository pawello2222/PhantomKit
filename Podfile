platform :ios, '14.0'
use_frameworks!
inhibit_all_warnings!

#pod "Introspect"
pod 'Xcore', :git => 'https://github.com/pawello2222/xcore', :branch => "pw/adaptation"

target 'PhantomKit_Tests' do
#  pod 'PhantomKit', :path => './'
end

post_install do |pi|
    pi.pods_project.targets.each do |t|
      t.build_configurations.each do |config|
        config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '14.0'
        config.build_settings.delete 'ARCHS'
      end
    end
end
