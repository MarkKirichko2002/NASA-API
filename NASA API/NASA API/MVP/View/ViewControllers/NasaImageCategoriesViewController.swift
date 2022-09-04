//
//  NasaImageCategoriesViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 31.08.2022.
//

import UIKit

class NasaImageCategoriesViewController: UITableViewController {
    
    var categories = [NasaImageCategory(id: 1, name: "NASA Mars Rover Images", icon: "rover"), NasaImageCategory(id: 2, name: "NASA Image Library", icon: "NASA"), NasaImageCategory(id: 3, name: "EPIC", icon: "EPIC")]
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NasaImagesTableViewController") as? NasaImagesTableViewController {
            vc.category = categories[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categories.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NasaImageCategoriesTableViewCell.identifier, for: indexPath) as! NasaImageCategoriesTableViewCell
        
        cell.CategoryIcon.image = UIImage(named: categories[indexPath.row].icon)
        cell.CategoryIcon.layer.cornerRadius = cell.CategoryIcon.frame.width / 2
        cell.CategoryIcon.layer.borderWidth = 5
        cell.CategoryName.text = categories[indexPath.row].name
        
        return cell
    }
    
    
}
