//
//  PhotoEditorViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/17/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit
import Firebase
import FirebaseStorage
import FirebaseDatabase
import FirebaseAuth

class PhotoEditorViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate, UITextViewDelegate {
    
    @IBOutlet weak var photo: UIImageView!
    @IBOutlet weak var postButtonStyle: UIButton!
    @IBOutlet weak var photoCaption: UITextView!
    @IBOutlet weak var txtBC: NSLayoutConstraint!
    
    var selectedImage: UIImage?
    var imageStorageRef: StorageReference {
        return Storage.storage().reference().child("images")
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        
       // photoCaption.delegate = self
        
        postButtonStyle.layer.cornerRadius = 15
        postButtonStyle.clipsToBounds = true
        
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
        imagePicker.allowsEditing = true
        self.present(imagePicker, animated: true, completion: nil)
    }
    
    
    @objc func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey: Any]) {
        picker.dismiss(animated: true, completion: nil)
        
        if let image = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            photo.image = image
        }
        
    }
    
    @IBAction func cancelEdit(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
    @IBAction func postButtonTap(_ sender: UIButton) {
        guard let image = photo.image else {return}
        guard let imageData = image.jpegData(compressionQuality: 1) else {return}
            let photoID = NSUUID().uuidString
        
        let uploadRef = imageStorageRef.child(photoID)
        let imageDbRef = Database.database().reference().child("posts").childByAutoId()
        let postObject = [
            "timestamp": [".sv":"timestamp"]
        ] as [String:Any]
        
        imageDbRef.setValue(postObject, withCompletionBlock: {error, ref in
            if error == nil {
                self.dismiss(animated: true, completion: nil)
            } else {
                // Handle the error
            }
        })
        
        let uploadTask = uploadRef.putData(imageData, metadata: nil) { (metadata, error) in
            print("UPLOAD TASK FINISHED")
            print(metadata ?? "NO METADATA")
            print(error ?? "NO ERROR")
        }
        
        uploadTask.observe(.progress) { (snapshot) in
            print(snapshot.progress ?? "NO MORE PROGRESS")
        }
        
        uploadTask.resume()
        
        dismiss(animated: true, completion: nil)
        
        }
    
        
    }
