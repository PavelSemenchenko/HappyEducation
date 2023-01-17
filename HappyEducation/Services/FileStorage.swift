//
//  FileStorage.swift
//  HappyEducation
//
//  Created by Pavel Semenchenko on 17.01.2023.
//

import Foundation
import FirebaseStorage

protocol FileStorageService {
    func uploadTeacherPhoto(teacherId: String, photo: URL, completion: @escaping (String?) -> Void)
}

class FirebaseFileStorageService: FileStorageService {
    func uploadTeacherPhoto(teacherId: String, photo: URL, completion: @escaping (String?) -> Void) {
        let storage = Storage.storage()
        let ref = storage.reference()
        
        let photoRef = ref.child("teachers/\(teacherId).jpg")
        
        let metadata = StorageMetadata()
        metadata.contentType = "image/jpeg"
        
        let uploadTask = photoRef.putFile(from: photo, metadata: metadata)
        uploadTask.observe(.success) { snapshot in
            completion(nil)
        }
        uploadTask.observe(.failure) { snapshot in
            completion(snapshot.error?.localizedDescription)
        }
        uploadTask.enqueue()
    }
}
