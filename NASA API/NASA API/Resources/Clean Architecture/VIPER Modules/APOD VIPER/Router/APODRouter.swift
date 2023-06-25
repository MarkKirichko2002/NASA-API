//
//  APODRouter.swift
//  Super easy dev
//
//  Created by Марк Киричко on 15.05.2023
//

protocol APODRouterProtocol {
    func openCalendar()
}

class APODRouter: APODRouterProtocol {
   
    weak var viewController: APODViewController?
    
    func openCalendar() {
        let vc = CalendarViewController()
        viewController?.present(vc, animated: true)
    }
}
