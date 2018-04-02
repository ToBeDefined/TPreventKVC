#
#  Be sure to run `pod spec lint TPreventKVC.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see http://docs.cocoapods.org/specification.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |s|
    s.name                      = 'TPreventKVC'
    s.version                   = '1.0.0'
    s.summary                   = <<-DESC
    Use TPreventKVC can prevent KVC's Exceptions crash, like NSUnknownKeyException & NSInvalidArgumentException
                                    DESC
    s.description               = <<-DESC
    Use TPreventKVC can make you project protect the 
    `-valueForKey:`
    `setValue:forKey:`
    `-setValue:forKeyPath:`
    `-valueForKeyPath:` and so on
    
    To prevent to produce NSUnknownKeyException & NSInvalidArgumentException and crash.
    github : https://github.com/ToBeDefined/TPreventKVC
                                    DESC
    s.homepage                  = 'https://github.com/ToBeDefined/TPreventKVC'
    s.license                   = { :type => 'MIT', :file => 'LICENSE' }
    s.author                    = { 'ToBeDefined' => 'weinanshao@163.com' }
    s.social_media_url          = 'http://tbd.ink/'
    s.source                    = { :git => 'https://github.com/ToBeDefined/TPreventKVC.git', :tag => s.version}
    s.frameworks                = 'Foundation'
    s.requires_arc              = true
    s.ios.deployment_target     = '3.1'
    s.osx.deployment_target     = '10.6'
    s.tvos.deployment_target    = '9.0'
    s.watchos.deployment_target = '1.0'
    s.public_header_files       = 'TPreventKVC/*.h'
    s.source_files              = 'TPreventKVC/*.{h,m}'
end
  