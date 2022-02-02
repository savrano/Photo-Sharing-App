//
//  UploadViewController.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 2.02.2022.
//

import UIKit
import Firebase
class UploadViewController: UIViewController,UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var commentTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        imageView.isUserInteractionEnabled = true
        let imageGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectTheImage))
        imageView.addGestureRecognizer(imageGestureRecognizer)
    }
    
    
    @objc func selectTheImage(){
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = true
        present(imagePicker, animated: true, completion: nil)
    }
    
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        imageView.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
    
    }
    
    
    @IBAction func ShareButtonPressed(_ sender: UIButton) {
        let storage = Storage.storage()
        let storageReferance = storage.reference()
        
        let mediaFolder = storageReferance.child("Media")
        
        if let data = imageView.image?.jpegData(compressionQuality: 0.5){
            let uuid = UUID().uuidString
            
            let imageReferance = mediaFolder.child("\(uuid).jpg")
            
            imageReferance.putData(data, metadata: nil) { storageMetaData, error in
                if error != nil {
                    self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "You got an error. Please try again later.")
                }else{
                    imageReferance.downloadURL { url, error in
                        if error == nil {
                            
                            let imageUrl = url?.absoluteString
                            if let imageUrl = imageUrl {
                                
                                let firestoreDatabase = Firestore.firestore()
                                
                                let firestorePost = ["imageUrl" : imageUrl, "comment" : self.commentTextField.text!, "email" : Auth.auth().currentUser!.email, "date" : FieldValue.serverTimestamp() ] as [String : Any]
                                
                                firestoreDatabase.collection("Post").addDocument(data: firestorePost) { error in
                                    
                                    if error != nil {
                                        self.errorMessage(title: "Error!", message: error?.localizedDescription ?? "You got an error. Please try again later")
                                    }else{
                                        self.imageView.image = UIImage(named: "addImage")
                                        self.commentTextField.text = ""
                                        self.tabBarController?.selectedIndex = 0
                                    }
                                }
                            }
                        }
                    }
                }
            }
        }
    }
    func errorMessage(title: String, message: String){
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        let okButton = UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil)
        alert.addAction(okButton)
        present(alert, animated: true, completion: nil)
    }
}
