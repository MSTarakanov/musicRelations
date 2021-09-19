//
//  ImageLoader.swift
//  MusicRelations
//
//  Created by Максим Тараканов on 19.09.2021.
//

import UIKit

class ImageLoader {
    private var loadedImages = [URL: UIImage]()
    private var runningLoadings = [UUID: URLSessionDataTask]()
    
    func loadImage(_ url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) -> UUID? {
        if let image = loadedImages[url] {
            completion(.success(image))
        }
        let uuid = UUID()
        
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            defer {self.runningLoadings.removeValue(forKey: uuid) }
            
            if let data = data, let image = UIImage(data: data) {
                self.loadedImages[url] = image
                completion(.success(image))
                return
            }
            
            if let error = error {
                guard (error as NSError).code == NSURLErrorCancelled else {
                    completion(.failure(error))
                    return
                }
            }
        }
        task.resume()

        runningLoadings[uuid] = task
        return uuid
    }
    
    func cancelLoad(_ uuid: UUID) {
        runningLoadings[uuid]?.cancel()
        runningLoadings.removeValue(forKey: uuid)
    }
}
