//
//  DataSource.swift
//  UIListExploration
//
//  Created by Ray Migneco on 1/11/22.
//

import Foundation
import UIKit


struct TransportationItem {
    
    let name: String
    let imageName: String
    let speed: String
}

extension TransportationItem {
    
    static let all = [TransportationItem(name: "Plane", imageName: "airplane", speed: "fast"),
                      TransportationItem(name: "Car", imageName: "car", speed: "average"),
                      TransportationItem(name: "Bus", imageName: "bus", speed: "slow"),
                      TransportationItem(name: "Cable car", imageName: "cablecar", speed: "slow"),
                      TransportationItem(name: "Ferry", imageName: "ferry", speed: "slow"),
                      TransportationItem(name: "Train", imageName: "train.side.front.car", speed: "fast"),
                      TransportationItem(name: "Bicycle", imageName: "bicycle", speed: "slow"),
                      TransportationItem(name: "Scooter", imageName: "scooter", speed: "average")]
    
    static let sectioned = [Self.all, Self.all, Self.all]
}
