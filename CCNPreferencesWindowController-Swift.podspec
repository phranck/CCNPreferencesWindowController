Pod::Spec.new do |spec|
  spec.name                  = 'CCNPreferencesWindowController-Swift'
  spec.version               = '1.4.2'
  spec.summary               = 'An Objective-C/Swift class for automated management of preference view controllers.'
  spec.description           = 'CCNPreferencesWindowController is an Objective-C/Swift subclass of NSWindowController that automatically manages your custom view controllers for handling app preferences.'
  spec.homepage              = 'https://github.com/phranck/CCNPreferencesWindowController'
  spec.author                = { 'Frank Gregor' => 'phranck@cocoanaut.com' }
  spec.source                = { :git => 'https://github.com/phranck/CCNPreferencesWindowController.git', :tag => spec.version.to_s }
  spec.platform              = :osx, '10.10'
  spec.osx.deployment_target = '10.10'
  spec.source_files          = 'CCNPreferencesWindowController/**/*.{swift}'
  spec.license               = { :type => 'MIT' }
end
