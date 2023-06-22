//
//  CalendarViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import FSCalendar

// MARK: - FSCalendarDelegate
extension CalendarViewController: FSCalendarDelegate {
    
    func calendar(_ calendar: FSCalendar, didSelect date: Date, at monthPosition: FSCalendarMonthPosition) {
        let formatter = DateFormatter()
        formatter.dateFormat = "YYYY-MM-dd"
        let date = formatter.string(from: date)
        NotificationCenter.default.post(name: Notification.Name("DateWasSelected"), object: date)
        self.dismiss(animated: true)
    }
}
