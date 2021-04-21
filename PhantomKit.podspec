Pod::Spec.new do |s|
  s.name                  = 'PhantomKit'
  s.version               = '1.0.0'
  s.license               = 'MIT'
  s.summary               = 'PhantomKit'
  s.homepage              = 'https://github.com/pawello2222/PhantomKit'
  s.authors               = { 'Pawel Wiszenko' => 'https://github.com/pawello2222' }
  s.source                = { :git => 'https://github.com/pawello2222/PhantomKit.git', :tag => s.version }
  s.source_files          = 'Sources/**/*.swift'
  s.resources             = 'Sources/**/*.xcassets'
  s.requires_arc          = true
  s.ios.deployment_target = '14.0'
  s.pod_target_xcconfig   = {
    'SWIFT_VERSION' => '5.3',
    'SWIFT_INSTALL_OBJC_HEADER' => 'NO'
  }
#  s.dependency 'Xcore'
end
