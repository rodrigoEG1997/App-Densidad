//
//  Resultado.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/27/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class Resultado: Codable {
    var tema: String
    var result: Int
    
    
    static let documentsDirectory = FileManager().urls(for: .documentDirectory, in: .userDomainMask).first!
    
    static let archiveURL = documentsDirectory.appendingPathComponent("Resultados")
    
    init(tema : String, result: Int) {
        self.tema = tema
        self.result = result
    }
}
