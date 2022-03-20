

Pod::Spec.new do |s|

s.name         = "JHGuideController"
s.version      = "0.0.2"
s.summary      = "Translucent guide window control for iOS."
s.homepage     = "https://github.com/JC-Hu/JHGuideController"
s.license      = "MIT"
s.author             = { "JC-Hu" => "jchu_dlcn@icloud.com" }\

s.platform     = :ios, "8.0"
s.source       = { :git => "https://github.com/JC-Hu/JHGuideController.git", :tag => s.version }
s.frameworks   =  'Foundation','UIKit'
s.requires_arc = true

s.source_files = 'src/**/*.{h,m,c,mm}'

end
