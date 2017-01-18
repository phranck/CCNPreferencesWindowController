Pod::Spec.new do |spec|
  spec.name                  = 'CCNPreferencesWindowController'
  spec.version               = '1.4.3'
  spec.summary               = 'An Objective-C class for automated management of preference view controllers.'
  spec.description           = 'CCNPreferencesWindowController is an Objective-C subclass of NSWindowController that automatically manages your custom view controllers for handling app preferences.'
  spec.homepage              = 'https://github.com/phranck/CCNPreferencesWindowController'
  spec.author                = { 'Frank Gregor' => 'phranck@cocoanaut.com' }
  spec.source                = { :git => 'https://github.com/phranck/CCNPreferencesWindowController.git', :tag => spec.version.to_s }
  spec.platform              = :osx, '10.10'
  spec.osx.deployment_target = '10.10'
  spec.requires_arc          = true
  spec.source_files          = 'CCNPreferencesWindowController/**/*.{h,m}'
  spec.license               = { :type => 'MIT' }
end
