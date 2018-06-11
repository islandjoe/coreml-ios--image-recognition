//
//  ViewController.swift
//  SeeFood
//
//  Created by Arthur Kho on 11/06/2018.
//  Copyright © 2018 Arthur Kho. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

  @IBOutlet weak var imageView: UIImageView!
  
  let imagePicker = UIImagePickerController()
  
  @IBAction func cameraTapped(_ sender: UIBarButtonItem) {
    present(imagePicker, animated: true, completion: nil)
  }
  
  func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [String : Any]) {
    if let userPickedImage = info[ UIImagePickerControllerOriginalImage ] as? UIImage {
      imageView.image = userPickedImage
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

