//
//  EarthViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import SDWebImage

// MARK: - EarthViewProtocol
extension EarthViewController: EarthViewProtocol {
    func PresentEarth(earth: Earth)  {
        EarthImage.sd_setImage(with: URL(string: earth.url ?? ""))
    }
}
