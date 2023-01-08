#
# Be sure to run `pod lib lint QuickSheet.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see https://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = 'QuickSheet'
  s.version          = '0.1.0'
  s.summary          = 'Quicksheet is a wrapper for UIViewController to handle bottom sheet presentation with low code footprint and a high degree of customisation.'

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!

  s.description      = <<-DESC
'Quicksheet is a wrapper for UIViewController to handle bottom sheet presentation with low code footprint and a high degree of customisation.'
                       DESC

  s.homepage         = 'https://github.com/ahmedfathy-m/QuickSheet'
  # s.screenshots     = 'www.example.com/screenshots_1', 'www.example.com/screenshots_2'
  s.license          = { :type => 'MIT', :file => 'LICENSE' }
  s.author           = { 'Ahmed Fathy' => 'ahmedfathy.mha@gmail.com' }
  s.source           = { :git => 'https://github.com/ahmedfathy-m/QuickSheet.git', :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/<TWITTER_USERNAME>'

  s.ios.deployment_target = '13.0'

  s.source_files = 'Source/**/*.swift'
  
  # s.resource_bundles = {
  #   'QuickSheet' => ['QuickSheet/Assets/*.png']
  # }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  # s.frameworks = 'UIKit', 'MapKit'
  # s.dependency 'AFNetworking', '~> 2.3'
end
