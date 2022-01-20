//
//  NewHotnessViewController.swift
//  UIListExploration
//
//  Created by Ray Migneco on 1/11/22.
//

import Foundation
import UIKit


final class NewHotnessViewController: UIViewController {
    
    let data = TransportationItem.all
    
    let tableView = UITableView()
        
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.tabBarItem = UITabBarItem(title: "New Hotness", image: UIImage(systemName: "hand.thumbsup"), tag: 1)
        
        setupTableView()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.reloadData()
    }
    
    func setupTableView() {
        tableView.dataSource = self
        
        tableView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(tableView)
        tableView.widthAnchor.constraint(equalTo: view.widthAnchor).isActive = true
        tableView.heightAnchor.constraint(equalTo: view.heightAnchor).isActive = true
        tableView.centerXAnchor.constraint(equalTo: view.centerXAnchor).isActive = true
        tableView.centerYAnchor.constraint(equalTo: view.centerYAnchor).isActive = true
        
        tableView.register(UITableViewCell.self, forCellReuseIdentifier: "transportationCell")
    }
}

extension NewHotnessViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "transportationCell", for: indexPath)
        
        let contentConfig = TestContentConfiguration(item: data[indexPath.row])
        cell.contentConfiguration = contentConfig
        
        return cell
    }
}



















fileprivate struct TestContentConfiguration: UIContentConfiguration {
    
    let item: TransportationItem
    var transform: CGAffineTransform = .identity
    
    init(item: TransportationItem) {
        self.item = item
    }
    
    func makeContentView() -> UIView & UIContentView {
        let contentView = TestContentView(configuration: self)
        
        return contentView
    }
    
    func updated(for state: UIConfigurationState) -> Self {
        guard let cellState = state as? UICellConfigurationState else { return self }
        
        var config = Self.init(item: item)
        
        let transform: CGAffineTransform = cellState.isSelected ? CGAffineTransform(scaleX: 1.3, y: 1.3) : .identity
        config.transform = transform
        
        return config
    }
}

final class TestContentView: UIView, UIContentView {

    var configuration: UIContentConfiguration {
        didSet {
            configure(with: configuration)
        }
    }

    let imageView = UIImageView()
    let label = UILabel()

    required init(configuration: UIContentConfiguration) {
        self.configuration = configuration
        
        super.init(frame: .zero)
        
        imageView.contentMode = .scaleAspectFill
        
        imageView.translatesAutoresizingMaskIntoConstraints = false
        label.translatesAutoresizingMaskIntoConstraints = false
        
        addSubview(imageView)
        addSubview(label)
        
        let padding = 8.0
        
        directionalLayoutMargins = NSDirectionalEdgeInsets(top: padding, leading: padding, bottom: padding, trailing: padding)
        
        let imageViewGuide = UILayoutGuide()
        addLayoutGuide(imageViewGuide)
        imageViewGuide.widthAnchor.constraint(equalToConstant: 70).isActive = true
        imageViewGuide.leadingAnchor.constraint(equalTo: layoutMarginsGuide.leadingAnchor).isActive = true
        imageViewGuide.centerYAnchor.constraint(equalTo: layoutMarginsGuide.centerYAnchor).isActive = true
        
        imageView.centerXAnchor.constraint(equalTo: imageViewGuide.centerXAnchor).isActive = true
        imageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        imageView.topAnchor.constraint(equalTo: layoutMarginsGuide.topAnchor).isActive = true
        imageView.bottomAnchor.constraint(equalTo: layoutMarginsGuide.bottomAnchor).isActive = true
        
        label.leadingAnchor.constraint(equalTo: imageViewGuide.trailingAnchor, constant: 10).isActive = true
        label.trailingAnchor.constraint(equalTo: layoutMarginsGuide.trailingAnchor).isActive = true
        label.centerYAnchor.constraint(equalTo: imageView.centerYAnchor).isActive = true

        configure(with: configuration)
    }
    
    private func configure(with configuration: UIContentConfiguration) {
        guard let config = configuration as? TestContentConfiguration else { return }
        
        label.text = config.item.name
        imageView.image = UIImage(systemName: config.item.imageName)
        
        UIView.animate(withDuration: 0.25) {
            self.imageView.transform = config.transform
        }
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

