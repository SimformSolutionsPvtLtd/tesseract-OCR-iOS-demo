//
//  ViewController.swift
//  TesseractOCRDemo
//
//  Created by Ami Solani on 30/11/19.
//  Copyright © 2019 Ami Solani. All rights reserved.
//

import UIKit
import MobileCoreServices
import TesseractOCR
import GPUImage

class TesseractOCRDemoVC: UIViewController {
    
    // MARK: - Outlets
    
    @IBOutlet weak var txtView: UITextView!
    @IBOutlet weak var activityLoader: UIActivityIndicatorView!
    @IBOutlet weak var viewContainer: UIView!
    @IBOutlet weak var selectedImage: UIImageView!
    
    // MARK: - viewDidLoad
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addTapGesture()
    }
    
    // MARK: - addTapGesture
    
    func addTapGesture() {
        let tap = UITapGestureRecognizer(target: self, action: #selector(self.handleTap(_:)))
        viewContainer.addGestureRecognizer(tap)
    }
    
    // MARK: - handleTap
    
    @objc func handleTap(_ sender: UITapGestureRecognizer? = nil) {
        self.view.endEditing(true)
    }
    
    // MARK: - Tesseract Image Recognition
    func performImageRecognition(_ image: UIImage) {
        // can add support to -> StringConstants.lang + "FiraGOItalic" + "FiraGO" + "HelveticaNeue" + "Menlo" + "Menlo-Regular"
        if let tesseract = G8Tesseract(language: StringConstants.lang),  let scaledImage = image.scaledImage(Defaults.maxDimension), let preprocessedImage = scaledImage.preprocessedImage() {
            tesseract.engineMode = .tesseractCubeCombined
            tesseract.pageSegmentationMode = .sparseText
            
            tesseract.image = preprocessedImage
            tesseract.recognize()
            if let txt = tesseract.recognizedText, !txt.isEmpty {
                txtView.isHidden = false
                txtView.text = txt
            } else {
                showAlert()
                txtView.text = ""
            }
        }
        activityLoader.stopAnimating()
    }
    
    // MARK: - show Alert
    
    func showAlert() {
        txtView.isHidden = true
        let alertController = UIAlertController(title: StringConstants.alertTitle, message:
            StringConstants.alertMessage, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: StringConstants.alertButtonTitle, style: .default))
        
        self.present(alertController, animated: true, completion: nil)
    }
    
    // MARK: - Action
    
    @IBAction func takePhoto(_ sender: Any) {
        
        let imagePickerActionSheet =
            UIAlertController(title: StringConstants.imagePickerActionSheetTitle,
                              message: nil,
                              preferredStyle: .actionSheet)
        
        if UIImagePickerController.isSourceTypeAvailable(.camera) {
            let cameraButton = UIAlertAction(
                title: StringConstants.cameraButtonTitle,
                style: .default) { (alert) -> Void in
                    self.activityLoader.startAnimating()
                    let imagePicker = UIImagePickerController()
                    imagePicker.delegate = self
                    imagePicker.sourceType = .camera
                    imagePicker.mediaTypes = [kUTTypeImage as String]
                    self.present(imagePicker, animated: true, completion: {
                        self.activityLoader.stopAnimating()
                    })
            }
            imagePickerActionSheet.addAction(cameraButton)
        }
        
        let libraryButton = UIAlertAction(
            title: StringConstants.libraryButtonTitle,
            style: .default) { (alert) -> Void in
                self.activityLoader.startAnimating()
                let imagePicker = UIImagePickerController()
                imagePicker.delegate = self
                imagePicker.sourceType = .photoLibrary
                imagePicker.mediaTypes = [kUTTypeImage as String]
                self.present(imagePicker, animated: true, completion: {
                    self.activityLoader.stopAnimating()
                })
        }
        imagePickerActionSheet.addAction(libraryButton)
        
        let cancelButton = UIAlertAction(title: StringConstants.cancelButtonTitle, style: .cancel)
        imagePickerActionSheet.addAction(cancelButton)
        present(imagePickerActionSheet, animated: true)
    }
    
    @IBAction func onClickOfResetBtn(_ sender: Any) {
        selectedImage.image = nil
        txtView.text = ""
        txtView.isHidden = true
    }
}

// MARK: - UINavigationControllerDelegate

extension TesseractOCRDemoVC: UINavigationControllerDelegate { }

// MARK: - UIImagePickerControllerDelegate

extension TesseractOCRDemoVC: UIImagePickerControllerDelegate {

    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let selectedPhoto =
            info[.originalImage] as? UIImage else {
                dismiss(animated: true)
                return
        }
        activityLoader.startAnimating()
        dismiss(animated: true) {
            self.performImageRecognition(selectedPhoto)
            self.selectedImage.image = selectedPhoto
        }
    }
    
}

