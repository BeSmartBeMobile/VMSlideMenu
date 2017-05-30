Pod::Spec.new do |s|
  s.name             = 'VMSlideMenu'
  s.version          = '1.0.4'
  s.summary          = 'VMSlideMenu allows add a beautyful and intuitive menu to your app.'

  s.description      = <<-DESC
VMSlideMenu allows add a beautyful and intuitive menu to your app. You can organize options in tabs and rows, and customize colors.
                       DESC

  s.homepage         = 'https://github.com/BeSmartBeMobile/VMSlideMenu'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 'José María Ila' => 'jmila@vectoritcgroup.com', 'Jorge Lucena' => 'jmlucena@vectoritcgroup.com' }
  s.source           = { :git => 'https://github.com/BeSmartBeMobile/VMSlideMenu.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '8.0'

  s.source_files = 'VMSlideMenu/Classes/**/*'
  
  # s.resource_bundles = {
  #   'VMSlideMenu' => ['VMSlideMenu/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
