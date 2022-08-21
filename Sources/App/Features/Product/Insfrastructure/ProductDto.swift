//
//  File.swift
//  
//
//  Created by Santiago Mattiauda on 21/8/22.
//

import Foundation
import Vapor

struct ProductDto: Codable {
    let id, name: String
    let price: Double
    
    init(id: String, name: String, price: Double) {
        self.id = id
        self.name = name
        self.price = price
    }
    
    enum CodingKeys: String, CodingKey {
            case id, name, price
    }

    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        id = try container.decode(String.self, forKey: .id)
        name = try container.decode(String.self, forKey: .name)
        price = try container.decode(Double.self, forKey: .price)
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(price, forKey: .price)
    }
    
}


extension ProductDto: AsyncResponseEncodable {
  public func encodeResponse(for request: Request) async throws -> Response {
      var headers = HTTPHeaders()
      headers.add(name: .contentType, value: "application/json")
      let jsonEncoder = JSONEncoder()
      let jsonData = try jsonEncoder.encode(self)
      let json = String(data: jsonData, encoding: String.Encoding.utf8)
    return .init(status: .ok, headers: headers, body: .init(string: json!))
  }
}
