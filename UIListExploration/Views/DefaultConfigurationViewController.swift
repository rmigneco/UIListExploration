//
//  DefaultConfigurationViewController.swift
//  UIListExploration
//
//  Created by Ray Migneco on 1/17/22.
//

import Foundation
import UIKit


final class CellStyleSectionedViewController: UIViewController {
    
    private let tableView = UITableView()
    private let data = TransportationItem.sectioned
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.tabBarItem = UITabBarItem(title: "defaults", image: UIImage(systemName: "list.dash"), tag: 0)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
        view.backgroundColor = .white
    }
    
    func setupTableView() {
        tableView.dataSource = self
        tableView.delegate = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        
        let guide = view.safeAreaLayoutGuide
        tableView.widthAnchor.constraint(equalTo: guide.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: guide.heightAnchor).isActive = true
        tableView.topAnchor.constraint(equalTo: guide.topAnchor).isActive = true
        tableView.bottomAnchor.constraint(equalTo: guide.bottomAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "transportationCell")
        tableView.register(UITableViewHeaderFooterView.self, forHeaderFooterViewReuseIdentifier: "headerView")
    }
}

extension CellStyleSectionedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data[section].count
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transportationCell", for: indexPath)
        
        var config: UIListContentConfiguration
        switch indexPath.section {
        case 0:
            config = UIListContentConfiguration.cell()
        case 1:
            config = UIListContentConfiguration.valueCell()
        case 2:
            config = UIListContentConfiguration.sidebarCell()
        default:
            config = UIListContentConfiguration.cell()
        }
        
        let item = data[indexPath.section][indexPath.row]
        
        config.text = item.name
        config.image = UIImage(systemName: item.imageName)
        config.secondaryText = "Speed: " + item.speed
        
        cell.contentConfiguration = config
        
        return cell
    }
}

extension CellStyleSectionedViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        guard let header = tableView.dequeueReusableHeaderFooterView(withIdentifier: "headerView") else {
            return nil
        }
        
        var config = header.defaultContentConfiguration()
        
        switch section {
        case 0:
            config.text = "Default"
        case 1:
            config.text = "Value Cell"
        case 2:
            config.text = "Sidebar Cell"
        default:
            config.text = "Default"
        }
        
        header.contentConfiguration = config
        
        return header
    }
}
