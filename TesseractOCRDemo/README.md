# Tesseract OCR iOS Prototype

[![Swift 5.0](https://img.shields.io/badge/Swift-5.0-orange.svg?style=flat)](https://swift.org)

OCR is the process of electronically extracting text from images. You’ve undoubtedly seen it before — it’s widely used to process everything from scanned documents, to the handwritten scribbles on your mobile, iPad and PC.

In here, you’ll learn how to use Tesseract, an open-source OCR engine maintained by Google, to grab text from a image.This prototype is to recongnize text inside image and for that it uses tesseract OCR.The underlying Tesseract engine will process the image and return anything that it believes is text.

## Getting Started

How Tesseract OCR Works?

Generally speaking, OCR uses artificial intelligence to find and recognize text in images.Some OCR engines rely on a type of artificial intelligence called machine learning. Machine learning allows a system to learn from and adapt to data by identifying and predicting patterns.The Tesseract OCR iOS engine uses a specific type of machine-learning model called a neural network.

How are you going to use Tesseract OCR in iOS?

- Nexor Technology has created a compatible Swift wrapper for Tesseract OCR.Following are the steps that shows how are you going to use this in iOS.

1. Adding the Tesseract Framework
2. Adding Trained Data
3. Implementing Tesseract OCR
4. Scaling Images While Preserving Aspect Ratio
5. Improving Image Quality 
6. Processing Your First Image

Let's get started, 

1. Adding the Tesseract Framework

First, you’ll have to install Tesseract OCR iOS via CocoaPods, a widely used dependency manager for iOS projects.
If you haven’t already installed CocoaPods on your computer, open Terminal, then execute the following command:
```sudo gem install cocoapods
```
Enter your computer’s password when requested to complete the CocoaPods installation.
Next, cd  into the Tesseract OCR Demo project folder. For example, if you’ve added Tesseract OCR Demo to your desktop, you can enter:
```cd ~/Desktop/"TesseractOCRDemo"
```
Next, enter:
```pod init
```
This creates a Podfile for your project.
Replace the contents of Podfile with:
```
platform :ios, '12.1'

target 'TesseractOCRDemo' do
    use_frameworks!
  pod 'TesseractOCRiOS','5.0.1' # for image to text recognition

end
```
This tells CocoaPods that you want to include TesseractOCRiOS as a dependency for your project.

Back in Terminal, enter:
```pod install
```
2. Adding Trained Data

In order to better hone its predictions within the limits of a given language, Tesseract requires language-specific training data to perform its OCR.

Navigate to Tesseract OCR Demo/Resources in Finder. The tessdata folder contains a bunch of English training files. The image/document you’ll process in this project is mainly in English.

Now, you’ll add tessdata to your project. Tesseract OCR iOS requires you to add tessdata as a referenced folder.

1.Drag the tessdata folder from Finder to the Tesseract OCR Demo folder in Xcode’s left-hand Project navigator.
2.Select Copy items if needed.
3.Set the Added Folders option to Create folder references.
4.Confirm that the target is selected before clicking Finish.

![Monosnap 2019-12-05 11-41-18](https://user-images.githubusercontent.com/8736329/70208814-88eac380-1754-11ea-81ea-c66b2a789dc0.png)

You should now see a blue tessdata folder in the navigator. The blue color indicates that the folder is referenced rather than an Xcode group.

NOTE: In the Key fields of those two new entries, add Privacy – Camera Usage Description to one and Privacy – Photo Library Usage Description to the other. Select type String for each. Then in the Value column, enter whatever text you’d like to display to the user when requesting permission to access their camera and photo library, respectively.

3. Implementing Tesseract OCR

First, add the following below import MobileCoreServices to make the Tesseract framework available to ViewController:

import TesseractOCR

Now, in performImageRecognition(_:)
```ruby
// 1
if let tesseract = G8Tesseract(language: "eng+fra") {
  // 2
  tesseract.engineMode = .tesseractCubeCombined
  // 3
  tesseract.pageSegmentationMode = .auto
  // 4
  tesseract.image = image
  // 5
  tesseract.recognize()
  // 6
  textView.text = tesseract.recognizedText
}
// 7
activityIndicator.stopAnimating()
```
Since this is the meat of this Project, here’s a detailed break down, line by line:

1.Initialize tesseract with a new G8Tesseract object that will use both English (“eng”) language data.
2.Tesseract offers three different OCR engine modes: .tesseractOnly, which is the fastest, but least accurate method; .cubeOnly, which is slower but more accurate since it employs more artificial intelligence; and .tesseractCubeCombined, which runs both .tesseractOnly and .cubeOnly. .tesseractCubeCombined is the slowest, but since it’s most accurate, you’ll use it in this project.
3.Tesseract assumes, by default, that it’s processing a uniform block of text, but your sample image has multiple paragraphs. Tesseract’s pageSegmentationMode lets the Tesseract engine know how the text is divided. In this case, set pageSegmentationMode to .sparseText to allow for fully automatic page segmentation and thus the ability to recognize paragraph breaks.
4.Assign the selected image to the tesseract instance.
5.Tell Tesseract to get to work recognizing your text.
6.Put Tesseract’s recognized text output into your textView.
7.Hide the activity indicator since the OCR is complete.
Now, it’s time to test out this first batch of new code!

4. Scaling Images While Preserving Aspect Ratio

The aspect ratio of an image is the proportional relationship between its width and height. Mathematically speaking, to reduce the size of the original image without affecting the aspect ratio, you must keep the width-to-height ratio constant.
When you know both the height and the width of the original image, and you know either the desired height or width of the final image, you can rearrange the aspect ratio equation.

Formula 1: When the image’s width is greater than its height.
```
Height1/Width1 * width2 = height2
```
Formula 2: When the image’s height is greater than its width.
```
Width1/Height1 * height2 = width2
```
Now, add the following extension and method to the bottom of ViewController.swift:
```ruby

// MARK: - UIImage extension

//1
extension UIImage {
  // 2
  func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
    // 3
    var scaledSize = CGSize(width: maxDimension, height: maxDimension)
    // 4
    if size.width > size.height {
      scaledSize.height = size.height / size.width * scaledSize.width
    } else {
      scaledSize.width = size.width / size.height * scaledSize.height
    }
    // 5
    UIGraphicsBeginImageContext(scaledSize)
    draw(in: CGRect(origin: .zero, size: scaledSize))
    let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
    UIGraphicsEndImageContext()
    // 6
    return scaledImage
  }
}
```
This code does the following:

1.The UIImage extension allows you to access any method(s) it contains directly through a UIImage object.
2.scaledImage(_:) takes in the maximum dimension (height or width) you desire for the returned image.
3.The scaledSize variable initially holds a CGSize with height and width equal to maxDimension.
4.You calculate the smaller dimension of the UIImage such that scaledSize retains the image’s aspect ratio. If the image’s width is greater than its height, use Formula 1. Otherwise, use Formula 2.
5.Create an image context, draw the original image into a rectangle of size scaledSize, then get the image from that context before ending the context.
6.Return the resulting image.

Whew! </math>

Now, within the top of performImageRecognition(_:), include:
```let scaledImage = image.scaledImage(1000) ?? image
```

This will attempt to scale the image so that it’s no bigger than 1,000 points wide or long. If scaledImage() fails to return a scaled image, the constant will default to the original image.

Then, replace tesseract.image = image with:
```tesseract.image = scaledImage
```
This assigns the scaled image to the Tesseract object instead.

Build, run and click reset  and select or snap again from the photo library.

5. Improving Image Quality 

The Tesseract iOS framework used to have built-in methods to improve image quality, but these methods have since been deprecated and the framework’s documentation now recommends using Brad Larson’s GPUImage framework instead.

GPUImage is available via CocoaPods, so immediately below pod 'TesseractOCRiOS' in Podfile, add:
```pod 'GPUImage'
```
Then, in Terminal, re-run:
```pod install
```
This should now make GPUImage available in your project.

Note: It will also add several hundred more compilation warnings. You can safely ignore these also.
Back in ViewController.swift, add the following below import TesseractOCR to make GPUImage available in the class:
```ruby
import GPUImage

Directly below scaledImage(_:), also within the UIImage extension, add:

func preprocessedImage() -> UIImage? {
  // 1
  let stillImageFilter = GPUImageAdaptiveThresholdFilter()
  // 2
  stillImageFilter.blurRadiusInPixels = 15.0
  // 3
  let filteredImage = stillImageFilter.image(byFilteringImage: self)
  // 4
  return filteredImage
}
```
Here, you:

1.Initialize a GPUImageAdaptiveThresholdFilter. The GPUImageAdaptiveThresholdFilter “determines the local luminance around a pixel, then turns the pixel black if it is below that local luminance, and white if above. This can be useful for picking out text under varying lighting conditions.”
2.The blurRadius represents the average blur of each character in pixels. It defaults to 4.0, but you can play around with this value to potentially improve OCR results. In the code above, you set it to 15.0 since the average character blur appears to be around 15.0 pixels wide when the image is 1,000 points wide.
3.Run the image through the filter to optionally return a new image object.
If the filter returns an image, return that image.
4.Back in performImageRecognition(_:), immediately underneath the scaledImage constant instantiation, add:

let preprocessedImage = scaledImage.preprocessedImage() ?? scaledImage

This code attempts to run the scaledImage through the GPUImage filter, but defaults to using the non-filtered scaledImage if preprocessedImage()’s filter fails.

Then, replace tesseract.image = scaledImage with:
```tesseract.image = preprocessedImage
```
This asks Tesseract to process the scaled and filtered image instead.

Now that you’ve gotten all of that out of the way, build, run and select the image again.

6. Processing Your First Image

There are 2 ways to select an image as an input, you can use given camera setup and click a live photo or else you can choose image from Photos app. After that it will process a output and it will be shown in as below.

<img src="https://user-images.githubusercontent.com/8736329/69900588-68f58180-139b-11ea-8ae2-db7e8f175c9d.gif" width="200" height="350”>

<img src="https://user-images.githubusercontent.com/8736329/69900579-5a0ecf00-139b-11ea-9155-5a881b9df3a3.gif
" width="200" height="350">

### Copyright

Copyright © 2014-2019 Simform Solutions, Inc. All worldwide rights reserved.
