//
//  ViewController.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class MapViewController: UIViewController {

    @IBOutlet weak var mapa: MKMapView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        //Definir ubicación del mapa
               let latitud: CLLocationDegrees = 7.132367
               let longitud: CLLocationDegrees =  -73.122634
            let location: CLLocation = CLLocation.init(latitude: latitud, longitude: longitud)
               
               //Define el zoom/apertura del mapa
               let latDelta: CLLocationDegrees = 0.005
               let lonDelta: CLLocationDegrees = 0.005
        //creamos los objetos que combinan ubicación y amplitud
        let span: MKCoordinateSpan = MKCoordinateSpan(latitudeDelta: latDelta, longitudeDelta: lonDelta)
        let ubicacion: CLLocationCoordinate2D = CLLocationCoordinate2D(latitude: latitud, longitude: longitud)
        
        //Establecemos el area a mostrar sobre el mapa
        let region: MKCoordinateRegion = MKCoordinateRegion(center: ubicacion, span: span)
        mapa.setRegion(region, animated: true)
            //paso 3 pag 9
            let longpress = UILongPressGestureRecognizer(target: self, action: #selector(Longpress(press:)))
            longpress.minimumPressDuration = 2.0
            mapa.addGestureRecognizer(longpress)
        PointsService.shared.loadPoints() //datos del almacenamiento
        mapa.addAnnotations(PointsService.shared.allPoints)
    }
    typealias latupla = (ChargingPoint.Coordinate, CLPlacemark)
    
    @objc func Longpress(press: UILongPressGestureRecognizer)
       {
           if press.state == .began {
               let location: CGPoint = press.location(in: self.mapa)
               let coor: CLLocationCoordinate2D = self.mapa.convert(location, toCoordinateFrom: self.mapa)
           print("loca \(location)")//CGpoint
           print("posición \(coor)") //CLLocationCoordinate 2d
           
           //paso 4
           let ubicacionUsuario = CLLocation(latitude: coor.latitude, longitude: coor.longitude)
           print(ubicacionUsuario)
           CLGeocoder().reverseGeocodeLocation(ubicacionUsuario)
           {
               [unowned self] (placemarks, error) in
             if let err = error
                           {
                              print(err)
                          }
                        else
                          {
                              if let placemark = placemarks?[0]
                              {
                               let cor = ChargingPoint.Coordinate.init(latitud: ubicacionUsuario.coordinate.latitude, longitud: ubicacionUsuario.coordinate.longitude)
                                  print(placemark)
                                  var thoroughfare = ""
                                  if placemark.thoroughfare != nil
                                  {
                                      thoroughfare = placemark.thoroughfare! //direccion
                                  }
                                  
                                  var locality = ""
                                  if placemark.locality != nil
                                  {
                                      locality = placemark.locality! //municipio
                                  }
                                  
                                  print("-----------------------")
                                  print("Dirección: \(thoroughfare), \(locality)\n ")
                                  print("-----------------------")
                               //marcador pin la chincheta
                               //let pto_carga = ChargingPoint(name: thoroughfare, street: locality, power: 0.0, price: 0.0, type: ChargingPoint.ConnectorType.chademo, coordinates: coor)
                                // la tupla
                               let info: latupla = (cor,placemark)
                               print(info)
                               self.performSegue(withIdentifier:"addPoint",sender: info.self)
                               }
               }
           }//cierra CLGeocoder
           
           }// cierra if press
           
       }//cierra objc fun

    //private var fVC: FormViewController!
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addPoint" {
            
            if let fVC  = segue.destination as? FormViewController
            {
                if let info = sender as? latupla
                {
                fVC.coords = info.0
                fVC.pla = info.1
                fVC.chargingPointCreatedHandler = chargingPointCreatedHandler(pto_carga:)
               }
           else
        {return                   }
                        }
                        else
                        {
                            return
                        }
                    }
    }
    
    func chargingPointCreatedHandler(pto_carga: ChargingPoint?){
           print("handler del pto de carga bien \(pto_carga)")
       if(pto_carga != nil){
           mapa.addAnnotation(pto_carga!)
           //paso 8 pag 18
           PointsService.shared.allPoints.append(pto_carga!)
           print("point service \(PointsService.shared.allPoints.append(pto_carga!))")
       }
       }
       

}

