//
//  NASAImagesTableViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 11.08.2022.
//

import UIKit
import SDWebImage

class NASAImagesTableViewController: UITableViewController, PhotoPresentDelegate {
    
    var presenter = NASAPresenter()
    var marsimages = [Photo]()
    var nasaimages = [NASAImageViewModel]()
    var nasaimagesinfo = [NASAImageInfoViewModel]()
    var epicimages = [EPIC]()
    var category: NasaImageCategory?
    var earthimages = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.rowHeight = 100
        view.backgroundColor = .white
        presenter.SetViewDelegate(delegate: self)
        self.tableView.register(NasaImagesTableViewCell.self, forCellReuseIdentifier: NasaImagesTableViewCell.identifier)
        switch category?.id {
            
        case 2:
            presenter.GetMarsPhotos()
            
        case 3:
            presenter.GetNASAImages()
            
        case 4:
            presenter.GetEPICImages()
            
        default:
            break
            
        }
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        switch category?.id {
            
        case 2:
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = "Landing Date: \(marsimages[indexPath.row].rover.landingDate)"
                vc.image = marsimages[indexPath.row].imgSrc
                vc.sound = category?.sound ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        case 3:
            let vc = NASAImageDetailViewController()
            vc.info = nasaimagesinfo[indexPath.row].description
            vc.image = nasaimages[indexPath.row].image
            vc.sound = category?.sound ?? ""
            self.navigationController?.pushViewController(vc, animated: true)
            
            
        case 4:
            let id = "identifier \(epicimages[indexPath.row].identifier) \n"
            let centroidcoordinates = "\n centroid coordinates \n lat: \(epicimages[indexPath.row].centroidCoordinates.lat) \n lon: \(epicimages[indexPath.row].centroidCoordinates.lon) \n"
            let dscovrj2000position = "\n DSCOVR j2000 coordinates \n x: \(epicimages[indexPath.row].dscovrJ2000Position.x), \n y: \(epicimages[indexPath.row].dscovrJ2000Position.y), \n z: \(epicimages[indexPath.row].dscovrJ2000Position.z) \n"
            let lunarj2000position = "\n LUNAR j2000 coordinates \n x: \(epicimages[indexPath.row].lunarJ2000Position.x), \n y: \(epicimages[indexPath.row].lunarJ2000Position.y), \n z: \(epicimages[indexPath.row].lunarJ2000Position.z) \n"
            let sunJ2000Position = "\n SUN j2000 coordinates \n x: \(epicimages[indexPath.row].sunJ2000Position.x), \n y: \(epicimages[indexPath.row].sunJ2000Position.y), \n z: \(epicimages[indexPath.row].sunJ2000Position.z) \n"
            let attitudequaternions = "\n attitude quaternions \n q0: \(epicimages[indexPath.row].attitudeQuaternions.q0), \n q1: \(epicimages[indexPath.row].attitudeQuaternions.q1), \n q2: \(epicimages[indexPath.row].attitudeQuaternions.q2)"
            if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAImageDetailViewController") as? NASAImageDetailViewController {
                vc.info = "\(id) \(centroidcoordinates) \(dscovrj2000position) \(lunarj2000position) \(sunJ2000Position) \(attitudequaternions)"
                vc.image = earthimages[indexPath.row]
                vc.sound = category?.sound ?? ""
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
        default:
            break
        }
    }
    
    // MARK: - Table view data source
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch category?.id {
            
        case 2:
            return marsimages.count
            
        case 3:
            return nasaimagesinfo.count
            
        case 4:
            return epicimages.count
            
        default:
            break
            
        }
        return 10
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: NasaImagesTableViewCell.identifier, for: indexPath) as? NasaImagesTableViewCell else {return UITableViewCell()}
        
        switch category?.id {
            
        case 2:
            cell.NASAImage.sd_setImage(with: URL(string: marsimages[indexPath.row].imgSrc))
            cell.NASAImage.sound = category?.sound ?? ""
            cell.TitleLabel.text = marsimages[indexPath.row].camera.fullName
            cell.DateLabel.text = marsimages[indexPath.row].earthDate
            
        case 3:
            cell.NASAImage.sd_setImage(with: URL(string: nasaimages[indexPath.row].image))
            cell.NASAImage.sound = category?.sound ?? ""
            cell.TitleLabel.text = nasaimagesinfo[indexPath.row].title
            cell.DateLabel.text = nasaimagesinfo[indexPath.row].date
            
        case 4:
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
            cell.NASAImage.sd_setImage(with: URL(string: "https://epic.gsfc.nasa.gov/archive/natural/\(totaldate)/png/\(image)"))
            cell.NASAImage.sound = category?.sound ?? ""
            self.earthimages.append("https://epic.gsfc.nasa.gov/archive/natural/\(totaldate)/png/\(image)")
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
    
    func PresentNASAImages(images: [NASAImageViewModel]) {
        self.nasaimages = images
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func PresentNASAImagesInfo(info: [NASAImageInfoViewModel]) {
        self.nasaimagesinfo = info
        
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