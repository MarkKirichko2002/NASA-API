//
//  NASAPresenter.swift
//  NASA API
//
//  Created by Марк Киричко on 10.08.2022.
//

import Foundation
import UIKit
import Alamofire

protocol PhotoPresentDelegate {
    func PresentMarsPhotos(images: [Photo])
    func PresentNASAImages(images: [ImageData])
    func PresentNASAImagesInfo(info: [Link])
}

typealias Presenter = PhotoPresentDelegate & UIViewController

class NASAPresenter {
    
    var delegate: Presenter?
    var marsimages = [Photo]()
    var nasaimagesinfo = [ImageData]()
    var nasaimages = [Link]()
    
    func GetMarsPhotos() {
        let url = "https://api.nasa.gov/mars-photos/api/v1/rovers/curiosity/photos?sol=1000&api_key=apikey"
        
        URLSession.shared.dataTask(with: URL(string: url)!) { data, _, error in
            guard let data = data else {return}
            
            var response: MarsImage?
            
            do {
                response = try JSONDecoder().decode(MarsImage.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let marsimages = response?.photos else {return}
                self.marsimages = marsimages
                self.delegate?.PresentMarsPhotos(images: marsimages)
            }
        }.resume()
    }
    
    func GetNASAImages() {
        
        let url = "https://images-api.nasa.gov/search?q=apollo%2022&description=moon%20landing&media_type=image"
        
        AF.request(url).responseData { response in
            
            guard let data = response.data else {return}
            
            var response: NASAImages?
            
            do {
                response = try JSONDecoder().decode(NASAImages.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let nasaimages = response?.collection.items else {return}
                for i in nasaimages {
                    for i in i.data {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        let date = dateFormatter.date(from:i.dateCreated)!
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                        let finalDate = calendar.date(from:components)
                        self.nasaimagesinfo.append(ImageData(center: i.center, title: i.title, nasaID: i.nasaID, dateCreated: "\(finalDate ?? Date())", mediaType: i.mediaType, dataDescription: i.dataDescription, keywords: i.keywords, album: i.album, location: i.location, description508: i.description508, secondaryCreator: i.secondaryCreator))
                        self.delegate?.PresentNASAImages(images: self.nasaimagesinfo)
                    }
                    
                    for i in nasaimages {
                        for i in i.links {
                            self.nasaimages.append(Link(href: i.href, rel: i.rel, render: i.render))
                            self.delegate?.PresentNASAImagesInfo(info: self.nasaimages)
                        }
                    }
                    
                }
            }
        }
    }
    
    func SetViewDelegate(delegate: PhotoPresentDelegate & UIViewController) {
        self.delegate = delegate
    }
    
}
