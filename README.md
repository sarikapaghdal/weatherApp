# weatherApp

The IOS app 'weatherApp'

IOS: 12.2
Not Universal

## Swift
Used Swift 5 that is latest version of Swift released.

## Dependency Management
Not used Cocoapods , Carthage or any third part libraries.

## UserInterface
Storboard -  Since  App is very small storboards, native controls , colors , images are used to setup and design UI elements on screens.

## App Architecture

    images
        folder has images that are used for local JSON data. 
    Controllers
        folder has controller for App who handles events from User.
    App Assets
        folder has Assets images like AppIcon and internal images, storboards, AppDelegate.
    ViewModel
        folder has Model to handle business logic for App.
    Model
        JSON file has some predefined JSON data according to App requirement documentation.
    View
        folder has View for App that are working with controller.


## Testing
Used IOS XCTest classes for UI and Unit test.
