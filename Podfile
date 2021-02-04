# source 'https://github.com/CocoaPods/Specs.git'

use_frameworks!

platform :ios, '10.0'
inhibit_all_warnings!

flutter_application_path = '../flutter_module'
load File.join(flutter_application_path, '.ios', 'Flutter', 'podhelper.rb')

target :ZhouApp do
  
  # 安装Flutter模块
  install_all_flutter_pods(flutter_application_path)
  # pod 'RegexKitLite'
    
  pod 'IQKeyboardManager'
  pod 'MJRefresh'

  pod 'ZMBaseLib', :git => 'https://git.dev.tencent.com/z251257144/ZMBaseLibSwift.git'
  
  post_install do |installer|
   installer.pods_project.targets.each do |target|
    target.build_configurations.each do |config|
     config.build_settings['IPHONEOS_DEPLOYMENT_TARGET'] = '10.0'
    end
   end
  end
  
end
