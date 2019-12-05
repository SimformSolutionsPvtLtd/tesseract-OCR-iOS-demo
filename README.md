# Tesseract OCR iOS Prototype

OCR is the operation of electronically extracting text from images. You’ve undoubtedly seen it before it’s widely used to process everything from scanned documents, to the handwritten scribbles on your mobile, iPad and PC.

In here, you’ll find out how to use Tesseract, an open-source OCR engine maintained by Google, to grab text from an image. This prototype is to recognize text inside the image and for that it uses Tesseract OCR. The underlying Tesseract engine will process the picture and return anything that it believes is text.

<img src="https://user-images.githubusercontent.com/8736329/70211504-4678b500-175b-11ea-9479-8362a0b8cde0.gif"
width="200" height="350">          <img src="https://user-images.githubusercontent.com/8736329/70211414-031e4680-175b-11ea-8575-c371f08b0720.gif"
width="200" height="350"> 


## Getting Started

There are following points we need to follow to use tesseract OCR and get the better the output out of it. 

##  Adding Trained Data

In order to better hone its predictions within the boundaries of a given language, Tesseract requires language-specific training data to perform its OCR.

Navigate to Tesseract OCR Demo/Resources in Finder. The tessdata folder contains a bunch of English training files. The image/document you’ll process in this project is mainly in English.

Now, you’ll add tessdata to your project. Tesseract OCR iOS requires you to add tessdata as a referenced folder.

- Drag the tessdata folder from Finder to the Tesseract OCR Demo folder in Xcode’s left-hand Project navigator.
- Select Copy items if needed.
- Set the Added Folders option to Create folder references.
- Confirm that the target is selected before clicking Finish.

![Monosnap 2019-12-05 11-41-18](https://user-images.githubusercontent.com/8736329/70208814-88eac380-1754-11ea-81ea-c66b2a789dc0.png)

You should now see a blue tessdata folder in the navigator. The blue color indicates that the folder is referenced rather than an Xcode group.

NOTE: In the Key fields of those two new entries, add Privacy – Camera Usage Description to one and Privacy – Photo Library Usage Description to the other. Select type String for each. Then in the Value column, enter whatever text you’d like to display to the user when requesting permission to access their camera and photo library, respectively.

## Scaling and removing noise from image

### Scaling Image

The aspect ratio of an image is the proportional relationship between its width and height. Mathematically speaking, to reduce the size of the original image without affecting the aspect ratio, you must keep the width-to-height ratio constant.

When you know both the height and the width of the original image, and you know either the desired height or width of the final image, you can rearrange the aspect ratio equation.

scaledImage(_ maxDimension: CGFloat) 
```
var scaledSize = CGSize(width: maxDimension, height: maxDimension)
if size.width > size.height {
scaledSize.height = size.height / size.width * scaledSize.width
} else {
scaledSize.width = size.width / size.height * scaledSize.height
}
UIGraphicsBeginImageContext(scaledSize)
draw(in: CGRect(origin: .zero, size: scaledSize))
let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
UIGraphicsEndImageContext()
return scaledImage
```
### Removing Noise From Image

Image noise is random variation of brightness or color information in images, and is usually an aspect of electronic noise. removing noise from image improves its quality.

removeNoise(noiseReducted: UIImage) 
```
guard let openGLContext = EAGLContext(api: .openGLES2) else { return self }
let ciContext = CIContext(eaglContext: openGLContext)

guard let noiseReduction = CIFilter(name: StringConstants.noiseReductionFilterName) else { return self }
noiseReduction.setValue(CIImage(image: self), forKey: kCIInputImageKey)
noiseReduction.setValue(Defaults.inputNoiseLevel, forKey: StringConstants.inputNoiseLevel)
noiseReduction.setValue(Defaults.inputSharpness, forKey: StringConstants.inputSharpness)

if let output = noiseReduction.outputImage, let cgImage = ciContext.createCGImage(output, from: output.extent) {
return UIImage(cgImage: cgImage, scale: scale, orientation: imageOrientation)
}
return UIImage()
```
As shown in the above code snippet It will apply filter on image and remove noise using different parameters.


## Use Cases of Tesseract OCR


It can be used to recognize documnets, receipts and street-signs etc.let's go though all of them with example.

### Documents (book pages, letters)

- Let’s consider an example of a picture of a book page.

![doc1](https://user-images.githubusercontent.com/8736329/70234375-886b2080-1786-11ea-9f66-b68dfb759dcb.png)

```
output:

Mild Splendour of the various-vested Night!
Mother of sirildly-working visions! haill
I watch thy gliding, while with watery li ht
Thy weak eye glimmers through a fleecy veil;
And when thou lovest thy pale orb to shroud
Behind the ather'd blackness lost on high;
And when thou dartest from the wind-rent cloud
Thy placid lightning o'er the awaken'd sky.
```


### Receipts

- The text structure in book pages is very well defined, i.e. words and sentences are equally spaced and very less variation in font sizes which is not the case in bill receipts. A slightly difficult example is a Receipt which has non-uniform text layout and multiple fonts. Let’s see how well does tesseract perform on scanned receipts.

![receipt](https://user-images.githubusercontent.com/8736329/70234293-5b1e7280-1786-11ea-8b18-27728a210bc0.png)

```
output:

Store #05666
3515 DEL MAR HTS,RD
SAN DIEGO, CA 92130
(858) 792-7040

Register #4 Transaction #571140
Cashier #56661020 8/20/17 5:45PM

wellness+ with Plenti
Plenti Card#: 31)000000000(4553
1 G2 RETRACT BOLD BLK 2PK
1.99 T

SALE 1/1.99, Reg 1/4.69
Discount 2 70-
1 Items

Subtotal
1.99
Tax
.15
Total
2.14

*MASTER*
2.14
MASTER card * #)0()000000000(5485
App #AA APPROVAL AUTO
Ref # 05639E
Entry Method: Chip
```


### Street Signs

- it can be used to recognize street signs as well, with this example we can see that how tesseract will behave when we pass image with symboals and dark boundaries.
- Tesseract does not do a very good job with dark boundaries and often assumes it to be text.However, if we help Tesseract a bit by cropping out the text region, it gives perfect output.

![ss1](https://user-images.githubusercontent.com/8736329/70234485-bfd9cd00-1786-11ea-8f7e-1e328fc63733.jpeg)

```
output:

2:fi)::s

Caution
Site traffic
```
- This is a mistake in output due to symbol. 

### Copyright

Copyright © 2014-2019 Simform Solutions, Inc. All worldwide rights reserved.
