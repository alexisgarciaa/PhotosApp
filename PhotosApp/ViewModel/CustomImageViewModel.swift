//
//  CustomImageViewModel.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI
import Combine

class CustomImageViewModel: ObservableObject {
    @Published var image: UIImage? = nil
    
    let loader = DownloadImageService()
    var cancelable = Set<AnyCancellable>()
    
    func downloadimage(serverId: String, photoId: String, secret: String) {
       // self.image = UIImage(systemName: "heart.fill")
        loader.downloadimage(serverId: serverId, photoId: photoId, secret: secret)
            .receive(on: DispatchQueue.main)
            .sink { _ in
                
            } receiveValue: { [weak self] image in
                    self?.image = image
            }
            .store(in: &cancelable)

    }
}
