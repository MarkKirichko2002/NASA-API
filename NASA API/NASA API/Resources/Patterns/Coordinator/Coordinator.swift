//
//  Coordinator.swift
//  NASA API
//
//  Created by Марк Киричко on 03.05.2023.
//

import Foundation
import UIKit

enum Event {
    case startButtonWasClicked
}

protocol Coordinator {
    var navigationController: UINavigationController? {get set}
    var children: [Coordinator]? {get set}
    
    func eventOccured(with type: Event)
    func start()
}

protocol Coordinating {
    var coordinator: Coordinator? {get set}
}
