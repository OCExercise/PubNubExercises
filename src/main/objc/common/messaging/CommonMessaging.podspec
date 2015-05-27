Pod::Spec.new do |s|
  s.name         = 'CommonMessaging'
  s.version      = '1.0'
  s.summary      = 'Test Messaging Module'
  s.author = {
    'Prez Cannady' => 'revprez@correlatesystems.com'
  }
  s.source = {
    :git => 'ssh://git@github.org/revprez/PubNubExercises.git',
    :tag => s.version.to_s
  }
  s.source_files = 'CommonMessaging/*.{h,m}'
  
  s.homepage = 'https://github.org/revprez/PubNubExercises'

  s.ios.deployment_target = '7.0'
  s.osx.deployment_target = '10.9'
  
  s.dependency     'PubNub', '~> 3.7.10.8'
end
