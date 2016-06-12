Pod::Spec.new do |s|
  s.name             = "DFDiff"
  s.version          = "0.1.0"
  s.summary          = "Easy way to find changes in NSArray and animate reloading data in UITableView."
  s.homepage         = "https://github.com/marciniwanicki/DFDiff"
  s.license          = 'MIT'
  s.author           = { "Marcin Iwanicki" => "marcin.iwanicki@appliwings.com" }
  s.source           = { :git => "https://github.com/marciniwanicki/DFDiff.git", :tag => "#{s.version}" }

  s.ios.deployment_target = '7.0'
  s.requires_arc = true

  s.source_files = 'DFDiff/**/*.{h,m}'
  s.public_header_files = 'DFDiff/**/*.h'
end
