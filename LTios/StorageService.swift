//
//  StorageService.swift
//  LTios
//
//  Created by Paul Bénéteau on 21/08/2018.
//  Copyright © 2018 Tastyapp. All rights reserved.
//

import FirebaseStorage

class StorageService {
    
   public static var shared = StorageService()
    
    // Get a reference to the storage service using the default Firebase App
    let storage = Storage.storage()
    
    func uploadUserPicture(imageData: Data, uid: String) {
        
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to upload
        let photoRef = storageRef.child("userPhotos/\(uid).jpg")
        
        // Upload the file to the path "images/rivers.jpg"
        let _ = photoRef.putData(imageData, metadata: nil) { (metadata, error) in
            guard metadata != nil else {
                print("[Error] uploading user photo: \(String(describing: error?.localizedDescription))")
                return
            }
            // Metadata contains file metadata such as size, content-type.
            //let size = metadata.size
            // You can also access to download URL after upload.
            photoRef.downloadURL { (url, error) in
                guard let downloadURL = url else {
                    print("[Error] uploading user photo: \(String(describing: error?.localizedDescription))")
                    return
                }
            }
        }
    }
    
    
    func downloadUserPicture(uid: String, completion: @escaping(UIImage?) -> Void) {
        
        let storageRef = storage.reference()
        
        // Create a reference to the file you want to download
        let photoRef = storageRef.child("userPhotos/\(uid).jpg")
        
        // Download in memory with a maximum allowed size of 1MB (1 * 1024 * 1024 bytes)
        photoRef.getData(maxSize: 1 * 1024 * 1024) { data, error in
            if let error = error {
                print("[Error] downloading user photo: \(String(describing: error.localizedDescription))")
                completion(nil)
            } else {
                // Data for "images/island.jpg" is returned
                guard let image = UIImage(data: data!) else {
                    print("[Error] downloading user photo: \(String(describing: error?.localizedDescription))")
                    completion(nil)
                    return
                }
                completion(image)
            }
        }
        
    }
    
    
}
