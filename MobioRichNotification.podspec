Pod::Spec.new do |spec|

  spec.name         = "MobioRichNotification"
  spec.version      = "0.0.1"
  spec.summary      = "This is the lib you can show notif. This is the lib you can show notif."

  spec.description  = <<-DESC
                      This lib help you show notif include rich notif service & content.
                   DESC

  spec.homepage     = "https://github.com/VuCuongHD96/MobioRichNotification"

  spec.license      = "MIT"

  spec.author             = { "cuongvx" => "cuongvx@mobio.vn" }

  spec.ios.deployment_target = "11.0"

  spec.swift_version = "4.0"

  spec.source       = { :git => "https://github.com/VuCuongHD96/MobioRichNotification.git", :tag => "#{spec.version}" }

  spec.source_files = "Source/**/**/*.{swift,xib,xcdatamodeld}"

  spec.resources = ['*.{xib}']


end
