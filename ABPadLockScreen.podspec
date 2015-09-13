Pod::Spec.new do |s|
  s.name         = "ABSocialButton"
  s.version      = "0.0.01
  s.summary      = "A simple button styled to suit various social networks"

  s.description  = <<-DESC
                   A simple button styled to suit various social networks

                   ABSocialButton aims to provide a quick, easy to configure UIButton replacement that 
                   is styled to suit the 'login in with x' button styles seen in many apps.

                   DESC

  s.homepage     = "https://github.com/abury/ABPasSocialButton"

  s.license      = 'MIT'
  s.license      = { :type => 'MIT', :file => 'LICENSE' }

  s.author       = { "Aron Bury" => "aron.bury@gmail.com" }

  s.platform     = :ios, '8.0'
  s.ios.deployment_target = '8.0'

  s.source       = { :git => "https://github.com/abury/ABSocialButton.git", :tag => s.version.to_s }
  s.source_files  = 'ABSocialButton', 'ABSocialButton/**/*.{h,m}'

  s.requires_arc = true
end
