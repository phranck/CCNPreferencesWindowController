Pod::Spec.new do |s|
  s.name                  = 'CCNPreferencesWindowController'
  s.version               = '1.2.1'
  s.summary               = 'An Objective-C class for automated management of preference view controllers.'
  s.description               = 'CCNPreferencesWindowController is an Objective-C subclass of NSWindowController that automatically manages your custom view controllers for handling app preferences.'
  s.homepage              = 'https://github.com/phranck/CCNPreferencesWindowController'
  s.author                = { 'Frank Gregor' => 'phranck@cocoanaut.com' }
  s.source                = { :git => 'https://github.com/phranck/CCNPreferencesWindowController.git', :tag => s.version.to_s }
  s.osx.deployment_target = '10.10'
  s.requires_arc          = true
  s.source_files          = 'CCNPreferencesWindowController/*.{h,m}'
  s.license               = { :type => 'MIT' }
end
