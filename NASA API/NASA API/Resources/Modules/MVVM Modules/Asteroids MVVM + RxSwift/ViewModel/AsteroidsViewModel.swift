//
//  AsteroidsViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

final class AsteroidsViewModel {
    
    var asteroids = PublishSubject<[NearEarthObject]>()
    private var nasaService: NASAServiceProtocol?
    
    init(nasaService: NASAServiceProtocol?) {
        self.nasaService = nasaService
    }
    
    func GetAsteroids() {
        nasaService?.execute(type: Asteroid.self, response: .asteroids) { [weak self] result in
            switch result {
            case .success(let data):
                guard let data = data.nearEarthObjects?["2015-09-07", default: [NearEarthObject]()] else {
                    return
                }
                self?.asteroids.onNext(data)
            case .failure(let error):
                print(error)
            }
        }
    }
}
