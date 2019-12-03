# Tesseract OCR iOS Prototype

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)

This prototype is to recongnize text inside image and for that it uses tesseract OCR.The underlying Tesseract engine will process the image and return anything that it believes is text.

### Prerequisites
- iOS 11.0+
- Xcode 10.2
- [CocoaPods](http://cocoapods.org/)

### Dependencies

Third party frameworks and libraries are managed using [Cocoapods](http://cocoapods.org/).

#### Pods used 

- [TesseractOCRiOS](https://github.com/gali8/Tesseract-OCR-iOS): Tesseract OCR iOS is a Framework for recognizing text inside image.
- [GPUImage](https://github.com/BradLarson/GPUImage): The GPUImage framework is a BSD-licensed iOS library that lets you apply GPU-accelerated filters and other effects to images, live camera video, and movies.
- [IQKeyboardManagerSwift](https://github.com/hackiftekhar/IQKeyboardManager/tree/master/IQKeyboardManagerSwift): to manage keyboard behaviour in textfield and textview

### How to setup project?

1. Clone this repository into a location of your choosing, like your projects folder

2. Open terminal - > Navigate to directory containing ``Podfile``

3. Then install pods into your project by typing in terminal: ```pod install```

4. Once completed, there will be a message that says
`"Pod installation complete! There are X dependencies from the Podfile and X total pods installed."`

5. Voila! You are all set now. Open the .xcworkspace file from now on and hit Xcode's 'run' button.  🚀

### How to use?

There are 2 ways to select an image as an input, you can use given camera setup and click a live photo or else you can choose image from Photos app. After that it will process a output and it will be shown in as below.

<img src="https://user-images.githubusercontent.com/8736329/69900588-68f58180-139b-11ea-8ae2-db7e8f175c9d.gif" width="200" height="350”>

<img src="https://user-images.githubusercontent.com/8736329/69900579-5a0ecf00-139b-11ea-9155-5a881b9df3a3.gif
" width="200" height="350">

### Architecture

The project uses the default Apple architecture (MVC) along with [Protocol-Oriented approach in Swift](https://developer.apple.com/videos/play/wwdc2015/408/).

### Copyright

Copyright © 2014-2019 Simform Solutions, Inc. All worldwide rights reserved.
