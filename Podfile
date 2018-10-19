platform :ios, '9.0'
source 'https://github.com/Microsoft/MSR-EmbeddedSocial-Swift-API-Library.git'
project 'EmbeddedSocialClient/EmbeddedSocialClient.xcodeproj'

target 'EmbeddedSocialClient' do
  use_frameworks!
  pod 'Alamofire', :git => 'https://github.com/Alamofire/Alamofire.git', :tag => '4.7.3'
  pod 'EmbeddedSocialClient', :path => 'EmbeddedSocialClient.podspec'
end

target 'EmbeddedSocialClientTests' do
  use_frameworks!
  inherit! :search_paths
end
