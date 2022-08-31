//
//  NasaImagesTableViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit
import SDWebImage

class NasaImagesTableViewController: UITableViewController, PhotoPresentDelegate {
    
    var presenter = NASAPresenter()
    var marsimages = [Photo]()
    var nasaimages = [Link]()
    var nasaimagesinfo = [ImageData]()
    var category: NasaImageCategory?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.SetViewDelegate(delegate: self)
        switch category?.id {
            
        case 1:
            presenter.GetMarsPhotos()
            
        case 2:
            presenter.GetNASAImages()
            
        default:
            break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch category?.id {
           
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = "Landing Date: \(marsimages[indexPath.row].rover.landingDate)"
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = nasaimagesinfo[indexPath.row].dataDescription
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category?.id {
            
        case 1:
            return marsimages.count
            
        case 2:
            return nasaimagesinfo.count
            
        default:
            break
            
        }
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NasaImagesTableViewCell.identifier, for: indexPath) as! NasaImagesTableViewCell
        
        switch category?.id {
            
        case 1:
            cell.NASAImage.sd_setImage(with: URL(string: marsimages[indexPath.row].imgSrc))
            cell.NASAImage.layer.cornerRadius = cell.NASAImage.frame.width / 2
            cell.NASAImage.layer.borderWidth = 5
            cell.TitleLabel.text = marsimages[indexPath.row].camera.fullName
            cell.DateLabel.text = marsimages[indexPath.row].earthDate
            
        case 2:
            cell.NASAImage.sd_setImage(with: URL(string: nasaimages[indexPath.row].href))
            cell.NASAImage.layer.cornerRadius = cell.NASAImage.frame.width / 2
            cell.NASAImage.layer.borderWidth = 5
            cell.TitleLabel.text = nasaimagesinfo[indexPath.row].title
            cell.DateLabel.text = nasaimagesinfo[indexPath.row].dateCreated
            
        default:
            break
        }
        return cell
    }
    
    func PresentMarsPhotos(images: [Photo]) {
        self.marsimages = images
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func PresentNASAImages(images: [ImageData]) {
        self.nasaimagesinfo = images
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func PresentNASAImagesInfo(info: [Link]) {
        self.nasaimages = info
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
