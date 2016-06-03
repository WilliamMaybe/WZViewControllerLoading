Pod::Spec.new do |s|
  s.name         = "WZViewControllerLoading"
  s.version      = "0.0.4"
  s.homepage     = "https://github.com/WilliamMaybe/WZViewControllerLoading"
  s.license      = "MIT"
  s.summary      = "A loading Extension for ViewController."
  s.author       = { "WilliamMaybe" => "271138178@qq.com" }
  s.source       = { :git => "https://github.com/WilliamMaybe/WZViewControllerLoading.git", :tag => "#{s.version}" }
  s.source_files  =  "WZViewControllerLoading/*.{h,m}"
  s.dependency 'MBProgressHUD'
  s.dependency 'Masonry'
  s.ios.frameworks = 'Foundation', 'UIKit'
  s.ios.deployment_target = '6.0' # minimum SDK with autolayout
end
