#
#  Be sure to run `pod spec lint ProjectBaseLibs.podspec' to ensure this is a
#  valid spec and to remove all comments including this before submitting the spec.
#
#  To learn more about Podspec attributes see https://guides.cocoapods.org/syntax/podspec.html
#  To see working Podspecs in the CocoaPods repo see https://github.com/CocoaPods/Specs/
#

Pod::Spec.new do |spec|

  # 项目名
  spec.name = "ProjectBaseLibs"
  
  # 版本号
  spec.version = "1.0.0"
  
  # 简单描述
  spec.summary = "A short description of ProjectBaseLibs."
  
  # 描述信息
  spec.description = "swift开发基础库"
  
  # 项目的GitHub地址
  spec.homepage = "https://www.github.com/Eano-iOS"
  
  # license
  spec.license = "LICENSE"
  
  # 作者
  spec.author = { "Eano-iOS-Developer" => "Eano-iOS-Developer@icloud.com" }
  
  # git仓库的https地址
  spec.source = { :git => "https://www.github.com/Eano-iOS", :tag => "1.0.0" }

  #------------- 重要 -------------#
  
  # 最低要求的系统版本
  spec.ios.deployment_target = "12.0"
  
  # 源码文件
  spec.source_files = "Classes/**/*"
  
  # (该spec)依赖的第三方库
  spec.dependency 'Kingfisher'
  
  #-------------------------------#

end
