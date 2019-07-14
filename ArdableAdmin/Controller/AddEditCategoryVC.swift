//
//  AddEditCategoryVC.swift
//  ArdableAdmin
//
//  Created by 山本裕太 on 2019/07/13.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseStorage

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
        activityIndicator.startAnimating()
        uploadImageThenDocument()
    }

    func uploadImageThenDocument() {
        /// 登録されている画像と名前が空ならエラーアラートを出す
        guard let image = categoryImg.image,
            let categoryName = nameTxt.text, categoryName.isNotEmpty else {
                simpleAlert(title: "ERROR", msg: "Must add category image and name")
                return
        }
        
        /// 画像をデータ型に変更する
        guard let imageData = image.jpegData(compressionQuality: 0.2) else { return }
        
        /// storageの画像への参照を作成する
        let imageRef = Storage.storage().reference().child("/categoryImages/\(categoryName).jpg")
        
        /// metadataを作成する
        let metaData = StorageMetadata()
        metaData.contentType = "image/jpg"
        
        /// 画像をアップロードする
        imageRef.putData(imageData, metadata: metaData) { (metaData, error) in
            /// エラーハンドリング
            if let error = error {
                debugPrint(error.localizedDescription)
                self.simpleAlert(title: "ERROR", msg: "アップロード出来ません。")
                self.activityIndicator.stopAnimating()
                return
            }
            /// 画像がアップロードされたらDownload URLを取得する
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    debugPrint(error.localizedDescription)
                    self.simpleAlert(title: "ERROR", msg: "アップロード出来ません。")
                    self.activityIndicator.stopAnimating()
                    return
                }
                
                guard let url = url else { return }
                /// 画像がアップロードされた時のurlをデバッグエリアへ表示する
                print(url)
                
            })
            
        }
    }
    
    func uploadDocument() {
        
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


/// -memo
/// turn the image into data
/// create an storage image reference -> A location in firestorage for it to be stored
/// set the meta data
/// once the image is uploaded, relative the download URL
/// upload new category document to the firestore categories collection