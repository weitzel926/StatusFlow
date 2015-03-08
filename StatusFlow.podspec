Pod::Spec.new do |s|
  s.name         			= "StatusFlow"
  s.version      			= "0.0.2"
  s.summary      			= "Control for the animated display of a series of cells used to indicate status"
  s.description  			= "A custom UICollectionView for showing the previous, current, and next item in a series of items"
  s.homepage     			= "https://github.com/weitzel926/StatusFlow"
  s.license      			= { :type => "MIT", :file => "MIT.LICENSE" }
  s.author       			= { "Wade Weitzel" => "wade.d.weitzel+github@gmail.com" }
  s.platform     			= :ios
  s.ios.deployment_target 	= "7.0"
  s.source       			= { :git => "https://github.com/weitzel926/StatusFlow.git", :tag => s.version.to_s }
  s.public_header_files  	= 'StatusFlow/StatusFlow/WDWStatusFlowView.h',   'StatusFlow/StatusFlow/WDWStatusFlowLayout.h'
  s.source_files          	= 'StatusFlow/StatusFlow/*.{h,m}'
  s.framework  				= 'Foundation', 'UIKit'
  s.requires_arc 			= true
end
