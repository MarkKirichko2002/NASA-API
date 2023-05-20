//
//  CalendarViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 16.04.2023.
//

import UIKit
import FSCalendar

final class CalendarViewController: UIViewController {
    
    private let Calendar: FSCalendar = {
        let calendar = FSCalendar()
        calendar.translatesAutoresizingMaskIntoConstraints = false
        return calendar
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .systemBackground
        view.addSubview(Calendar)
        Calendar.delegate = self
        makeConstraints()
    }
    
    private func makeConstraints() {
        NSLayoutConstraint.activate([
            Calendar.topAnchor.constraint(equalTo: view.safeAreaLayoutGuide.topAnchor),
            Calendar.leftAnchor.constraint(equalTo: view.safeAreaLayoutGuide.leftAnchor),
            Calendar.rightAnchor.constraint(equalTo: view.safeAreaLayoutGuide.rightAnchor),
            Calendar.heightAnchor.constraint(equalToConstant: 300)
        ])
    }
}

extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let string = formatter.string(from: date)
        self.dismiss(animated: true)
    }
}
