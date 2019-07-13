//
//  AddEditCategoryVC.swift
//  ArdableAdmin
//
//  Created by 山本裕太 on 2019/07/13.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit

class AddEditCategoryVC: UIViewController {
    // outlet
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryImg: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        /// require tap count
        tap.numberOfTapsRequired = 1
        
        categoryImg.isUserInteractionEnabled = true
        categoryImg.addGestureRecognizer(tap)
        
    }
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImgPicker()
    }

    @IBAction func addCategoryClicked(_ sender: Any) {
    }
}

/// UINavigationControllerDelegteはpush popされた時の動作を変更する為に適応
extension AddEditCategoryVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        guard let image = info[.originalImage] as? UIImage else { return }
        categoryImg.contentMode = .scaleAspectFill
        categoryImg.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
