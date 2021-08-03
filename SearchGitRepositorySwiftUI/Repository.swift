//
//  Repository.swift
//  TryFetchDataOnGit
//
//  Created by Дмитрий Геращенко on 28.07.2021.
//

import Foundation

struct Response: Codable {
  var items: [Item]
}

struct Item: Codable {
  var id: Int
  var name: String
  var owner: Owner
  var description: String
  var language: String?
  var stars: Int?
  var forks: Int?
  var license: License?
  
  enum CodingKeys: String, CodingKey {
    case id, name, owner, description, language
    case stars = "stargazers_count"
    case forks = "forks_Count"
    case license
  }
  
  var languageWrappedValue: String {
    language ?? "Unknown language"
  }
  
  var starsWrappedValue: Int {
    stars ?? 1
  }
  
  var forksWrappedValue: Int {
    forks ?? 1
  }
  
  var licenseWrappedValue: License {
    license ?? License(name: "Unknown license", url: "Unknown url")
  }
}

struct License: Codable {
  var name: String?
  var url: String?
}

struct Owner: Codable {
  var id: Int
  var login: String
  var avatar: String
  var type: String?
  
  enum CodingKeys: String, CodingKey {
    case id, login
    case avatar = "avatar_url"
    case type
  }
  
  var typeWrappedValue: String {
    type ?? "Unknown type"
  }
}
