//
//  DataService.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import SwiftUI
import Combine

protocol DataServiceProtocol{
    func getData(perPage: Int, page: Int,searchText: String) -> AnyPublisher<ResponsePhotos, Error>
}

class DataService: DataServiceProtocol{
    static let shared: DataServiceProtocol = DataService()
    private init() { }
    
    func getData(perPage: Int, page: Int,searchText: String) -> AnyPublisher<ResponsePhotos, Error> {
        let url: URL = URL(string: "https://www.flickr.com/services/rest/?method=flickr.photos.search&api_key=70fdb0e0bfd1f2a4e7a13143e2d01322&text=\(searchText)&per_page=\(perPage)&page=\(page)&format=json&nojsoncallback=1")!

       return  URLSession.shared.dataTaskPublisher(for: url)
            .map({ $0.data })
            .decode(type: ResponsePhotos.self, decoder: JSONDecoder())
            .receive(on: DispatchQueue.main)
            .eraseToAnyPublisher()
    }
}

