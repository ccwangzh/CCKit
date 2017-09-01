# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

inhibit_all_warnings!
use_frameworks!

target 'CCKit' do
  pod 'AFNetworking',   '= 3.0.4'
  pod 'YYModel',        '= 1.0.4'
  pod 'Cordova',        '= 4.3.0'
  pod 'OpenSSL', :git => 'git@github.com:ccwangzh/OpenSSL.git'
end

abstract_target 'Dummy' do
  pod 'AFNetworking',   '= 3.0.4'
  pod 'YYModel',        '= 1.0.4'
  pod 'Cordova',        '= 4.3.0'
  pod 'OpenSSL', :git => 'git@github.com:ccwangzh/OpenSSL.git'
  target 'CCKitDemo' do
    inherit! :search_paths
  end
  target 'CCKitReact' do
    pod 'Yoga', :path => 'CCKitReact/node_modules/react-native/ReactCommon/yoga'
    pod 'React', :path => 'CCKitReact/node_modules/react-native',
                    :subspecs => ['Core', 'BatchedBridge', 'DevSupport', 'RCTWebSocket', 'RCTText', 'RCTImage',]
    inherit! :search_paths
  end
  target 'CCKitTests' do
    inherit! :search_paths
  end
end
