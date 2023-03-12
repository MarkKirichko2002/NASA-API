//
//  AsteroidsViewModel.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import Foundation
import RxCocoa
import RxSwift

class AsteroidsViewModel {
    
    var asteroids = PublishSubject<[NearEarthObject]>()
    
    func GetAsteroids() {
        NASAService.shared.execute(type: Asteroid.self, response: .asteroids) { [weak self] result in
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
