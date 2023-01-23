//
//  NASAViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import Foundation
import RxCocoa
import RxSwift
import Alamofire

class NasaViewModel {
    
    var asteroids = PublishSubject<[NearEarthObject]>()
    
    func GetAsteroids() {
        AF.request("https://api.nasa.gov/neo/rest/v1/feed?start_date=2015-09-07&end_date=2015-09-08&api_key=iN4Lu3Ku0270mo9YWlhXAgJAuwbEQ8aobiGZo6tX").responseData { response in
            guard let data = response.data else {return}
            
            var asteroidResponse: Asteroid?
            
            do {
                asteroidResponse = try JSONDecoder().decode(Asteroid.self, from: data)
                let result = asteroidResponse?.nearEarthObjects
                guard let asteroidresult = result?["2015-09-07", default: [NearEarthObject]()] else {return}
                print(asteroidresult)
                self.asteroids.onNext(asteroidresult)
            } catch {
                print(error)
            }
        }
    }
}
