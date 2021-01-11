//
//  ViewControllerExperimenta.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 3/23/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class ViewControllerExperimenta: UIViewController, UIPickerViewDelegate, UIPickerViewDataSource {

    //Picker View
    @IBOutlet weak var pvLiquidos: UIPickerView!
    var liquidos = ["Agua", "Agua de mar", "Aceite", "Gasolina", "Alcohol"]
    var densidadesLiquidos = ["1000", "1027", "920", "680", "720"]
    var densidadLiquido : Double!
    
    var prueba : CGFloat = 0
    
    @IBOutlet weak var vistaOpacidad: UIView!
    @IBOutlet weak var gifLiquido: UIImageView!
    @IBOutlet weak var gramos1: UITextField!
    @IBOutlet weak var gramos2: UITextField!
    @IBOutlet weak var volumen1: UITextField!
    @IBOutlet weak var volumen2: UITextField!
    @IBOutlet weak var densidad1: UITextField!
    @IBOutlet weak var densidad2: UITextField!
    @IBOutlet weak var lbDensidadLiquido: UILabel!
    
    @IBOutlet weak var objeto1: UIImageView!
    @IBOutlet weak var objeto2: UIImageView!
    
    //Vaso
    @IBOutlet weak var vaso: UIImageView!
    @IBOutlet weak var vasoDown: UIImageView!
    @IBOutlet weak var opacidadVista: UIView!
    
    @IBOutlet weak var btReinicia: UIButton!
    
    
    var bgColor: UIColor!
    
    private lazy var waveView1: LCWaveView = {
        let waveView = LCWaveView(frame: CGRect(x: 0, y: 0, width: vistaOpacidad.bounds.size.width , height: 0 ), color: UIColor.blue)
        waveView.waveRate = 2
        waveView.waveSpeed = 1
        waveView.waveHeight = 7
        return waveView
    }()
    private lazy var waveView2: LCWaveView = {
        let waveView = LCWaveView(frame: CGRect(x: 0, y: 0, width: vistaOpacidad.bounds.size.width , height: 0 ), color: UIColor.yellow)
        waveView.waveRate = 2
        waveView.waveSpeed = 1
        waveView.waveHeight = 7
        return waveView
    }()
    private lazy var waveView3: LCWaveView = {
        let waveView = LCWaveView(frame: CGRect(x: 0, y: 0, width: vistaOpacidad.bounds.size.width , height: 0 ), color: UIColor(red: 0.898, green: 0.6745, blue: 0, alpha: 0.5) )
        waveView.waveRate = 2
        waveView.waveSpeed = 1
        waveView.waveHeight = 7
        return waveView
    }()
    private lazy var waveView4: LCWaveView = {
        let waveView = LCWaveView(frame: CGRect(x: 0, y: 0, width: vistaOpacidad.bounds.size.width , height: 0 ), color: UIColor(red: 0.9882, green: 0.9686, blue: 0.8784, alpha: 0.5) )
        waveView.waveRate = 2
        waveView.waveSpeed = 1
        waveView.waveHeight = 7
        return waveView
    }()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.objeto1.frame.origin.y = self.vistaOpacidad.frame.origin.y
        self.objeto1.center.x = self.view.center.x
        
        
        self.objeto2.frame.origin.y = self.vaso.frame.origin.y //- (self.objeto2.frame.height / 2)
        
        self.objeto2.frame.origin.x = self.opacidadVista.frame.origin.x * 1.75
        densidadLiquido = 1000
        lbDensidadLiquido.text = String(describing: (densidadLiquido!/1000)) + " g/cm3"

        
        view.backgroundColor = bgColor
        
        gramos1.text = "0"
        gramos2.text = "0"
        volumen1.text = "0"
        volumen2.text = "0"
        densidad1.text = "0"
        densidad2.text = "0"
        densidadLiquido = 1000
        
        
        
        //Waves
        gifLiquido.loadGif(name: "agua fondo")
        waveView1.startWave()
        vistaOpacidad.addSubview(waveView1)
        vistaOpacidad.addSubview(waveView2)
        vistaOpacidad.addSubview(waveView3)
        vistaOpacidad.addSubview(waveView4)

        vistaOpacidad.backgroundColor = UIColor.blue.withAlphaComponent(0.5)

        
        // Listen for keyboardevents
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.addObserver(self, selector: #selector(keyboardWillChange(notification:)), name: UIResponder.keyboardWillChangeFrameNotification, object: nil)
        
        
        //Tap Gesture Recognizer
        let tap = UITapGestureRecognizer(target: self, action: #selector(calculaDensidad))
        view.addGestureRecognizer(tap)
        

    }
    
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // et the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

    @IBAction func reiniciaExperimenta(_ sender: UIButton) {
        btReinicia.isHidden = true
        btReinicia.isEnabled = false
        
        self.objeto1.frame.origin.y = self.vaso.frame.origin.y
        gramos1.text = "0"
        volumen1.text = "0"
        densidad1.text = "0"
        
    }
    
    
    
    //Función que calcula la densidad
    @IBAction func calculaDensidad() {
        
        
        view.endEditing(true)
        
        //Objeto 1
        if ( gramos1.text != "0" && volumen1.text != "0" && gramos1.text != "" && volumen1.text != ""){
            btReinicia.isEnabled = true
            btReinicia.isHidden = false
            let peso = Double(gramos1.text!)
            let volumen = Double(volumen1.text!)
            
            let densidad :Double = peso! / volumen!
            
            densidad1.text = String(densidad)
            
           
            if ( densidad > (densidadLiquido/1000)  ){
                
                if(densidad <= 100){
                    UIView.animate(withDuration: 6){
                        self.objeto1.frame.origin.y = self.vasoDown.frame.origin.y - (self.objeto1.frame.height * 0.5)
                    }
                } else if (densidad <= 500){
                    UIView.animate(withDuration: 4){
                        self.objeto1.frame.origin.y = self.vasoDown.frame.origin.y - (self.objeto1.frame.height * 0.5)
                    }
                    
                } else if (densidad > 500){
                    UIView.animate(withDuration: 2){
                        self.objeto1.frame.origin.y = self.vasoDown.frame.origin.y - (self.objeto1.frame.height * 0.5)
                    }
                    
                }
                
            }
            
            
            
            
            if ( densidad < (densidadLiquido/1000)  ){
                
                UIView.animate(withDuration: 5){
                    self.objeto1.frame.origin.y = self.opacidadVista.frame.origin.y - self.objeto1.frame.height * 0.5
                }
                
            }
            
            if ( densidad == (densidadLiquido/1000)  ){
                UIView.animate(withDuration: 5){
                    self.objeto1.frame.origin.y = self.opacidadVista.frame.origin.y + self.opacidadVista.frame.height*0.5 - self.objeto1.frame.height*0.5
                }
                
                
            }
            
           
            
        }
        /*
        //Objeto 2
        if ( gramos2.text != "0" && volumen2.text != "0" && gramos2.text != "" && volumen2.text != ""){
            let peso = Double(gramos2.text!)
            let volumen = Double(volumen2.text!)
            
            let densidad :Double = peso! / volumen!
            
            densidad2.text = String(densidad)
            
            
            if ( densidad > (densidadLiquido/1000)  ){
                UIView.animate(withDuration: 5){
                    self.objeto2.frame.origin.y = self.opacidadVista.frame.origin.y + self.opacidadVista.frame.height - self.objeto2.frame.height*1.5
                }
            }
            
            if ( densidad < (densidadLiquido/1000)  ){
                UIView.animate(withDuration: 5){
                    self.objeto2.frame.origin.y = self.opacidadVista.frame.origin.y - self.objeto2.frame.height * 0.5
                }
            }
            if ( densidad == (densidadLiquido/1000)  ){
                UIView.animate(withDuration: 5){
                    self.objeto2.frame.origin.y = self.opacidadVista.frame.origin.y + self.opacidadVista.frame.height*0.5 - self.objeto2.frame.height*0.5
                }
            }
        }*/
        
        
    }
    

    // MARK: - Picker View
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
            return liquidos.count
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String?{
            return liquidos[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        densidadLiquido = Double(densidadesLiquidos[row])
        lbDensidadLiquido.text = String(describing: (densidadLiquido!/1000)) + " g/cm3"
        //Agua
        if(row == 0){
            
            waveView2.stopWave()
            waveView3.stopWave()
            waveView4.stopWave()
            waveView1.startWave()
            
            
            vistaOpacidad.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            densidadLiquido = Double(densidadesLiquidos[row])
            calculaDensidad()
        }
        
        //Agua de mar
        if(row == 1){
            waveView2.stopWave()
            waveView3.stopWave()
            waveView4.stopWave()
            waveView1.startWave()
            vistaOpacidad.backgroundColor = UIColor.blue.withAlphaComponent(0.5)
            densidadLiquido = Double(densidadesLiquidos[row])
            calculaDensidad()
        }
        
        //Aceite
        if(row == 2){
            waveView1.stopWave()
            waveView3.stopWave()
            waveView4.stopWave()
           waveView2.startWave()
            vistaOpacidad.backgroundColor = UIColor.yellow.withAlphaComponent(0.5)
            densidadLiquido = Double(densidadesLiquidos[row])
            calculaDensidad()
        }
        
        //Gasolina
        if(row == 3){
           
            waveView1.stopWave()
            waveView2.stopWave()
            waveView4.stopWave()
            waveView3.startWave()
            vistaOpacidad.backgroundColor = UIColor(red: 0.898, green: 0.6745, blue: 0, alpha: 0.5) /* #e5ac00 */
            densidadLiquido = Double(densidadesLiquidos[row])
            calculaDensidad()
        }
        
        //Alcohol
        if(row == 4){
           
            waveView1.stopWave()
            waveView3.stopWave()
            waveView2.stopWave()
            waveView4.startWave()
            vistaOpacidad.backgroundColor = UIColor(red: 0.9882, green: 0.9686, blue: 0.8784, alpha: 0.5) /* #fcf7e0 */
            densidadLiquido = Double(densidadesLiquidos[row])
            calculaDensidad()
        }
        
    }
    
    
    // MARK: Manage Keyboard
    deinit{
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillShowNotification, object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillHideNotification, object: nil)
        NotificationCenter.default.removeObserver(self,name: UIResponder.keyboardWillChangeFrameNotification, object: nil)

        
    }
    @IBAction func hideKeyboard(_ sender: Any) {
        view.endEditing(true)
    }
    
    
    @objc func keyboardWillChange(notification: Notification){
        print("keyboard will show: \(notification.name.rawValue)")
        
        guard let keyboardRect = (notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue)?.cgRectValue else {
            return
        }
        
        if notification.name == UIResponder.keyboardWillShowNotification || notification.name == UIResponder.keyboardWillChangeFrameNotification{
            view.frame.origin.y = -keyboardRect.height
        }
        else{
            view.frame.origin.y = 0
        }
    
    }
    
    @IBAction func regresar(_ sender: Any) {
        
    }
    
}
