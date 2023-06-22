//
//  AsteroidsViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import Foundation

final class AsteroidsViewModel: NSObject {
    
    @objc dynamic var asteroids: [NearEarthObject] = []
    
    var observation: NSKeyValueObservation?
    
    private var nasaService: NASAServiceProtocol?
    
    // MARK: - Init
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func asteroidsCount()-> Int {
        return asteroids.count
    }
    
    func asteroid(index: Int)-> NearEarthObject {
        return asteroids[index]
    }
    
    func GetAsteroids() {
        nasaService?.execute(type: Asteroid.self, response: .asteroids) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data.nearEarthObjects?["2015-09-07", default: [NearEarthObject]()] else {
                    return
                }
                DispatchQueue.main.async {
                    self?.asteroids = data
                }
            case .failure(let error):
                print(error)
            }
        }
    }
}
