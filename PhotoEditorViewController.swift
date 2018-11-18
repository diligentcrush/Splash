//
//  PhotoEditorViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/17/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    
    var selectedImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        postButton.layer.cornerRadius = 15
        postButton.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
       photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true

    }
    
    @objc func handleSelectPhoto() {
        if UIImagePickerController.isSourceTypeAvailable(.photoLibrary) {
        }
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo.image = image
        }
        
    }
    
    @IBAction func cancelEdit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    

}
