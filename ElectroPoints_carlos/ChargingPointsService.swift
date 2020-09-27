//
//  ChargingPointsService.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import Foundation

class PointsService {
    static var shared: PointsService = PointsService()
    var allPoints : [ChargingPoint] = [] {
        didSet {
            let encoder = JSONEncoder()
            if let encoded = try? encoder.encode(PointsService.shared.allPoints) {
                let defaults = UserDefaults.standard
                defaults.set(encoded, forKey: "cpoints")
            }
        }
    }
    
    func loadPoints() {
        let defaults = UserDefaults.standard
        let decoder = JSONDecoder()
        if let CP_guardados = defaults.object(forKey: "cpoints") as? Data {
            if let CP_cargados = try? decoder.decode([ChargingPoint].self, from: CP_guardados) {
                allPoints = CP_cargados
            }
        }
    }
}
