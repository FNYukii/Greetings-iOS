//
//  FireImage.swift
//  Greetings
//
//  Created by Yu on 2022/05/09.
//

import FirebaseStorage
import SwiftUI

class FireImage {
    
    static func uploadImage(image: UIImage) {
        let data = image.pngData()!

        let storage = Storage.storage()
        let storageRef = storage.reference()
        let imageRef = storageRef.child("icons/\(FireAuth.userId()).png")
        
        imageRef.putData(data, metadata: nil)
    }
}
