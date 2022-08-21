//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation


protocol ProductRepository {
    func find(productId:ProductId) async -> Result<Product,ProductError>
    func save(product:Product) async throws -> Product
}
