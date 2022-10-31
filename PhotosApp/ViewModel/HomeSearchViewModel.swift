//
//  HomeSearchViewModel.swift
//  PhotosApp
//
//  Created by Alexis on 30/10/22.
//

import Foundation
import Combine
import Contacts


class HomeSearchViewModel: ObservableObject {
    @Published var searchText: String = ""
    @Published var dataArray: [PhotosData] = []
    @Published var count = 1
    @Published var newSearch: Bool = false
    @Published var names : [CNContact] = []
    var cancelable = Set<AnyCancellable>()
    let dataService: DataServiceProtocol
    
    
    init( dataService: DataServiceProtocol = DataService.shared) {
            self.dataService = dataService
        }
    
    func fetchDataInfinity(perPage: Int,newSearch: Bool) {
        dataService.getData(perPage: perPage, page: count,searchText: searchText.replacingOccurrences(of: " ", with: ""))
            .sink { error in
                print(error)
            } receiveValue: { [weak self] returnData in
                if newSearch {
                    self?.count += 1
                    self?.dataArray.append(contentsOf: returnData.photos.photo)
                }else{
                    self?.dataArray =  returnData.photos.photo
                }
            }
            .store(in: &cancelable)
    }
    
     func fetchAllContacts() async {
         //Run in the backgroaund
        let store = CNContactStore()
        let keys = [CNContactGivenNameKey] as [CNKeyDescriptor ]
        let fetchRequest = CNContactFetchRequest(keysToFetch: keys)
        do {
                try store.enumerateContacts(with: fetchRequest, usingBlock: {[weak self] contact, Result in
                    print(contact.givenName )
                    self?.names.append(contact)
                })
                
        } catch  {
            print(error.localizedDescription)
        }
        
    }

    
}
