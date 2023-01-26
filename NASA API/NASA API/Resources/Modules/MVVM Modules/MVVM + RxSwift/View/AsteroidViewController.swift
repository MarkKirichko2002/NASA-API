//
//  AsteroidViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

class AsteroidViewController: UIViewController {

    var viewModel = NasaViewModel()
    var bag = DisposeBag()
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Asteroids"
        self.view.addSubview(tableView)
        viewModel.GetAsteroids()
        bindTableView()
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel.asteroids.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row,item,cell) in
            cell.textLabel?.text = "name: \(item.name)"
        }.disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}

extension AsteroidViewController: UITableViewDelegate {
    
}
