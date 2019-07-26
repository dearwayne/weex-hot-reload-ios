#
# Be sure to run `pod lib lint WeexHotReload.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
    s.name             = 'WeexHotReload'
    s.version          = '0.1.0'
    s.summary          = 'An iOS library for weex hot reload in development.'
    
    s.description      = <<-DESC
    An iOS library for hot reload when the weex bundle changed in development.
    DESC
    
    s.homepage         = 'https://github.com/dearwayne/weex-hot-reload-ios'
    s.license          = { :type => 'MIT', :file => 'LICENSE' }
    s.author           = { 'wayne' => '334064275@163.com' }
    s.source           = { :git => 'https://github.com/dearwayne/weex-hot-reload-ios.git', :tag => s.version.to_s }
    
    s.platform         = :ios
    s.ios.deployment_target = '7.0'
    
    s.source_files = 'WeexHotReload/**/*'
    s.requires_arc = true
    s.public_header_files = 'WeexHotReload/HRWeexHotReload.h'
    s.dependency 'WeexSDK'
    s.dependency 'SocketRocket'
end
