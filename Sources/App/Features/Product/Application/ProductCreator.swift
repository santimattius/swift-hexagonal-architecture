//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation

struct ProductCreator {
    private let repository:ProductRepository
    
    init(repository: ProductRepository) {
        self.repository = repository
    }
    
    func invoke(id: ProductId, name: ProductName, price: ProductPrice) async throws -> Result<Product,ProductError> {
        let result = await repository.find(productId: id)
        switch result {
        case .success(_):
            return Result.failure(ProductError.productNotCreated(message: "The product already exists"))
        case .failure(_) :
            let product = Product(id: id, name: name, price: price)
            let productCreated = try await repository.save(product: product)
            return Result.success(productCreated)
        }
    }
}
