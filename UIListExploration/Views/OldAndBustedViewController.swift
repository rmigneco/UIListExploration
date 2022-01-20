//
//  ViewController.swift
//  UIListExploration
//
//  Created by Ray Migneco on 1/11/22.
//

import UIKit

final class OldAndBustedViewController: UIViewController {
    
    private let tableView = UITableView()
    private let data = TransportationItem.all
    
    required init() {
        super.init(nibName: nil, bundle: nil)
        
        self.tabBarItem = UITabBarItem(title: "Old & Busted", image: UIImage(systemName: "hand.thumbsdown"), tag: 0)
        
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
        
        tableView.register(SelectableCell.self, forCellReuseIdentifier: "transportationCell")
    }
}

extension OldAndBustedViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return data.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "transportationCell", for: indexPath) as? SelectableCell
        else {
            return UITableViewCell()
        }
        
        let item = data[indexPath.row]
        
        cell.mainImageView.image = UIImage(systemName: item.imageName)
        cell.label.text = item.name
        
        return cell
    }
}


fileprivate class SelectableCell: UITableViewCell {
    
    let selectedTransform: CGAffineTransform = CGAffineTransform(scaleX: 1.3, y: 1.3)
    
    let mainImageView = UIImageView()
    let label = UILabel()
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        let stackView = UIStackView(arrangedSubviews: [mainImageView, UIView(), label, UIView()])
        stackView.axis = .horizontal
        stackView.spacing = 10
        
        let padding = 8.0
        
        stackView.translatesAutoresizingMaskIntoConstraints = false
        contentView.addSubview(stackView)
        stackView.leadingAnchor.constraint(equalTo: contentView.leadingAnchor, constant: 24).isActive = true
        stackView.trailingAnchor.constraint(equalTo: contentView.trailingAnchor, constant: -padding).isActive = true
        stackView.topAnchor.constraint(equalTo: contentView.topAnchor, constant: padding).isActive = true
        stackView.bottomAnchor.constraint(equalTo: contentView.bottomAnchor, constant: -padding).isActive = true
        
        mainImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 30).isActive = true
        mainImageView.contentMode = .scaleAspectFill
        label.setContentHuggingPriority(.required, for: .horizontal)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: true)
        
        let transform: CGAffineTransform = selected ? selectedTransform : .identity
        UIView.animate(withDuration: 0.25) {
            self.mainImageView.transform = transform
        }
    }
    
}
