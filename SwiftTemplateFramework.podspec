Pod::Spec.new do |spec|
  spec.name = "SwiftTemplateFramework"
  spec.version = "1.0.0"
  spec.summary = "A framework to deal with network requests"
  spec.homepage = "https://github.com/Reedyuk/SwiftTemplateFramework"
  spec.license = { type: 'MIT' }
  spec.authors = { "Andrew Reed" => 'andrew_reed@hotmail.com' }

  spec.platform = :ios, "10.1"
  spec.requires_arc = true
  spec.source = { git: "https://github.com/Reedyuk/SwiftTemplateFramework.git" }
  spec.source_files = "SwiftTemplateFramework/**/*.{h,swift}"

  spec.dependency 'Siesta/UI'
  spec.dependency 'CocoaLumberjack/Swift'
end