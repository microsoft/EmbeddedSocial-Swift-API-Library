Pod::Spec.new do |s|
  s.name = 'EmbeddedSocialClient'
  s.ios.deployment_target = '9.0'
  s.osx.deployment_target = '10.11'
  s.version = '0.5.0'
  s.homepage = "https://github.com/Microsoft/MSR-EmbeddedSocial-Swift-API-Library"
  s.summary = " Library for interacting with the Microsoft Embedded Social API in your Swift code. "
  s.source = { :git => 'git@github.com:swagger-api/swagger-mustache.git', :tag => 'v1.0.0' }
  s.authors = 'Swagger Codegen'
  s.license = 'MIT'
  s.source_files = 'EmbeddedSocialClient/Classes/Swaggers/**/*.swift'
  s.dependency 'Alamofire', '~> 4.0'
end
