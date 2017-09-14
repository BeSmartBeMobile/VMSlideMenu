Pod::Spec.new do |s|
  s.name             = 'VMSlideMenu'
  s.version          = '1.0.4'
  s.summary          = 'VMSlideMenu allows add a beautyful and intuitive menu to your app.'

  s.description      = <<-DESC
VMSlideMenu allows add a beautyful and intuitive menu to your app. You can organize options in tabs and rows, and customize colors.
                       DESC

  s.homepage         = 'https://github.com/BeSmartBeMobile/VMSlideMenu'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.authors           = { 'José María Ila' => 'jmila@vectoritcgroup.com', 'Jorge Lucena' => 'jmlucena@vectoritcgroup.com' }
  s.source           = { :git => 'https://github.com/BeSmartBeMobile/VMSlideMenu.git', :tag => s.version.to_s }
  s.ios.deployment_target = '8.0'
  s.source_files = 'VMSlideMenu/Classes/**/*'
end
