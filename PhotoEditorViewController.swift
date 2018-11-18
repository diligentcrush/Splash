//
//  PhotoEditorViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/17/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit

class PhotoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var postButton: UIButton!
    @IBOutlet weak var photoCaption: UITextView!
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    
    var selectedImage = UIImage()

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // photoCaption.delegate = self
        
        postButton.layer.cornerRadius = 15
        postButton.clipsToBounds = true
        
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(self.handleSelectPhoto))
       photo.addGestureRecognizer(tapGesture)
        photo.isUserInteractionEnabled = true
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
       photoCaption.delegate = self
        
        
    }
    
    func textViewShouldReturn(_ textView: UITextView) -> Bool {
        textView.resignFirstResponder()
        return true
    }
    
   deinit {
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillShow(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
     
     NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillHide(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        
    } 
   
    @objc func keyboardWillShow(notification: Notification) {
        if let userInfo = notification.userInfo as? Dictionary<String, AnyObject>{
            let frame = userInfo[UIResponder.keyboardFrameEndUserInfoKey]
            let keyBoardRect = frame?.cgRectValue
            if let keyBoardHeight = keyBoardRect?.height as? Float {
                self.txtBC.constant = CGFloat(keyBoardHeight)
            }
        }
    }
    
    @objc func keyboardWillHide(notification: Notification) {
        self.txtBC.constant = 205.0
        
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
