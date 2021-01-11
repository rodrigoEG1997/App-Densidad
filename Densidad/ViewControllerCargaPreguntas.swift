//
//  ViewControllerCargaPreguntas.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/6/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class ViewControllerCargaPreguntas: UIViewController {
    @IBOutlet weak var botonBye: UIButton!
    
    @IBOutlet weak var lbFunFact: UILabel!
    let shapeLayer = CAShapeLayer()
    
    var arr : NSArray!
    @IBOutlet weak var lbSegundos: UILabel!
    
    var arregloFunFact = [String]()
    
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationItem.hidesBackButton = true
        
        view.backgroundColor = bgColor
        
        // let's start by drawing a circle somehow
        
        botonBye.isHidden = true
        
        let center = view.center
        
        // create my track layer
        let trackLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        trackLayer.path = circularPath.cgPath
        
        trackLayer.strokeColor = UIColor.lightGray.cgColor
        trackLayer.lineWidth = 20
        trackLayer.fillColor = UIColor.clear.cgColor
        trackLayer.lineCap = CAShapeLayerLineCap.round
        view.layer.addSublayer(trackLayer)
        
        //        let circularPath = UIBezierPath(arcCenter: center, radius: 100, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        
        shapeLayer.strokeColor = UIColor.blue.cgColor
        shapeLayer.lineWidth = 20
        shapeLayer.fillColor = UIColor.clear.cgColor
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        view.layer.addSublayer(shapeLayer)
        
        // Do any additional setup after loading the view.
        
        carga()
        
        arregloFunFact.append("Sabias que 1")
        arregloFunFact.append("Sabias que 2")
        arregloFunFact.append("Sabias que 3")
        arregloFunFact.append("Sabias que 4")
        
        funFact()
        
    }
    
    func funFact(){
        var ran: Int = 0
        let ranMax: Int = arregloFunFact.count
        
            ran = Int.random(in: 0...ranMax - 1)
            
            print(ran)
        
        lbFunFact.text = arregloFunFact[ran]
    }

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vista = segue.destination as! ViewControllerCuestionate
        
        vista.bgColor = self.bgColor
        
        vista.arrPreguntas = arr
    }
    
    
    func carga(){
        
        despliegaSegundos()
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        
        basicAnimation.toValue = 1
        
        basicAnimation.duration = 6
        
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.performSegue(withIdentifier: "preguntas", sender: self)
        })
    }
    
    func despliegaSegundos(){
        lbSegundos.text = "5"
        DispatchQueue.main.asyncAfter(deadline: .now() + 1.0, execute: {
            self.lbSegundos.text = "4"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 2.0, execute: {
            self.lbSegundos.text = "3"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 3.0, execute: {
            self.lbSegundos.text = "2"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 4.0, execute: {
            self.lbSegundos.text = "1"
        })
        DispatchQueue.main.asyncAfter(deadline: .now() + 5.0, execute: {
            self.lbSegundos.text = "0"
        })
    }

}
