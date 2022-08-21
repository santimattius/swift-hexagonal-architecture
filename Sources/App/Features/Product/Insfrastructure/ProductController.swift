//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation
import Vapor

class ProductController{
    
    private let productCreator: ProductCreator
    
    init(productCreator: ProductCreator) {
        self.productCreator = productCreator
    }
    
    func post(request:Request) async throws -> Result<ProductDto,ProductCreationError> {
        let body = try request.content.decode(ProductDto.self)
        let result = try await create(id: body.id, name: body.name, price: body.price)
        switch result {
        case .success(let product):
            let product = ProductDto(id: product.id.value, name: product.name.value, price: product.price.value)
            return Result.success(product)
        case .failure(let error):
            return Result.failure(error)
        }
    }
    
    private func create(id:String,name:String,price:Double) async throws -> Result<Product,ProductCreationError> {
        do{
            let productId = try ProductId(value: id)
            let productName = try ProductName(value: name)
            let productPrice = try ProductPrice(value: price)
            
            let result = try await productCreator.invoke(id: productId, name: productName, price: productPrice)
            switch result {
            case .success(let product):
                return Result.success(product)
            case .failure (let error):
                let message = errorMessage(error: error)
                return Result.failure(ProductCreationError(message: message))
            }
        } catch IllegalArgumentError.productPrice(let message) {
            return Result.failure(ProductCreationError(message: message))
        } catch IllegalArgumentError.productName(let message) {
            return Result.failure(ProductCreationError(message: message))
        } catch IllegalArgumentError.productPrice(let message) {
            return Result.failure(ProductCreationError(message: message))
        } catch {
            return Result.failure(ProductCreationError(message: "creation failed"))
        }
    }
    
    func errorMessage(error:ProductError) -> String {
        switch error {
        case .productNotCreated(let message):
            return message
        case .productNoExists(let message):
            return message
        }
    }
}

struct ProductCreationError:Error {
    let message:String
    init(message: String) {
        self.message = message
    }
}
