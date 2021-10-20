//
//  AppErrors.swift
//  SearchGitRepositorySwiftUI
//
//  Created by Дмитрий Геращенко on 15.10.2021.
//

import Foundation

enum AppError: Error {
  case invalidURL
  case unableToComplete
  case InvalidResponse
  case invalidData
}
