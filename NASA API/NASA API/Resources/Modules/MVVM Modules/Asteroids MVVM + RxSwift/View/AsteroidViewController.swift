//
//  AsteroidsViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import UIKit
import RxSwift
import RxCocoa

final class AsteroidsViewController: UIViewController, UITableViewDelegate {

    private var viewModel: AsteroidsViewModel?
    private let bag = DisposeBag()
    
    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Астероиды"
        self.view.addSubview(tableView)
        viewModel?.GetAsteroids()
        bindTableView()
    }
    
    init(viewModel: AsteroidsViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    func bindTableView() {
        tableView.rx.setDelegate(self).disposed(by: bag)
        viewModel?.asteroids.bind(to: tableView.rx.items(cellIdentifier: "cell")) { (row,item,cell) in
            cell.textLabel?.text = "name: \(item.name)"
        }.disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        tableView.frame = view.bounds
    }
}
