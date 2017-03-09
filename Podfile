# Uncomment the next line to define a global platform for your project
platform :ios, '8.0'

target 'CCKit' do
  pod 'AFNetworking',   '= 3.0.4'
  pod 'YYModel',        '= 1.0.4'
  pod 'Cordova',        '= 4.3.0'
end

abstract_target 'Dummy' do
  pod 'AFNetworking',   '= 3.0.4'
  pod 'YYModel',        '= 1.0.4'
  pod 'Cordova',        '= 4.3.0'
  target 'CCKitDemo' do
    inherit! :search_paths
  end
  target 'CCKitTests' do
    inherit! :search_paths
  end
end
