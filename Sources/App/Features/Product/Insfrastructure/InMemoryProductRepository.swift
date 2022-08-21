//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation


class InMemoryProductRepository: ProductRepository {
    
    private var products:[String: Product] = [:]
    
    func find(productId: ProductId) async -> Result<Product,ProductError> {
        if let product = products[productId.value]{
            return Result<Product, ProductError>.success(product)
        }else{
            let message = "Product with id \(productId.value) no exists"
            return Result<Product, ProductError>.failure(ProductError.productNoExists(message: message))
        }
    }
    
    func save(product: Product) async throws -> Product {
        products[product.id.value] = product
        return product
    }
}


enum ProductError:Error {
    case productNoExists(message:String)
    case productNotCreated(message:String)
}
