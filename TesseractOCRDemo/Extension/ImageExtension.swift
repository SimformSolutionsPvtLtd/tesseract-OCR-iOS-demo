//
//  ImageExtension.swift
//  TesseractOCRDemo
//
//  Created by Ami Solani on 17/10/19.
//  Copyright © 2019 Ami Solani. All rights reserved.
//

import Foundation
import UIKit
import GPUImage
import CoreImage

extension UIImage {
    
    func scaledImage(_ maxDimension: CGFloat) -> UIImage? {
        
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
    }
    
    func preprocessedImage() -> UIImage? {
        
        let stillImageFilter = GPUImageAdaptiveThresholdFilter()
        let imageFilter = GPUImageLuminanceThresholdFilter()
        imageFilter.threshold = Defaults.imageFilterThreshold
        stillImageFilter.blurRadiusInPixels = Defaults.blurRadiusInPixels
        let image = stillImageFilter.image(byFilteringImage: self)
        let filteredImage = imageFilter.image(byFilteringImage: image)!
        let finalImage = removeNoise(noiseReducted: filteredImage)
        return finalImage
    }
    
    func removeNoise(noiseReducted: UIImage) -> UIImage {
        
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
    }
    
}
