[![Swift 5](https://img.shields.io/badge/Swift-5-green.svg?style=flat)](https://swift.org/)

Xcode Version 10.2.1 (10E1001)

# Project - Coding Challenge  #

 ### Dev Setup 
-  You won't need this because i will upload the project with the Dependencies but just in case you got any issues with carthage please run that command.
```
 - carthage update --platform iOS
```
- I deleted the DerivedData as well before zipping it so you won't need to delete it and it has a relative location to the project.


## Dev Notes ## 


### MVVM
This project uses the MVVM software architectural pattern. 


### Dependencies
[ReactiveCocoa Page](https://github.com/ReactiveCocoa/ReactiveCocoa)
[ReactiveSwift Page](https://github.com/ReactiveCocoa/ReactiveSwift)

- Dependencies are provided by Carthage. Why Carthage over CocoaPods? Because of: ( I would have used  Swift Package manager with the new Xcode but it's still beta 🤷‍♂)
    - Carthage does not have Xcode workspace.
    - Carthage builds framework binaries using xcodebuild.
    - Carthage has been created as a decentralized dependency manager.

- Why am i using ReactiveCocoa and ReactiveSwift?
    -  UI Binding.
    - Multithreading is simplified
    - Cleaner Code and Architectures.


### Localization
- The project is configured for localization with English language.


### Unit Testing
- The project uses XCTest for unit test.


### Snapshots Testing
 [FBSnapshotTestCase Page](https://github.com/uber/ios-snapshot-test-case)
 
- The project ues FBSnapshotTestCase for snapshopt test.
- The snapshots have been recored for iPhone 8 only, And it has been stored in folder "ImageGallery/ImageGalleryTests/ReferenceImages_64" 
