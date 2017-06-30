Pod::Spec.new do |s|  
    s.name              = 'YouSign'
    s.version           = '1.0'
    s.summary           = 'Yousign : Electronic Signature Framework'
    s.homepage          = 'https://yousign.fr'
    s.author            = { 'BEN MESSAOUD' => 'mahmoudtn@gmail.com' }
    s.license      = {:type => 'MIT', :file => 'LICENSE' }
    s.platform = :ios
    s.source = { :git => 'https://github.com/BENMESSAOUD/yousign', :tag => 'PREPROD_01' }
    s.ios.deployment_target = '8.0'
  	s.source_files  = 'yousign/YouSign/YouSign/**/*.{swift}'
  	s.dependency 'SwiftyXMLParser'
 	s.dependency 'CryptoSwift'
end 