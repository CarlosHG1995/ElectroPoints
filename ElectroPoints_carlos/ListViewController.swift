//
//  ListViewController.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import UIKit
import Foundation
import CoreLocation

class ListViewController: UIViewController, CLLocationManagerDelegate,
UITableViewDataSource, UITableViewDelegate{
     
       //func numberOfSections(in tableView: UITableView) -> Int{
         //  return 1
       //}
       
       func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
           print("table view: \(PointsService.shared.allPoints.count)")
           return PointsService.shared.allPoints.count
       }
         
       
       func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell
       {
       if let cell = tableView.dequeueReusableCell(withIdentifier: "pointCell", for: indexPath)
           as? ListViewCell {
           if (userLocation != nil){
               let  dis : Double = PointsService.shared.allPoints[indexPath.row].getDistance(from: userLocation!)
               
               cell.setup(for: PointsService.shared.allPoints[indexPath.row], distance: dis)
           }
           else {
               cell.setup(for: PointsService.shared.allPoints[indexPath.row], distance: 0.0)
           }
           print("cell: \(cell)")
           return cell
       }
       else {
           let cell = UITableViewCell.init()
           return cell
           }
       }
        
       override func viewDidLoad() {
           super.viewDidLoad()
           print("lista")
           //paso 13 pag 23
           locationManager.delegate = self
           locationManager.requestWhenInUseAuthorization()
           pedirPermisoLocalizacionUsuario()
           locationManager.startUpdatingLocation()
           // Do any additional setup after loading the view.
           table.dataSource = self
       }
       override func viewDidAppear(_ animated: Bool) {
           super.viewDidAppear(animated)
           PointsService.shared.loadPoints()
       }
       
       var locationManager: CLLocationManager = CLLocationManager()
       var userLocation: CLLocation?
       @IBOutlet weak var table: UITableView!
       { didSet
       {
           table.delegate = self
           table.dataSource = self
           }
       }
       func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
           if let location: CLLocation = locations.last {
               userLocation = location
               table.reloadData()
           }
       }
       
       func locationManager(_ manager: CLLocationManager, didFailWithError error: Error)
       {
           print(error.localizedDescription)
       }
       
       func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus)
       {
           print("autorización: \(status)")//pedirPermisoLocalizacionUsuario()
            
           handleLocationAuthorizationStatus(status: status)
       }
       // Respond to the result of the location manager authorization status
       func handleLocationAuthorizationStatus(status: CLAuthorizationStatus) {
           if status == .authorizedWhenInUse {
               locationManager.desiredAccuracy = kCLLocationAccuracyBest
               locationManager.startUpdatingLocation()
           } else {
               print ("no hay permiso autorizado el estatus \(status)")
           }
            
       }
       
       func pedirPermisoLocalizacionUsuario()
          {
              let alerta = UIAlertController(title: "La App quiere acceder a tu ubicación.", message: "Necesitamos conocer tu ubicación para calcular la distancia entre ud y la estación", preferredStyle: .alert)
              
              let actionOK = UIAlertAction(title: "Permitir", style: .default)
              { (actionOK) in
               if (CLLocationManager.locationServicesEnabled())
               {
                   self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
                   self.locationManager.startUpdatingLocation()
               }
                  //self.locationManager.requestWhenInUseAuthorization()
                  //self.locationManager.startUpdatingLocation()
              }
              let actionCancel = UIAlertAction(title: "Cancelar", style: .cancel, handler: nil)
              
              alerta.addAction(actionOK)
              alerta.addAction(actionCancel)
              
              self.present(alerta, animated: true, completion: nil)
          }
       

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
