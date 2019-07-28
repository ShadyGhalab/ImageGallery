[![Swift 4.1](https://img.shields.io/badge/Swift-4.1-green.svg?style=flat)](https://swift.org/)

Xcode Version 9.4.1

# Project MemoryGame
The memory game has a grid of 4x4 cells. Initially, all cells are
shown but their images are hidden. When you tap on a cell, it reveals the image behind it. The player’s task is to find
the matching cell. If the next cell they tap on contains the same image, then it’s a match and the two cells remain
visible. If the next cell does not contain the same image, then it’s a miss. When it's a miss, both cards are visible for
a brief period and then both cells go back to the hidden state. The player continues until they find all matching cells.
Once a game is finished, the player receives some feedback that the game is over and should be able to start a new
one.

## Setup

1. Download the project from Google Drive.
2. Run!

## Dev Setup

* You won't need this because i will upload the project with the Dependencies but just in case you got any issues with carthage please run that command.
```
git carthage update --platform iOS
```

## Notes

### MVVM
This project uses the MVVM pattern. 

### Dependencies
Dependencies are provided by Carthage. Why Carthage over CocoaPods?
Because :
1- no Xcode workspace.
2- Carthage builds framework binaries using xcodebuild.
3- Carthage has been created as a decentralized dependency manager.


* I use ReactiveSwift and ReactiveCocoa for binding, multithreading is simplified and Cleaner Code & Architectures.
* I use XCGLogger because XCGLogger allows you to log details to the console (and optionally a file, or other custom destinations), just like you would have with NSLog() or print(), but with additional information, such as the date, function name, filename and line number.

#### Shuffle Algorithm
* I use that shuffle algorithm from that link [![Shuffle Algorithm]](https://stackoverflow.com/questions/24026510/how-do-i-shuffle-an-array-in-swift)  and the time complexity is O(n), With Swift 4.2+ we have a native method for shuffle the items that uses Fisher-Yates algorithm, I would use it if  i could have done the project with swift 4.2+.


### Unit Testing
I use XCTest for unit test and UI test.
