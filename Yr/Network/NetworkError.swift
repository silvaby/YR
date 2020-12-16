//
//  NetworkError.swift
//  Yr
//
//  Created by Dzmitry on 16.12.20.
//

enum NetworkError: Error {
    case badResponse(statusCode: Int)
    case failedRequest(description: String)
    case nonHTTPResponse
    case invalidURLRequest
    case noData
}
