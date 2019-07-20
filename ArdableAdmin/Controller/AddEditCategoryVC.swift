//
//  AddEditCategoryVC.swift
//  ArdableAdmin
//
//  Created by 山本裕太 on 2019/07/13.
//  Copyright © 2019 山本裕太. All rights reserved.
//

import UIKit
import FirebaseStorage
import FirebaseFirestore

class AddEditCategoryVC: UIViewController {
    // outlet
    @IBOutlet weak var nameTxt: UITextField!
    @IBOutlet weak var categoryImg: RoundedImageView!
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    @IBOutlet weak var addBtn: UIButton!
    
    // Variable
    var categoryToEdit : Category?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let tap = UITapGestureRecognizer(target: self, action: #selector(imgTapped(_:)))
        /// require tap count
        tap.numberOfTapsRequired = 1
        
        categoryImg.isUserInteractionEnabled = true
        categoryImg.addGestureRecognizer(tap)
        
        /// 編集している時categoryToEditはnilではない
        if let category = categoryToEdit {
            nameTxt.text = category.name
            addBtn.setTitle("Save changes", for: .normal)
            
            if let url = URL(string: category.imgUrl) {
                categoryImg.contentMode = .scaleAspectFill
                categoryImg.kf.setImage(with: url)
            }
        }
    }
    
    @objc func imgTapped(_ tap: UITapGestureRecognizer) {
        launchImgPicker()
    }

    @IBAction func addCategoryClicked(_ sender: Any) {
        uploadImageThenDocument()
    }

    func uploadImageThenDocument() {
        /// 登録されている画像と名前が空ならエラーアラートを出す
        guard let image = categoryImg.image,
            let categoryName = nameTxt.text, categoryName.isNotEmpty else {
                simpleAlert(title: "ERROR", msg: "Must add category image and name")
                return
        }
        
        activityIndicator.startAnimating()
        
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
                self.handleError(error: error, msg: "画像をアップロード出来ません。")
                return
            }
            /// 画像がアップロードされたらDownload URLを取得する
            imageRef.downloadURL(completion: { (url, error) in
                if let error = error {
                    self.handleError(error: error, msg: "URLがありません。")
                    return
                }
                
                guard let url = url else { return }
                /// 画像がアップロードされた時のurlをデバッグエリアへ表示する
                print(url)
                
                self.uploadDocument(url: url.absoluteString)
            })
            
        }
    }
    
    func uploadDocument(url: String) {
        var docRef: DocumentReference!
        var category = Category.init(name: nameTxt.text!, id: "", imgUrl: url, timeStamp: Timestamp())
        
        /// 
        if let categoryToEdit = categoryToEdit {
            /// 編集
            docRef = Firestore.firestore().collection("categories").document(categoryToEdit.id)
            category.id = categoryToEdit.id
        } else {
            /// 新しいカテゴリ
            docRef = Firestore.firestore().collection("categories").document()
            category.id = docRef.documentID
        }
        
        docRef = Firestore.firestore().collection("categories").document()
        category.id = docRef.documentID
        
        /// categoryを辞書型へ変換する
        let data = Category.modelToData(category: category)
    
        docRef.setData(data, merge: true) { (error) in
            if let error = error {
                self.handleError(error: error, msg: "新しいカテゴリーをFirestoreにアップロード出来ません。")
                return
            }
            
            self.navigationController?.popViewController(animated: true)
        }
    }
    
    /// エラーハンドリング
    func handleError(error: Error, msg: String) {
        debugPrint(error.localizedDescription)
        self.simpleAlert(title: "ERROR", msg: "アップロード出来ません。")
        self.activityIndicator.stopAnimating()
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
