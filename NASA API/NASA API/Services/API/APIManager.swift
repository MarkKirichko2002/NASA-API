//
//  APIManager.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private var url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=iN4Lu3Ku0270mo9YWlhXAgJAuwbEQ8aobiGZo6tX"
    
    func fetchMarsPhotos(completion: @escaping([Photo])->()) {
       
        AF.request(url).responseData { response in
            guard let data = response.data else {return}
            
            var response: MarsImage?
            
            do {
                response = try JSONDecoder().decode(MarsImage.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let marsimages = response?.photos else {return}
                completion(marsimages)
            }
        }
    }
    
    func fetchEPICImages(completion: @escaping([EPIC])->()) {
        
        url = "https://epic.gsfc.nasa.gov/api/natural"
        
        AF.request(url).responseData { response in
            guard let data = response.data else {return}
            
            var epicResponse: [EPIC]?
            
            do {
                epicResponse = try JSONDecoder().decode([EPIC].self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let epicimages = epicResponse else {return}
                completion(epicimages)
            }
        }
    }
}
