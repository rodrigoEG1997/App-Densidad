//
//  ViewControllerResultados.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/6/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class ViewControllerResultados: UIViewController, UITableViewDelegate , UITableViewDataSource {
    
    @IBOutlet weak var lbCalif: UILabel!
    
    var resultados = [Resultado]()
    
    var arrPreguntas : NSMutableArray!
    var respuestas = [String]()
    var respuestas2 = [String]()
    var index = 0
    var calif = 100
    var califPorRespuesta = 0
    var tema = ""
    var respuestasCorrectas = [String]()
    var respuestasCorrectas2 = [String]()
    var preguntas = [String]()
    
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        for i in respuestasCorrectas{
            //print(i)
            if ( i != " "){
                respuestasCorrectas2.append(i)
            }
        }
        
        view.backgroundColor = bgColor
        
        self.navigationItem.hidesBackButton = true
        
        index = 0
        //print(arrPreguntas[0])
        tema = arrPreguntas[0] as! String
        
        self.title = tema
        
        //print(aux[1])
        //print(respuestas[0])
        //print(respuestas[1])
        //print(respuestas)
        
        for i in respuestas{
            //print(i)
            if ( i != " "){
                respuestas2.append(i)
            }
        }
        califPorRespuesta = 100 / respuestas2.count
        //print(respuestas2)
        
        obtenerResultados()

        calculaCalif()
        
        // Do any additional setup after loading the view.
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return respuestas2.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let respUsua = respuestas2[indexPath.row] as String
        //let arrBien = arrPreguntas[indexPath.row + 1]
        //let respBien = arrBien[1] as String
        
        let aux = preguntas[indexPath.row]
        
        cell.textLabel?.text = aux
        
        cell.detailTextLabel?.text = respUsua
        
        let auxRespCorrecta = respuestasCorrectas2[indexPath.row]
        let auxRespUsuario = respuestas2[indexPath.row]
        
        
        if( auxRespUsuario == auxRespCorrecta ){
            cell.backgroundColor = UIColor.green.withAlphaComponent(0.5)
        }
        else{
            cell.backgroundColor = UIColor.red.withAlphaComponent(0.5)
        }
        
        lbCalif.text = String(calif) + " / 100"
        
        return cell
    }
    
    func storeResultados(){
        do{
            let data = try PropertyListEncoder().encode(resultados)
            try data.write(to: Resultado.archiveURL)
        }
        catch{
            print("Save Failed")
        }
    }
    
    func retrieveResultados() -> [Resultado]? {
        do{
            let data = try Data.init(contentsOf: Resultado.archiveURL)
            let empTmp = try
                PropertyListDecoder().decode([Resultado].self, from: data)
            return empTmp
        }
        catch{
            //print("nada perro")
            return nil
        }
    }
    
    func obtenerResultados(){
        resultados.removeAll()
        
        guard let empTmp = retrieveResultados() else { return }
        
        //for i in empTmp{
            //print(i.tema)
        //}
        resultados = empTmp
    }
    
    @IBAction func Regresar(_ sender: Any) {
        cambiaResultado()
        storeResultados()
    }
    
    func cambiaResultado(){
        //print(tema)
        var boolNuevoTema = true
        for i in resultados{
            if(i.tema == tema){
                boolNuevoTema = false
                i.result = calif
            }
        }
        if(boolNuevoTema){
            let resultadoAux = Resultado(tema: tema, result: calif)
            resultados.append(resultadoAux)
        }
        /*
        for i in resultados{
            print(i.tema)
            print(i.result)
            print("------")
        }*/
    }
    func calculaCalif(){
        for i in 0...4{
            if (respuestas2[i] != respuestasCorrectas2[i]){
                calif -= califPorRespuesta
            }
        }
    }
    
}
