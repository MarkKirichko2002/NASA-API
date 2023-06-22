//
//  AsteroidsViewController.swift
//  NASA API
//
//  Created by Марк Киричко on 26.08.2022.
//

import UIKit

final class AsteroidsViewController: UIViewController {

    @objc var viewModel: AsteroidsViewModel?

    lazy var tableView: UITableView = {
        let tableView = UITableView(frame: self.view.frame)
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "cell")
        return tableView
    }()
    
    // MARK: - Init
    init(viewModel: AsteroidsViewModel?) {
        self.viewModel = viewModel
        super.init(nibName: nil, bundle: nil)
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Астероиды"
        SetUpTable()
        bindTableView()
        viewModel?.GetAsteroids()
    }
    
    private func SetUpTable() {
        self.view.addSubview(tableView)
        tableView.frame = view.bounds
        tableView.dataSource = self
    }
    
    func bindTableView() {
        viewModel?.observation = observe(\.viewModel?.asteroids) { object, _ in
            self.tableView.reloadData()
        }
    }
}
