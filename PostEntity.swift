//
//  PostEntity.swift
//  PhotoSharingApp
//
//  Created by Yağız Savran on 2.02.2022.
//

import Foundation

class PostEntity {
    
    var email : String
    var comment : String
    var imageUrl : String
    
    
    init(email : String, comment : String, imageUrl : String){
        self.email = email
        self.comment = comment
        self.imageUrl = imageUrl
    }
}
