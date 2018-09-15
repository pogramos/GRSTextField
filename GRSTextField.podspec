Pod::Spec.new do |s|
  s.name         = "GRSTextField"
  s.version      = "1.0"
  s.summary      = "A customizable UITextField with properties for layout and mask options"
  s.homepage     = "https://github.com/pogramos/GRSTextField"
  s.social_media_url = "http://twitter.com/pogramos"

  s.license      = "MIT"
  s.author       = { "Guilherme Ramos" => "guilherme.hor@gmail.com" }

  s.platform     = :ios, "9.0"
  s.source       = { :git => "https://github.com/pogramos/GRSTextField.git", :tag => s.version }
  s.source_files = "GRSTextField/**/*.swift"
  s.requires_arc = true
end
