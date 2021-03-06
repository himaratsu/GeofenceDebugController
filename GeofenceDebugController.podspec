#
# Be sure to run `pod lib lint GeofenceDebugController.podspec' to ensure this is a
# valid spec before submitting.
#
# Any lines starting with a # are optional, but their use is encouraged
# To learn more about a Podspec see http://guides.cocoapods.org/syntax/podspec.html
#

Pod::Spec.new do |s|
  s.name             = "GeofenceDebugController"
  s.version          = "0.1.0"
  s.summary          = "GeofenceDebugController is view controller for debug your geo locations."

# This description is used to generate tags and improve search results.
#   * Think: What does it do? Why did you write it? What is the focus?
#   * Try to keep it short, snappy and to the point.
#   * Write the description between the DESC delimiters below.
#   * Finally, don't worry about the indent, CocoaPods strips it!  
  s.description      = <<-DESC
                       DESC

  s.homepage         = "https://github.com/himaratsu/GeofenceDebugController"
  s.screenshots      = "https://github.com/himaratsu/GeofenceDebugController/blob/master/screenshot/demo0.png?raw=true", "https://github.com/himaratsu/GeofenceDebugController/blob/master/screenshot/demo1.png?raw=true"
  s.license          = 'MIT'
  s.author           = { "Ryosuke Hiramatsu" => "himaratsu@gmail.com" }
  s.source           = { :git => "https://github.com/himaratsu/GeofenceDebugController.git", :tag => s.version.to_s }
  # s.social_media_url = 'https://twitter.com/himara2'

  s.platform     = :ios, '8.0'
  s.requires_arc = true

  s.source_files = 'Pod/Classes/**/*'
  s.resource_bundles = {
    'GeofenceDebugController' => ['Pod/Assets/**/*'] 
  }

  # s.public_header_files = 'Pod/Classes/**/*.h'
  s.frameworks = 'UIKit', 'MapKit', 'CoreLocation'
  # s.dependency 'AFNetworking', '~> 2.3'
end
