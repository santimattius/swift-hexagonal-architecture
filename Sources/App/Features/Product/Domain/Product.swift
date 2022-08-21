//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation

struct Product {
    let id: ProductId
    let name: ProductName
    let price: ProductPrice
    
    init(id: ProductId, name: ProductName, price: ProductPrice) {
        self.id = id
        self.name = name
        self.price = price
    }
}

struct ProductId {
    let value:String
    
    init(value: String) throws {
        if value.isEmpty {
            throw IllegalArgumentError.productId(message: "ID required")
        }
        self.value = value
    }
    
}

struct ProductName{
    let value:String
    
    init(value: String) throws {
        if value.isEmpty {
            throw IllegalArgumentError.productName(message: "Name required")
        }
        self.value = value
    }
}

struct ProductPrice {
    
    let value:Double
    
    init(value: Double) throws {
        if value <= 0.0 {
            throw IllegalArgumentError.productPrice(message: "Price required")
        }
        self.value = value
    }
}

enum IllegalArgumentError: Error {
    case productId(message:String)
    case productName(message:String)
    case productPrice(message:String)
}
