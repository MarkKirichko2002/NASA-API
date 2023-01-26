//
//  APIManager.swift
//  NASA API
//
//  Created by Марк Киричко on 24.01.2023.
//

import Alamofire

class APIManager {
    
    static let shared = APIManager()
    
    private var url = ""
    
    func fetchAPOD(completion: @escaping(Apod)->()) {
        
        url = "https://api.nasa.gov/planetary/apod?api_key=iN4Lu3Ku0270mo9YWlhXAgJAuwbEQ8aobiGZo6tX"
        
        AF.request(url).responseData { response in
            guard let data = response.data else {return}
            
            var response: Apod?
            
            do {
                response = try JSONDecoder().decode(Apod.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let apod = response else {return}
                completion(apod)
            }
        }
    }
    
    func fetchMarsPhotos(completion: @escaping([Photo])->()) {
        
        url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=iN4Lu3Ku0270mo9YWlhXAgJAuwbEQ8aobiGZo6tX"
        
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
    
    func fetchNASAImages(completion: @escaping([NASAImageViewModel])->()) {
        
        var imageViewModels = [NASAImageViewModel]()
        
        url = "https://images-api.nasa.gov/search?q=apollo%2022&description=moon%20landing&media_type=image"
        
        AF.request(url).responseData { response in
            
            guard let data = response.data else {return}
            
            var response: NASAImageAndVideoLibrary?
            
            do {
                response = try JSONDecoder().decode(NASAImageAndVideoLibrary.self, from: data)
            } catch {
                print(error)
            }
            
            guard let nasaimages = response?.collection.items else {return}
            
            DispatchQueue.main.async {
                
                for i in nasaimages {
                    for i in i.links {
                        imageViewModels.append(NASAImageViewModel(image: i.href))
                        completion(imageViewModels)
                    }
                }
            }
        }
    }
    
    func fetchNASAImagesInfo(completion: @escaping([NASAImageInfoViewModel])->()) {
        
        var imageInfoViewModel = [NASAImageInfoViewModel]()
        
        url = "https://images-api.nasa.gov/search?q=apollo%2022&description=moon%20landing&media_type=image"
        
        AF.request(url).responseData { response in
            
            guard let data = response.data else {return}
            
            var response: NASAImageAndVideoLibrary?
            
            do {
                response = try JSONDecoder().decode(NASAImageAndVideoLibrary.self, from: data)
            } catch {
                print(error)
            }
            
            guard let nasaimages = response?.collection.items else {return}
            
            DispatchQueue.main.async {
                for i in nasaimages {
                    for i in i.data {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        let date = dateFormatter.date(from:i.dateCreated)!
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                        let finalDate = calendar.date(from:components)
                        imageInfoViewModel.append(NASAImageInfoViewModel(title: i.title, date: "\(finalDate ?? Date())", description: i.dataDescription))
                        completion(imageInfoViewModel)
                    }
                }
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
