//
//  CalendarViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 05.06.2023.
//

import UIKit
import FSCalendar

// MARK: - CalendarViewControllerDelegate
protocol CalendarViewControllerDelegate: AnyObject {
    func dataWasSelected(date: String)
}

final class CalendarViewController: UIViewController {
    
    weak var delegate: CalendarViewControllerDelegate?
    
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

// MARK: - FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let string = formatter.string(from: date)
        delegate?.dataWasSelected(date: string)
        self.dismiss(animated: true)
    }
}
