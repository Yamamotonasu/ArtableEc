//
//  AddEditProductsVC.swift
//  ArdableAdmin
//
//  Created by 山本裕太 on 2019/07/15.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseStorage

class AddEditProductsVC: UIViewController {
    /// outlet
    @IBOutlet weak var productNameTxt: UITextField!
    @IBOutlet weak var productPriceTxt: UITextField!
    @IBOutlet weak var productDescTxt: UITextView!
    @IBOutlet weak var productImgView: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: RoundedButton!
    
    
    /// variable
    var selectedCategory : Category!
    var productToEdit : Product?

    override func viewDidLoad() {
        super.viewDidLoad()

        /// 画像をタップした時の反応するようにする
        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped))
        tap.numberOfTapsRequired = 1
        productImgView.isUserInteractionEnabled = true
        productImgView.addGestureRecognizer(tap)
    }
    
    @objc func imgTapped() {
        /// launch the image picker
        launchImgPicker()
    }
    
    @IBAction func addClicked(_ sender: Any) {
        uploadImageThenDocument()
    }
    
    func uploadImageThenDocument() {
        guard let image = productImgView.image,
        let name = productNameTxt.text, name.isNotEmpty,
        let description = productDescTxt.text, description.isNotEmpty,
        let priceString = productPriceTxt.text,
            let price = Double(priceString) else {
                simpleAlert(title: "入力された値が間違っています。", msg: "すべての必須項目を入力してください。")
                return
        }
        
        activityIndicator.startAnimating()
        
        // 画像を登録する
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        let imageRef = Storage.storage().reference().child("/productImages/\(name).jpg")
        
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            if let error = error {
                self.handleError(error: error, msg: ErrorMessages.cannotUpload.rawValue)
                return
            }
            
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: ErrorMessages.cannotDownload.rawValue)
                    return
                }
                
                guard let url = url else { return }
                print(url)
            })
        }
    }
    
    private enum ErrorMessages: String {
        case cannotDownload = "ダウンロード出来ません。"
        case cannotUpload = "アップロード出来ない画像です"
    }
    
    private func uploadDocument() {
        
    }
    
    private func handleError(error: Error, msg: String) {
        debugPrint(error.localizedDescription)
        simpleAlert(title: "Error", msg: msg)
        activityIndicator.stopAnimating()
    }
}

extension AddEditProductsVC: UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    func launchImgPicker() {
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        present(imagePicker, animated: true, completion: nil)
    }
    
    /// userが写真の編集を終えた時に通知を受け取ることができるようにする
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let image = info[.originalImage] as? UIImage else { return }
        productImgView.contentMode = .scaleAspectFill
        productImgView.image = image
        dismiss(animated: true, completion: nil)
    }
    
    func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        dismiss(animated: true, completion: nil)
    }
}
