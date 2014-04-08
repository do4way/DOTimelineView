Pod::Spec.new do |s|

  s.name         = "DOPTimelineView"
  s.version      = "0.0.1"
  s.summary      = "A smooth scrollable timeline view of user posts with photos, comments and interatives with other person."

  s.description  = <<-DESC
                   A instgram like timeline view of photos. 

                   * The viewer hanles photo views in a scrollable list view. Photos contained in a post can be a single one or 
                     not more than nine  photos, will be displayed according the number of photos. 
                   DESC

  s.homepage     = "https://github.com/do4way/DOTimelineView.git"
  # s.screenshots  = "www.example.com/screenshots_1", "www.example.com/screenshots_2"

  s.license      = "MIT"
  s.author             = { "Yongwei" => "yongwei.dou@gmail.com" }

  s.platform     = :ios, "6.0"
  s.source       = { :git => "https://github.com/do4way/DOTimelineView.git", :tag => "v0.0.1" }

  s.source_files  = "DOPTimelineView", "DOPTinelineVIew/**/*.{h,m}"
  s.exclude_files = "DOPTimelineView/{Exclude,Resources}"
  s.resources = "DOPTimelineView/Resources"

  # s.public_header_files = "Classes/**/*.h"

  s.requires_arc = true

  s.dependency "SDWebImage",         "~> 3.6"
  s.dependency "UIView+AutoLayout",  "~> 1.3.0"

end
