//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation

final class ServiceLocator {
    
    static let shared = ServiceLocator()
    
    private var productRepository:ProductRepository? = nil
    
    private init(){}
    
    func provideProductRepository() -> ProductRepository {
        if let repository = productRepository{
            return repository
        } else{
            let repository = InMemoryProductRepository()
            self.productRepository = repository
            return repository
        }
    }
    
    func provideProductCreator() -> ProductCreator{
        return ProductCreator(repository: provideProductRepository())
    }
    
    func provideProductController() -> ProductController {
        return ProductController(productCreator: provideProductCreator())
    }
    
    func provideHealtCheckController() -> HealthcheckController {
        return HealthcheckController()
    }
}
