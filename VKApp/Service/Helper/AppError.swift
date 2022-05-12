//
//  AppError.swift
//  VKApp
//
//  Created by Никита Мошенцев on 26.04.2022.
//

import Foundation
import CoreMedia

enum AppError: Error {
    case noDataProvided
    case failedToDecode
    case errorTask
    case notCorrectURL
}
