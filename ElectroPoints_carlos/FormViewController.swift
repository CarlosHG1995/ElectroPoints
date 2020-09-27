//
//  FormViewController.swift
//  ElectroPoints_carlos
//
//  Created by cmu on 03/04/2020.
//  Copyright © 2020 UPV. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation

class FormViewController: UIViewController, UIPickerViewDelegate,
UIPickerViewDataSource {
    
     
    var coor: CLLocationCoordinate2D?
    var pla : CLPlacemark?
    var coords: ChargingPoint.Coordinate?
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return ChargingPoint.ConnectorType.allCases.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return ChargingPoint.ConnectorType.allCases[row].tipo
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        tipo_carga = ChargingPoint.ConnectorType.allCases[row]
    }
    var tipo_carga = ChargingPoint.ConnectorType.chademo // ConnectorType.chademo
 
    override func viewDidLoad() {
        super.viewDidLoad()
        direccion.text = pla?.thoroughfare //via publica
        localidad.text = pla?.locality // ciudad
        coordenadas.text = String(format: "Latitud: %.4f -- Longitud: %.4f", coords!.latitud, coords!.longitud)
        //"Lat: \(String(describing: coords!.latitud)) - Long: \(String(describing: coords!.longitud))" //pos
//String (format: "La conversión de \(gE1) °C fue: %.4f", ans)
        // Do any additional setup after loading the view.
    }
    
    @IBOutlet weak var direccion: UILabel!
    
    @IBOutlet weak var localidad: UILabel!
    
    @IBOutlet weak var coordenadas: UILabel!
    @IBOutlet weak var potencia: UITextField!
    @IBOutlet weak var precio: UITextField!
    
    @IBOutlet weak var tipo: UIPickerView!{
        didSet { tipo.delegate = self
            tipo.dataSource = self
         }
    }
    var chargingPointCreatedHandler: ((ChargingPoint) -> Void)?
    
    @IBAction func guarda(_ sender: UIButton) {
        let el_precio = precio.text ?? "0.0"
        var dprecio = 0.0
        let pot = potencia.text ?? "0.0"
        var dpower = 0.0
        let el_tipo = ChargingPoint.ConnectorType.allCases[tipo.selectedRow(inComponent: 0)]
        if let price: Double = Double(el_precio) {
            dprecio = price
        }else {
            dprecio = 0.0
        }
        if let power: Double = Double(pot){
            dpower = power
        } else {
            dpower = 0.0
        }
        
        
        let punto_de_carga = ChargingPoint.init(name: pla?.thoroughfare ?? "", street: pla?.locality ?? "", power: dpower, price: dprecio, type: el_tipo, coordinates: coords!)
            
        chargingPointCreatedHandler?(punto_de_carga)
        print("chincheta: \(el_tipo),\(punto_de_carga)")
        navigationController?.popViewController(animated: true)
        
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
