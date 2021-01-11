//
//  TableViewControllerPreguntas.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/6/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit


class TableViewControllerPreguntas: UITableViewController {
    
    var arrDiccionario : NSArray!
    
    var resultados = [Resultado]()
    
    var bgColor: UIColor!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        
        view.backgroundColor = bgColor
        
        
        let path = Bundle.main.path(forResource: "Property List", ofType : "plist")
        
        arrDiccionario = NSArray(contentsOfFile: path!)
        
        obtenerResultados()
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false
        
        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return arrDiccionario.count
    }
    
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        
        let dicc = arrDiccionario[indexPath.row] as! NSArray
        
        let tema = (dicc[0] as! String)
        
        cell.textLabel?.text = tema
        cell.detailTextLabel?.text = "Resultado Anterior: " + regresaResultado(tema: tema)
        
        cell.backgroundColor = bgColor
        
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
    
    
    
    /*
     // Override to support conditional editing of the table view.
     override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the specified item to be editable.
     return true
     }
     */
    
    /*
     // Override to support editing the table view.
     override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
     if editingStyle == .delete {
     // Delete the row from the data source
     tableView.deleteRows(at: [indexPath], with: .fade)
     } else if editingStyle == .insert {
     // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
     }
     }
     */
    
    /*
     // Override to support rearranging the table view.
     override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {
     
     }
     */
    
    /*
     // Override to support conditional rearranging of the table view.
     override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
     // Return false if you do not want the item to be re-orderable.
     return true
     }
     */
    
    
    // MARK: - Navigation
    
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        
        let vista = segue.destination as! ViewControllerCargaPreguntas

        vista.bgColor = self.bgColor
        
        let indexPath = tableView.indexPathForSelectedRow!
        
        let dicc = arrDiccionario[indexPath.row] as! NSArray
        
        vista.arr = dicc
        
    }
    
    @IBAction func unwindRegresaCuestionate(segue: UIStoryboardSegue){
        obtenerResultados()
    }
    
    
}

