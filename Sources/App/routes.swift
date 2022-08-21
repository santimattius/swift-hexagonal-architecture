import Vapor

func routes(_ app: Application) throws {
    
    let serviceLocator = ServiceLocator.shared
        
    app.get("healthcheck"){ req async throws -> String in
        let controller = serviceLocator.provideHealtCheckController()
        let result = try await controller.get()
        return "\(result)"
    }
    
    app.post("product"){ req async throws -> ProductDto in
        let controller = serviceLocator.provideProductController()
        let result = try controller.post(request: req)
        switch result{
        case .success(let product):
            return product
        case .failure(let error):
            throw error
        }
    }
}


