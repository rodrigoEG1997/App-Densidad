//
//  Pregunta.swift
//  Densidad
//
//  Created by Rodrigo Esparza on 4/6/19.
//  Copyright © 2019 Rodrigo Esparza. All rights reserved.
//

import UIKit

class Pregunta: NSObject {

    var pregunta : String!
    var respuesta1 : String!
    var respuesta2 : String!
    var respuesta3 : String!
    var respuesta4 : String!
    
    init(pre : String, resp1 : String, resp2 : String, resp3 : String, resp4 : String){
        self.pregunta = pre
        self.respuesta1 = resp1
        self.respuesta2 = resp2
        self.respuesta3 = resp3
        self.respuesta4 = resp4
    }
}
