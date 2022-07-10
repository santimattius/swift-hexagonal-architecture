//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 31/5/22.
//

import Foundation

class HealthcheckController{
    
    func get() async throws -> String{
        return "Service running!"
    }
}
