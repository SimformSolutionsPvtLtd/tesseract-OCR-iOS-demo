# Tesseract OCR iOS Prototype

This prototype is to recognize text inside the image and for that it uses Tesseract OCR. The underlying Tesseract engine will process the picture and return anything that it believes is text.

<img src="https://user-images.githubusercontent.com/8736329/70211504-4678b500-175b-11ea-9479-8362a0b8cde0.gif"
width="350" height="600">     <img src="https://user-images.githubusercontent.com/8736329/70211414-031e4680-175b-11ea-8575-c371f08b0720.gif"
width="350" height="600"> 


## Getting Started

These are the following points we need to follow to use [tesseract OCR iOS](https://github.com/gali8/Tesseract-OCR-iOS) and get the better the output out of it. 

## Add Trained Data[Tessdata Folder]

As we all know training data is used to train an algorithm. Generally, training data is a certain percentage of an overall dataset along with a testing set. As a rule, the better the training data, the better the algorithm or classifier performs. Tesseract requires language-specific training data to perform predictions, here language-specific denotes that it predicts within the boundaries of a given language.


To add training data drag the tessdata folder and set the added Folders option to create folder references, It will create a referenced folder. Do not forget to select a target before clicking Finish.
For this project we have only included English training files to tessdata folder. You can download and add [tessdata](https://github.com/tesseract-ocr/tessdata) as per your project requirements.


![Monosnap 2019-12-05 11-41-18](https://user-images.githubusercontent.com/8736329/70208814-88eac380-1754-11ea-81ea-c66b2a789dc0.png)

## Scaling and Removing noise from an image

### Scaling Image

Image scaling is performed ultimately to achieve resolution enhancement without loss of image quality. We can implement this using an aspect ratio of an image that has a proportional relationship with image width and height.


### Removing Noise from Image


Image noise is a random variation of brightness or color information in images and is usually an aspect of electronic noise. Removing noise from image improves its quality.

## Use Cases of Tesseract OCR


It can be used to recognize documents, receipts, and street-signs etc. Let's go through all of them with examples.


### Documents 

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


- A slightly difficult example is a Receipt which has non-uniform text layout and multiple fonts. Book pages and documents have very well defined structure and very little variation in font sizes and equally spaced data which is not the case in bill receipts. These examples shows how tesseract will perform on scanned receipts.


![receipt](https://user-images.githubusercontent.com/8736329/70234293-5b1e7280-1786-11ea-8b18-27728a210bc0.png)

```
output:

Store #05666
3515 DEL MAR HTS, RD
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

- It can be used to recognize street signs as well, with this example we can see that how tesseract will behave when we pass image with symbols and dark boundaries.
- Tesseract does not do a very good job with dark boundaries and often assumes it to be text. However, if we help Tesseract a bit by cropping out the text region, it gives perfect output.

![ss1](https://user-images.githubusercontent.com/8736329/70234485-bfd9cd00-1786-11ea-8f7e-1e328fc63733.jpeg)

```
output:

2:fi)::s

Caution
Site traffic
```

- There is a mistake in output due to a symbol. 

### License

Tesseract OCR iOS and TesseractOCR.framework are distributed under the MIT license (see LICENSE.md).

Tesseract, maintained by Google (http://code.google.com/p/tesseract-ocr/), is distributed under the Apache 2.0 license (see http://www.apache.org/licenses/LICENSE-2.0).

