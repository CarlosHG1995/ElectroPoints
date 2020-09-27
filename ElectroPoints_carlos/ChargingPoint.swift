//
//  ChargingPoint.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import Foundation
import MapKit

class ChargingPoint: NSObject, MKAnnotation, Codable  {
    var name: String
    var street: String
    var power: Double
    var price: Double
    var type: ConnectorType//? = ConnectorType.chademo
    var coordinates: Coordinate
    
    var coordinate: CLLocationCoordinate2D
    /**/
    {
        return CLLocationCoordinate2D(latitude: coordinates.latitud, longitude: coordinates.longitud)
    }

    var title: String? {
    return name}

    var subtitle: String? {
    return street}
    
    init(name: String, street: String, power: Double, price: Double, type: ConnectorType,
         coordinates: Coordinate ) {
        //coordinate: CLLocationCoordinate2D ,
        self.name = name //"Bga"
        self.street = street //"Carrera 24#16-18"
        self.power = power // 1.0
        self.price = price //1.1
        self.type = type
        //self.coordinate = coordinate
        self.coordinates = coordinates
    
     super.init()
    }
    //



    
struct Coordinate: Codable, Hashable {
    var latitud : Double //= 0.0
    var longitud : Double // = 0.0
    }
    
enum ConnectorType : Int, Codable, CaseIterable {
    case schuko = 1
    case chademo = 2
    case mennekes = 3
    var tipo: String {
        switch self {
        case .schuko:
            return "Schuko"
        case .chademo:
            return "Chademo"
        case .mennekes:
            return "Mennekes"
         
        }
    }
    static let listConnectorType = [schuko,chademo,mennekes]
    }
    // cálculo de la distancia
    func getDistance(from other: CLLocation) -> CLLocationDistance
    {
        let localizacion: CLLocation = CLLocation(latitude: coordinates.latitud, longitude: coordinates.longitud)
        return localizacion.distance(from: other)
    }
    
}
