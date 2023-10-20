//
//  SkeletonViewController.swift
//  Test
//
//  Created by Thanh Duy on 15/08/2023.
//

import UIKit
import SwiftUI

struct Game {
    let title: String
    let year: String
    init(_ name: String, _ year: String) {
        self.title = name
        self.year = year
    }
}

class SkeletonViewController: UIViewController {
    let games = [
                Game("Pacman", "1980"),
                Game("Space Invaders", "1978"),
                Game("Frogger", "1981")
    ]
    
    let cellId = "cellId"
    let skeletonCellId = "skeletonCellId"
    var tableView = UITableView()

    var loaded = false

    lazy var loadButtonItem: UIBarButtonItem = {
        let barButtonItem = UIBarButtonItem(title: "Load", style: .done, target: self, action: #selector(loadTapped))
            return barButtonItem
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
//        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(3), execute: { [weak self] in
//            self?.loaded = true
//            self?.tableView.reloadData()
//        })
    }
    
    func setup() {
        title = "Skeleton Demo"
        navigationItem.rightBarButtonItem = loadButtonItem
        
        tableView.dataSource = self
        tableView.register(CustomCell.self, forCellReuseIdentifier: cellId)
        tableView.register(SkeletonCell.self, forCellReuseIdentifier: skeletonCellId)
        tableView.register(of: ProductCardLoadingCollectionViewCell.self)
        tableView.tableFooterView = UIView()
        tableView.rowHeight = 400
        view = tableView
    }
    
    @objc func loadTapped() {
        loaded = !loaded
        tableView.reloadData()
    }
}

extension SkeletonViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        if loaded {
            let cell = tableView.dequeueReusableCell(withIdentifier: cellId, for: indexPath) as! CustomCell
//            cell.game = games[indexPath.row]
            cell.accessoryType = .disclosureIndicator
            return cell
        } else {
//            let cell = tableView.dequeueReusableCell(withIdentifier: skeletonCellId, for: indexPath) as! SkeletonCell
//            cell.game = games[indexPath.row]
            let cell = tableView.dequeueReusableCell(of: ProductCardLoadingCollectionViewCell.self, indexPath: indexPath)!
            return cell
        }
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return games.count
    }
}

func makeButton(withText text: String) -> UIButton {
    let button = UIButton()
    button.translatesAutoresizingMaskIntoConstraints = false
    button.setTitle(text, for: .normal)
    button.titleLabel?.adjustsFontSizeToFitWidth = true
    button.contentEdgeInsets = UIEdgeInsets(top: 8, left: 16, bottom: 8, right: 16)
    button.backgroundColor = .systemBlue
    button.layer.cornerRadius = 8
    return button
}

struct SkeletonViewController_Previews: PreviewProvider {
    static var previews: some View {
        ViewControllerPreview {
            SkeletonViewController()
        }
    }
}
