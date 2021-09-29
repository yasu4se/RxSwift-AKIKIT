//
//  WikiRequest.swift
//  
//
//  Created by yasushi saitoh on 2021/09/26.
//

import Foundation
import APIKit
import RxSwift

struct WikiRequest: APIKit.Request {

    typealias Response = WikiEntity

    let query: String

    var baseURL: URL {
        let urlStr = "https://ja.wikipedia.org/w/api.php?format=json&action=query&list=search&srlimit=30&srsearch=\(self.query)"
        return URL(string: urlStr.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed)!)!
    }

    let method: HTTPMethod = .post

    let path: String = ""
}

extension APIKit.Request where Self.Response: Decodable {

    var dataParser: APIKit.DataParser {
        // 作成したEntityDataParserを使用する
        return EntityDataParser<Response>()
    }

    func response(from object: Any, urlResponse: HTTPURLResponse) throws -> Response {
        // objectの型をチェック
        // Responseと型が一致していなければエラーを投げる
        guard let entity = object as? Response else {
            throw ResponseError.unexpectedObject(object)
        }
        return entity
    }
}

extension APIKit.Request {

    func rx_send() -> Observable<Self.Response> {
        return Observable.create { observer in
            let task = Session.shared.send(self) { result in
                switch result {
                case .success(let res):
                    observer.on(.next(res))
                    observer.on(.completed)

                case .failure(let err):
                    observer.onError(err)
                }
            }
            return Disposables.create {
                task?.cancel()
            }
        }
    }
}
