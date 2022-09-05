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
    func PresentNASAImages(images: [LibraryData])
    func PresentNASAImagesInfo(info: [Link])
    func PresentEPICNASAImages(images: [EPIC])
}

protocol VideoPresentDelegate {
    func PresentNASAVideos(videos: [LibraryData])
    func PresentNASAVideosInfo(info: [Link])
    func GetNASAVideosJSONS(jsons: [String])
}

protocol VideoPlayerDelegate {
    func PresentNASAVideo(video: String)
}

typealias Presenter = PhotoPresentDelegate & UIViewController
typealias VideoPresenter = VideoPresentDelegate & UIViewController
typealias VideoPlayerPresenter = VideoPlayerDelegate & UIViewController

class NASAPresenter {
    
    // images
    var delegate: Presenter?
    var marsimages = [Photo]()
    var nasaimagesinfo = [LibraryData]()
    var nasaimages = [Link]()
    var epicimages = [EPIC]()
    // videos
    var videodelegate: VideoPresenter?
    var videoplayerdelegate: VideoPlayerPresenter?
    var nasavideosinfo = [LibraryData]()
    var nasavideos = [Link]()
    var videojsons = [String]()
    var videourls = [String]()
    
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
            
            var response: NASAImageAndVideoLibrary?
            
            do {
                response = try JSONDecoder().decode(NASAImageAndVideoLibrary.self, from: data)
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
                        self.nasaimagesinfo.append(LibraryData(center: i.center, title: i.title, nasaID: i.nasaID, dateCreated: "\(finalDate ?? Date())", mediaType: i.mediaType, dataDescription: i.dataDescription, keywords: i.keywords, album: i.album, location: i.location, description508: i.description508, secondaryCreator: i.secondaryCreator))
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
    
    func GetEPICImages() {
        let url = "https://epic.gsfc.nasa.gov/api/enhanced"
        
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
                self.epicimages = epicimages
                print(self.epicimages)
                self.delegate?.PresentEPICNASAImages(images: epicimages)
            }
        }
    }
    
    func GetNASAVideos() {
        
        let url = "https://images-api.nasa.gov/search?q=apollo%2022&description=moon%20landing&media_type=video"
        
        AF.request(url).responseData { response in
            guard let data = response.data else {return}
            
            var videoResponse: NASAImageAndVideoLibrary?
            
            do {
                videoResponse = try JSONDecoder().decode(NASAImageAndVideoLibrary.self, from: data)
            } catch {
                print(error)
            }
            
            DispatchQueue.main.async {
                guard let nasavideos = videoResponse?.collection.items else {return}
                
                for i in nasavideos {
                    self.videojsons.append(i.href)
                    self.videodelegate?.GetNASAVideosJSONS(jsons: self.videojsons)
                }
                
                for i in nasavideos {
                    for i in i.data {
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"
                        let date = dateFormatter.date(from:i.dateCreated)!
                        let calendar = Calendar.current
                        let components = calendar.dateComponents([.year, .month, .day, .hour], from: date)
                        let finalDate = calendar.date(from:components)
                        self.nasavideosinfo.append(LibraryData(center: i.center, title: i.title, nasaID: i.nasaID, dateCreated: "\(finalDate ?? Date())", mediaType: i.mediaType, dataDescription: i.dataDescription, keywords: i.keywords, album: i.album, location: i.location, description508: i.description508, secondaryCreator: i.secondaryCreator))
                        self.videodelegate?.PresentNASAVideos(videos: self.nasavideosinfo)
                    }
                    
                    for i in nasavideos {
                        for i in i.links {
                            self.nasavideos.append(Link(href: i.href, rel: i.rel, render: i.render))
                            self.videodelegate?.PresentNASAVideosInfo(info: self.nasavideos)
                        }
                    }
                    
                }
            }
        }
    }
    
    func ParseNASAVideo(json: String) {
        
        AF.request(json).responseData { response in
            guard let data = response.data else {return}
            
            var jsonResponse: [String]?
            
            do {
                jsonResponse = try JSONDecoder().decode([String].self, from: data)
                
                for i in jsonResponse! {
                    if i.contains("orig.mp4") {
                        DispatchQueue.main.async {
                            self.videoplayerdelegate?.PresentNASAVideo(video: i)
                            print(i)
                        }
                    }
                }
                
            } catch {
                print(error)
            }
        }
    }
    
    func SetViewDelegate(delegate: PhotoPresentDelegate & UIViewController) {
        self.delegate = delegate
    }
    
    func SetVideosViewDelegate(videodelegate: VideoPresentDelegate & UIViewController) {
        self.videodelegate = videodelegate
    }
    
    func SetVideoPlayerDelegate(videoplayer: VideoPlayerDelegate & UIViewController) {
        self.videoplayerdelegate = videoplayer
    }
    
}
