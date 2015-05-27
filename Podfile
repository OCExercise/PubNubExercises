workspace 'PubNubExercises'

xcodeproj 'src/main/objc/osx/hello/HelloOSX.xcodeproj'
xcodeproj 'src/main/objc/ios/hello/HelloMobile.xcodeproj'
xcodeproj 'src/main/objc/osx/messenger/MessengerOSX.xcodeproj'
xcodeproj 'src/main/objc/ios/messenger/MessengerMobile.xcodeproj'

target :hello_osx, :exclusive => true do
    platform :osx, '10.9'
    link_with 'HelloOSX', 'HelloOSXTests'
    pod 'PubNub', '~> 3.7.10.8'
    xcodeproj 'src/main/objc/osx/hello/HelloOSX.xcodeproj'
end

target :hello_ios, :exclusive => true do
    platform :ios, '7.0'
    link_with 'HelloMobile', 'HelloMobileTests'
    pod 'PubNub', '~> 3.7.10.8'
    xcodeproj 'src/main/objc/ios/hello/HelloMobile.xcodeproj'
end

# Messaging Test

target :common_messaging_framework, :exclusive => true do
    platform :osx, '10.9'
    link_with 'CommonMessaging', 'CommonMessagingTests'
    pod 'PubNub', '~> 3.7.10.8'
    xcodeproj 'src/main/objc/common/messaging/CommonMessaging.xcodeproj'
end

target :libcommonmsg, :exclusive => true do
    platform :ios, '7.0'
    link_with 'libcommonmsg'
    pod 'PubNub', '~> 3.7.10.8'
    xcodeproj 'src/main/objc/common/messaging/CommonMessaging.xcodeproj'
end


target :messenger_osx, :exclusive => true do
    platform :osx, '10.9'
    link_with 'MessengerOSX', 'MessengerOSXTests'
    pod 'CommonMessaging', :path => 'src/main/objc/common/messaging'
    
    xcodeproj 'src/main/objc/osx/messenger/MessengerOSX.xcodeproj'
end

target :messenger_ios, :exclusive => true do
    platform :ios, '7.0'
    link_with 'MessengerMobile', 'MessengerMobileTests'
    pod 'CommonMessaging', :path => 'src/main/objc/common/messaging'
    
    xcodeproj 'src/main/objc/ios/messenger/MessengerMobile.xcodeproj'
end
