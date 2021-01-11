//
//  ViewController.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 3/23/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit
import AVFoundation

class ViewController: UIViewController, UIPopoverPresentationControllerDelegate, AVAudioPlayerDelegate {

    @IBOutlet weak var btInfo: UIButton!
    @IBOutlet weak var btSettings: UIButton!
    var player: AVAudioPlayer = AVAudioPlayer()
    
    var bgColor : UIColor!
    var boolSonido : Bool = true
    
    override func viewDidLoad() {
        super.viewDidLoad()
        bgColor = view.backgroundColor
        //Sonido
        
        do {
            let audioPlayer = Bundle.main.path(forResource: "sonido", ofType: "mp3")
            try player = AVAudioPlayer(contentsOf: NSURL(fileURLWithPath: audioPlayer!) as URL)
        } catch {
            // couldn't load file
        }
        
        player.play()
        
    }
    
    
    
    //Segue
    override func prepare(for segue: UIStoryboardSegue,
                 sender: Any?){
        if (sender as! UIButton) == btSettings{
            let vistaPopOver = segue.destination as! ViewControllerSettings
            vistaPopOver.popoverPresentationController!.delegate = self
            
            vistaPopOver.player = player
            vistaPopOver.boolSonido = boolSonido
            vistaPopOver.bgColorSetting = bgColor
        }
        else {
            if( segue.identifier == "aprende" ){
                
                let navegationController = segue.destination as! UINavigationController
                
                let viewController = navegationController.topViewController as! ViewControllerAprende
                
                viewController.bgColor = bgColor
                

            }
            else if( segue.identifier == "experimenta" ){
                
                let vista = segue.destination as! ViewControllerExperimenta
                
                vista.bgColor = bgColor
            }
            else if(sender as! UIButton) == btInfo{
                let vista = segue.destination as! ViewControllerInformacion
                vista.bgColor = bgColor
            
            } else{
                
                let vista = segue.destination as! TableViewControllerPreguntas
                
                vista.bgColor = self.bgColor
                
            }
        }
        
    }
    
    @IBAction func unwindRegresa(segue: UIStoryboardSegue){
        
    }
    
    @IBAction func unwindSettings(segue: UIStoryboardSegue){
        view.backgroundColor = bgColor
    }
    
    //Pop Over
    func adaptivePresentationStyle (for controller: UIPresentationController) -> UIModalPresentationStyle {
        return .none
    }
    
    //Sonido
    func playSound (){
        
    }
}

