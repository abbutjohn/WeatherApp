//
//  APIError.swift
//  POC-VisualEditor
//
//  Created by Praveen George on 28/07/2021.
//

import Foundation

public enum APIError: Error {
    case responseUnsuccessful
    case invalidData
    case jsonParsingFailure
}
