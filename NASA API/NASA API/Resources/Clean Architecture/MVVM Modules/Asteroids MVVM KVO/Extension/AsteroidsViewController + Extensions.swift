//
//  AsteroidsViewController + Extensions.swift
//  NASA API
//
//  Created by Марк Киричко on 22.06.2023.
//

import UIKit

// MARK: - UITableViewDataSource
extension AsteroidsViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.asteroidsCount() ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath)
        cell.textLabel?.text = "название: \(viewModel?.asteroid(index: indexPath.row).name ?? "")"
        return cell
    }
}
