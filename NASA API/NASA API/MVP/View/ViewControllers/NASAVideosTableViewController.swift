//
//  NASAVideosTableViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 05.09.2022.
//

import UIKit
import SDWebImage

class NASAVideosTableViewController: UITableViewController, VideoPresentDelegate {
    
    var presenter = NASAPresenter()
    var nasavideos = [Link]()
    var nasavideosinfo = [LibraryData]()
    var nasavideosjsons = [String]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter.SetVideosViewDelegate(videodelegate: self)
        presenter.GetNASAVideos()
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if let vc = storyboard?.instantiateViewController(withIdentifier: "NASAVideoPlayerViewController") as? NASAVideoPlayerViewController {
            vc.json = nasavideosjsons[indexPath.row]
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return nasavideosinfo.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: NasaImagesTableViewCell.identifier, for: indexPath) as! NasaImagesTableViewCell
        
        cell.NASAImage.sd_setImage(with: URL(string: nasavideos[indexPath.row].href))
        cell.NASAImage.layer.cornerRadius = cell.NASAImage.frame.width / 2
        cell.NASAImage.layer.borderWidth = 5
        cell.TitleLabel.text = nasavideosinfo[indexPath.row].title
        cell.DateLabel.text = nasavideosinfo[indexPath.row].dateCreated
        
        return cell
    }
    
    
    func PresentNASAVideos(videos: [LibraryData]) {
        self.nasavideosinfo = videos
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func PresentNASAVideosInfo(info: [Link]) {
        self.nasavideos = info
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    func GetNASAVideosJSONS(jsons: [String]) {
        self.nasavideosjsons = jsons
        
        DispatchQueue.main.async {
            self.tableView.reloadData()
        }
    }
    
    
}
