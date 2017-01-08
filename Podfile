source 'https://github.com/CocoaPods/Specs.git'

platform :ios, '10.1'
use_frameworks!
inhibit_all_warnings!

def required_pods

pod 'Siesta/UI'
pod 'CocoaLumberjack/Swift'

end

target "SwiftTemplateFramework" do
    required_pods
    post_install do |installer|
        installer.pods_project.targets.each do |target|
            target.build_configurations.each do |config|
                config.build_settings['ENABLE_BITCODE'] = 'NO'
                config.build_settings['CLANG_ENABLE_OBJC_WEAK'] ||= 'YES'
            end
        end
    end
end
