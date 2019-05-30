Pod::Spec.new do |spec|

  spec.name         = "YQHChatUI"

  spec.version      = "0.0.22"

  spec.ios.deployment_target = '8.0'

  spec.summary      = "聊天基础界面"

  spec.description  = "聊天基础界面，快速搭建属于自己的聊天界面"
                   
  spec.homepage     = "https://github.com/yangqihe/YQHChatUI"

  spec.license      = "MIT"

  spec.author       = { "杨棋贺" => "yangqihe@aliyun.com" }

  spec.platform     = :ios, "8.0"

  spec.requires_arc = true

  spec.ios.frameworks = 'AVFoundation', 'UIKit'

  spec.source       = { :git => "https://github.com/yangqihe/YQHChatUI.git", :tag => "#{spec.version}" }

  spec.public_header_files = 'Pod/Classes/**/*.{h}'

  #spec.source_files  = "Pod/Classes/**/*"
  
  spec.source_files  = "Pod/Classes/**/*.{h,m,mm}"

  spec.private_header_files = ['Pod/Classes/Utils/VoiceConvert/amrwapper/wav.h','Pod/Classes/Utils/VoiceConvert/amrwapper/amrFileCodec.h','Pod/Classes/Utils/VoiceConvert/opencore-amrnb/*.h','Pod/Classes/Utils/VoiceConvert/opencore-amrwb/*.h']
 
  spec.vendored_libraries = ['Pod/Classes/Utils/VoiceConvert/opencore-amrnb/libopencore-amrnb.a','Pod/Classes/Utils/VoiceConvert/opencore-amrwb/libopencore-amrwb.a']


  spec.resource = 'Pod/Assets/**/*.png'


  spec.dependency "Masonry" , "~> 1.1.0"

  spec.dependency "SDWebImage","~> 5.0"

end
