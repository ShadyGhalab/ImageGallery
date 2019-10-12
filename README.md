[![Swift 5](https://img.shields.io/badge/Swift-5-green.svg?style=flat)](https://swift.org/)

Xcode Version 11.1 (11A1027)

# Project - Coding Challenge  #

 Image gallery app that will access  API endpoint to fetch all available photos and show them to the user.

The application shall have two screens:

- The first screen has one view with thumbnails of all available photos for the
car.
- When the user taps on one of the thumbnails, a second screen must load to show
the bigger photo in the middle of the screen.

 ### Dev Setup 
 This project uses Carthage and Swift Package Manager to manage the dependencies.

- Please run this command to update ReactiveCocoa and Snapshot dependencies. (These dependencies don't support Swift Package Manager yet)

```
 - carthage update --platform iOS
```

- ReactiveSwift will be updated automatically once you open the project via Swift Package Manager.

## Dev Notes ## 


### MVVM
This project uses the MVVM software architectural pattern. 


### Dependencies
- [ReactiveCocoa Page](https://github.com/ReactiveCocoa/ReactiveCocoa)
- [ReactiveSwift Page](https://github.com/ReactiveCocoa/ReactiveSwift)
- [FBSnapshotTestCase Page](https://github.com/uber/ios-snapshot-test-case)


### Localization
- The project is configured for localization with English language.


### Unit Testing
- The project uses XCTest for unit test.


### Snapshots Testing
 [FBSnapshotTestCase Page](https://github.com/uber/ios-snapshot-test-case)
 
- The project ues FBSnapshotTestCase for snapshopt test.
- The snapshots have been recored for iPhone 8 only, And it has been stored in folder "ImageGallery/ImageGalleryTests/ReferenceImages_64" 
