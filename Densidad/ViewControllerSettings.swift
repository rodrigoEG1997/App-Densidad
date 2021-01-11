//
//  ViewControllerSettings.swift
//  Densidad
//
//  Created by José Arturo Villalobos Castro on 4/6/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit
import AVFoundation

class ViewControllerSettings: UIViewController {

    var player: AVAudioPlayer = AVAudioPlayer()
    var bgColorSetting : UIColor!
    var boolSonido : Bool = true
    
    @IBOutlet weak var swSonido: UISwitch!
    @IBOutlet weak var btListo: UIButton!
    
    //Colores
    @IBOutlet weak var azul: UIButton!
    @IBOutlet weak var amarillo: UIButton!
    @IBOutlet weak var morado: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        swSonido.isOn = boolSonido
        preferredContentSize = CGSize(width: 300, height: 270)
    }
    
    @IBAction func playSound(_ sender: UISwitch) {
        
        if sender.isOn == true {
            boolSonido = true
        } else {
            boolSonido = false
        }
    }
    
    @IBAction func btAzul(_ sender: Any) {
        bgColorSetting = azul.backgroundColor
    }
    
    @IBAction func btAmarillo(_ sender: Any) {
        bgColorSetting = amarillo.backgroundColor
    }
    
    @IBAction func btMorado(_ sender: Any) {
        bgColorSetting = morado.backgroundColor
    }
    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if (sender as! UIButton) == btListo{
            let vistaInic = segue.destination as! ViewController
            
            vistaInic.bgColor = bgColorSetting
            vistaInic.boolSonido = boolSonido
            
            if swSonido.isOn == true{
                player.play()
            }
            else{
                player.stop()
            }
        }
    }
    

}
