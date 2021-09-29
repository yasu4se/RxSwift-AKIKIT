//
//  EntityDataParser.swift
//  
//
//  Created by yasushi saitoh on 2021/09/26.
//

import Foundation
import APIKit

final class EntityDataParser<T: Decodable>: APIKit.DataParser {
    var contentType: String? {
        return "application/json"
    }

    func parse(data: Data) throws -> Any {
        // デコードする
        return try JSONDecoder().decode(T.self, from: data)
    }
}

