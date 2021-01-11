//
//  ViewControllerTemas.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/27/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class ViewControllerTemas: UIViewController , UITableViewDelegate , UITableViewDataSource {

    var arrDiccionario : NSArray!
    
    var resultados = [Resultado]()
    
    var bgColor: UIColor!
    
    var index = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
        view.backgroundColor = bgColor
        
        let path = Bundle.main.path(forResource: "Property List", ofType : "plist")
        
        arrDiccionario = NSArray(contentsOfFile: path!)
        
        obtenerResultados()
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrDiccionario.count
    }
    
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dicc = arrDiccionario[indexPath.row] as! NSArray
        
        let tema = (dicc[0] as! String)
        
        cell.textLabel?.text = tema
        cell.detailTextLabel?.text = "Resultado Anterior: " + regresaResultado(tema: tema)
        
        return cell
    }
    
    func regresaResultado(tema: String) -> String{
        
        for i in resultados{
            if (i.tema == tema){
                return String(i.result)
            }
        }
        return "0"
    }
    
    
    func retrieveResultados() -> [Resultado]? {
        do{
            let data = try Data.init(contentsOf: Resultado.archiveURL)
            let empTmp = try
                PropertyListDecoder().decode([Resultado].self, from: data)
            return empTmp
        }
        catch{
            print("nada perro")
            return nil
        }
    }
    
    func obtenerResultados(){
        resultados.removeAll()
        
        guard let empTmp = retrieveResultados() else { return }
        
        for i in empTmp{
            print(i.tema)
        }
        resultados = empTmp
    }
    
    
    private func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        let indexPath = tableView.indexPathForSelectedRow
        print(indexPath as Any)
        self.performSegue(withIdentifier: "tema", sender: tableView)
        
    }
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if(segue.identifier == "tema" ){
            let vista = segue.destination as! ViewControllerCargaPreguntas
            
            let dicc = arrDiccionario[index] as! NSArray
            
            vista.arr = dicc
        }
      
        
    }
    

}
