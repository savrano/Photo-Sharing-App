//
//  HomeViewController.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 2.02.2022.
//

import UIKit
import Firebase
import SDWebImage
class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource {

    @IBOutlet weak var tableView: UITableView!
    
    var emailArray = [String]()
    var commentArray = [String]()
    var imageArray = [String]()
    var postArray = [PostEntity]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        // Do any additional setup after loading the view.
        getDataFireBase()
    }
    func getDataFireBase(){
        let fireStoreDb = Firestore.firestore()
        fireStoreDb.collection("Post").order(by: "date", descending: true)
            .addSnapshotListener { snapshot, error in
            if error != nil{
            }else {
                if snapshot?.isEmpty != true && snapshot != nil {
                    
                    self.postArray.removeAll(keepingCapacity: false)
                    
                    for doc in snapshot!.documents {
                        
                        if let imageUrl = doc.get("imageUrl") as? String {
                            
                            if let email = doc.get("email") as? String {
                                
                                if let comment = doc.get("comment") as? String {
                                    
                                    let postEntity = PostEntity(email: email, comment: comment, imageUrl: imageUrl)
                                    self.postArray.append(postEntity)
                                }
                            }
                        }
                    }
                    self.tableView.reloadData()
                }
            }
        }
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return postArray.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath) as! HomeTableViewCell
        cell.emailText.text = postArray[indexPath.row].email
        cell.commentText.text = postArray[indexPath.row].comment
        cell.postImageView.sd_setImage(with: URL(string: self.postArray[indexPath.row].imageUrl))
        return cell
    }
}
