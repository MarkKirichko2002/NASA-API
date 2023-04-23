//
//  NASAServiceProtocol.swift
//  NASA API
//
//  Created by Марк Киричко on 23.04.2023.
//

import Foundation

protocol NASAServiceProtocol {
    func MakeAPICallWithOtherDate<T: Codable>(type: T.Type, response: ResponseType, date: String, completion: @escaping(Result<T,Error>)->Void)
    func execute<T: Codable>(type: T.Type, response: ResponseType,completion: @escaping(Result<T,Error>)->Void)
    func fetchVideo(json: String, completion: @escaping(String)->())
}
