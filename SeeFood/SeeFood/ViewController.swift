//
//  ViewController.swift
//  SeeFood
//
//  Created by Arthur Kho on 11/06/2018.
//  Copyright © 2018 Arthur Kho. All rights reserved.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var imageView: UIImageView!
  
  let imagePicker = UIImagePickerController()
  
  @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  func detect(image: CIImage) {
    
    guard let model = try? VNCoreMLModel(for: Inceptionv3().model) else {
      fatalError("Could not load CoreML model")
    }
    
    let request = VNCoreMLRequest(model: model) { (request, error) in
      guard let results = request.results as? [ VNClassificationObservation ] else {
        fatalError("Model failed to process the image")
      }
      
      if let firstResult = results.first {
        if firstResult.identifier.contains("hotdog") {
          self.navigationItem.title = "Hotdog!"
        }
        else {
          self.navigationItem.title = "Not hotdog!") 
        }
      }
      
    }
    
    let handler = VNImageRequestHandler(ciImage: image)
    
    do {
      try handler.perform( [request] )
    }
    catch {
      print(error)
    }
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let userPickedImage = info[ UIImagePickerControllerOriginalImage ] as? UIImage {
      imageView.image = userPickedImage
      
      guard let ciImage = CIImage(image: userPickedImage) else {
        fatalError("Could not convert UIImage into CIImage")
      }
      
      detect(image: ciImage)
    }
    
    imagePicker.dismiss(animated: true, completion: nil)
  }
  
  override func viewDidLoad() {
    super.viewDidLoad()
    
    imagePicker.delegate      = self
    imagePicker.sourceType    = .camera
    imagePicker.allowsEditing = false
  }

}

