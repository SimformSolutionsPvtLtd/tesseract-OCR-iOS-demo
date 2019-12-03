//
//  StringConstants.swift
//  TesseractOCRDemo
//
//  Created by Ami Solani on 18/10/19.
//  Copyright © 2019 Ami Solani. All rights reserved.
//

import Foundation
import UIKit

struct StringConstants {
    static let lang = "eng"
    static let alertTitle = "Alert"
    static let alertMessage = "Please Snap/Upload Proper Image."
    static let alertButtonTitle = "Dismiss"
    static let imagePickerActionSheetTitle = "Snap/Upload Image"
    static let cameraButtonTitle = "Take Photo"
    static let libraryButtonTitle = "Choose Existing"
    static let cancelButtonTitle = "Cancel"
    static let noiseReductionFilterName = "CINoiseReduction"
    static let inputNoiseLevel = "inputNoiseLevel"
    static let inputSharpness = "inputSharpness"
}

struct Defaults {
    static let imageFilterThreshold: CGFloat = 0.5
    static let blurRadiusInPixels: CGFloat = 15.0
    static let inputNoiseLevel =  0.02
    static let inputSharpness = 0.40
    static let maxDimension: CGFloat = 1000
}
