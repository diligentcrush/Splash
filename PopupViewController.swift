//
//  PopupViewController.swift
//  Splash
//
//  Created by Keshav Pothireddy on 11/17/18.
//  Copyright © 2018 UWAVES. All rights reserved.
//

import UIKit

class PopupViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    @IBOutlet weak var closePopup: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        closePopup.layer.cornerRadius = 10
        closePopup.clipsToBounds = true

    }
    

    @IBAction func closePopup(_ sender: UIButton) {
        dismiss(animated: true, completion: nil)
    }
    
}
