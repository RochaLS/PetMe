//
//  UIImageView+DownloadImage.swift
//  PetMe
//
//  Created by Lucas Rocha on 2020-06-07.
//  Copyright © 2020 Lucas Rocha. All rights reserved.
//

import Foundation
import Firebase

let imageCache = NSCache<AnyObject, AnyObject>()
var db = Firestore.firestore()
var storageRef = Storage.storage().reference()

extension PetAvatarImageView {
    func getImageFromNetworkOrCached(for pet: Pet) {
        
        //Check if we already have the img in cache
        
        self.image = nil
        self.contentMode = .scaleAspectFill
        
        if let cachedImage = imageCache.object(forKey: pet.imgName as AnyObject) as? UIImage {
            self.image = cachedImage
        }
        
        //Otherwise download image from storage
        let imgRef = storageRef.child("pets/\(pet.imgName!)")
        
        DispatchQueue.global(qos: .background).async {
            DispatchQueue.main.async {
                imgRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
                    if error != nil {
                        print(error?.localizedDescription as Any)
                        return
                    } else {
                        //Put image in cache
                        if let downloadedImage = UIImage(data: data!) {
                            imageCache.setObject(downloadedImage, forKey: pet.imgName as AnyObject)
                            self.image = downloadedImage
                        }
                    }
                }
            }
        }
    }
}

//func loadImageUsingCacheWithUrlString(urlString: String) {
//   self.image = nil
//   // check cache wether image is aleady exsist
//   if let cachedImage = imageCache.object(forKey: urlString as AnyObject) as? UIImage {
//     self.image = cachedImage
//     return
//   }
//   // otherwise fire off a new download
//   let url = URL(string: urlString)
//   URLSession.shared.dataTask(with: url!, completionHandler: { (data, response, error) in
//     if error != nil {
//       print(error!)
//       return
//     }
//     DispatchQueue.global(qos: .background).async {
//       DispatchQueue.main.async {
//         if let downloadedImage = UIImage(data: data!) {
//           imageCache.setObject(downloadedImage, forKey: urlString as AnyObject)
//           self.image = downloadedImage
//         }
//       }
//     }
//   }).resume()
// }

extension UIImage {
    static func getImageFromNetworkOrCached(for pet: Pet, completion: @escaping (UIImage) -> Void) {
           
           //Check if we already have the img in cache
           
           
        if let cachedImage = imageCache.object(forKey: pet.imgName! as NSString) as? UIImage {
               completion(cachedImage)
           }
           
           //Otherwise download image from storage
           let imgRef = storageRef.child("pets/\(pet.imgName!)")
           
           DispatchQueue.main.async {
               imgRef.getData(maxSize: 5 * 1024 * 1024) { (data, error) in
                   if error != nil {
                       print(error?.localizedDescription as Any)
                       return
                   } else {
                       //Put image in cache
                       if let downloadedImage = UIImage(data: data!) {
                        imageCache.setObject(downloadedImage, forKey: pet.imgName! as NSString)
                           completion(downloadedImage)
                       }
                   }
               }
           }
           
           if pet.imgName == "placeholder" {
            completion(UIImage(named: "placeholder")!)
           }
       }
}
