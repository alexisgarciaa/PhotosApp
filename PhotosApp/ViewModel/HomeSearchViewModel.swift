//
//  HomeSearchViewModel.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import Foundation
import Combine

class HomeSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var dataArray: [PhotosData] = []
    var cancelable = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    
    init( dataService: DataServiceProtocol = DataService.shared) {
            self.dataService = dataService
        }
    
    func fetchData(perPage: Int, page: Int) {
        dataService.getData(perPage: perPage, page: page,searchText: searchText.replacingOccurrences(of: " ", with: ""))
            .sink { error in
                print(error)
            } receiveValue: { [weak self] returnData in
                self?.dataArray =  returnData.photos.photo
            }
            .store(in: &cancelable)
        
    }
    
}
