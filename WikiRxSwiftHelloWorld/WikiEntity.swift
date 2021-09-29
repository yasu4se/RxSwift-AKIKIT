//
//  WikiEntity.swift
//  WikiRxSwiftHelloWorld
//
//  Created by yasushi saitoh on 2021/09/26.
//

import Foundation

struct WikiEntity: Decodable {
    let query: Query?
}

struct Query: Decodable {
    let search: [Search]
}

struct Search: Decodable {
    let title: String
    let pageid: Int
}
