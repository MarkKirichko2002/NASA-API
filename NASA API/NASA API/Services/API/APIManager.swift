//
//  APIManager.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    func fetchEPICImages(completion: @escaping([EPIC])->()) {
        let url = "https://epic.gsfc.nasa.gov/api/natural"
        
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
