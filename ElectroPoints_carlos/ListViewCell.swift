//
//  ListViewCell.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import UIKit

import Foundation
import CoreLocation

class ListViewCell: UITableViewCell {

    @IBOutlet weak var ima: UIImageView!
    @IBOutlet weak var lbl1: UILabel!
    
    @IBOutlet weak var localidad: UILabel!
    @IBOutlet weak var lblpower: UILabel!
    @IBOutlet weak var lblprecio: UILabel!
    @IBOutlet weak var lblcoordenadas: UILabel!
    @IBOutlet weak var lblconector: UILabel!
    @IBOutlet weak var lbldistancia: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    func setup(for load: ChargingPoint, distance: CLLocationDistance){
        let dis_km : CLLocationDistance = distance / 1000.0
        lbl1.text = String("Dirección: \(load.name)")
        localidad.text = String("Ciudad: \(load.street)")
        lbldistancia.text = String( format: "Distancia del Electropoint %.4f Km", dis_km)//format: "La conversión de \(gE1) °C fue: %.4f", ans
        lblpower.text = String(load.power)
        lblprecio.text = String(load.price)
        lblconector.text = load.type.tipo
        lblcoordenadas.text = String(format: "Latitud: %.4f -- Longitud: %.4f", load.coordinate.latitude, load.coordinate.longitude)
    }
    var chargingPointCreatedHandler: ((ChargingPoint) -> Void)?
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }


}
