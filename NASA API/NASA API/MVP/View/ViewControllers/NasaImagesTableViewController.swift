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
    var epicimages = [EPIC]()
    var category: NasaImageCategory?
    var earthimages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.SetViewDelegate(delegate: self)
        switch category?.id {
            
        case 1:
            presenter.GetMarsPhotos()
            
        case 2:
            presenter.GetNASAImages()
            
        case 3:
            presenter.GetEPICImages()
           
        default:
            break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch category?.id {
           
        case 1:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = "Landing Date: \(marsimages[indexPath.row].rover.landingDate)"
                vc.image = marsimages[indexPath.row].imgSrc
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = nasaimagesinfo[indexPath.row].dataDescription
                vc.image = nasaimages[indexPath.row].href
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 3:
            let id = "identifier \(epicimages[indexPath.row].identifier) \n"
            let centroidcoordinates = "\n centroid coordinates \n lat: \(epicimages[indexPath.row].centroidCoordinates.lat) \n lon: \(epicimages[indexPath.row].centroidCoordinates.lon) \n"
            let dscovrj2000position = "\n DSCOVR j2000 coordinates \n x: \(epicimages[indexPath.row].dscovrJ2000Position.x), \n y: \(epicimages[indexPath.row].dscovrJ2000Position.y), \n z: \(epicimages[indexPath.row].dscovrJ2000Position.z) \n"
            let lunarj2000position = "\n LUNAR j2000 coordinates \n x: \(epicimages[indexPath.row].lunarJ2000Position.x), \n y: \(epicimages[indexPath.row].lunarJ2000Position.y), \n z: \(epicimages[indexPath.row].lunarJ2000Position.z) \n"
            let sunJ2000Position = "\n SUN j2000 coordinates \n x: \(epicimages[indexPath.row].sunJ2000Position.x), \n y: \(epicimages[indexPath.row].sunJ2000Position.y), \n z: \(epicimages[indexPath.row].sunJ2000Position.z) \n"
            let attitudequaternions = "\n attitude quaternions \n q0: \(epicimages[indexPath.row].attitudeQuaternions.q0), \n q1: \(epicimages[indexPath.row].attitudeQuaternions.q1), \n q2: \(epicimages[indexPath.row].attitudeQuaternions.q2)"
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = "\(id) \(centroidcoordinates) \(dscovrj2000position) \(lunarj2000position) \(sunJ2000Position) \(attitudequaternions)"
                vc.image = earthimages[indexPath.row]
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
            
        case 3:
            return epicimages.count
            
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
            
        case 3:
            var image = epicimages[indexPath.row].image
            image += ".png"
            let dateString = epicimages[indexPath.row].date
            let formatter = DateFormatter()
            formatter.dateFormat = "yyyy-MM-dd HH:mm:ss 'UTC'"
            let date = formatter.date(from: dateString)
            formatter.dateFormat = "yyyy"
            let year = formatter.string(from: date!)
            formatter.dateFormat = "MM"
            let month = formatter.string(from: date!)
            formatter.dateFormat = "dd"
            let day = formatter.string(from: date!)
            let totaldate = year + "/" + month + "/" + day
            cell.NASAImage.sd_setImage(with: URL(string: "https://epic.gsfc.nasa.gov/archive/enhanced/\(totaldate)/png/\(image)"))
            self.earthimages.append("https://epic.gsfc.nasa.gov/archive/enhanced/\(totaldate)/png/\(image)")
            cell.NASAImage.layer.cornerRadius = cell.NASAImage.frame.width / 2
            cell.NASAImage.layer.borderWidth = 5
            cell.TitleLabel.text = epicimages[indexPath.row].caption
            cell.DateLabel.text = epicimages[indexPath.row].date
           
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
    
    func PresentEPICNASAImages(images: [EPIC]) {
        self.epicimages = images
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
}
