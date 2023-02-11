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
        NASAService.shared.fetchAsteroids { asteroidresult in
            self.asteroids.onNext(asteroidresult)
        }
    }
}
