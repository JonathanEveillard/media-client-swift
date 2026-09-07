//
//  EmbyAuthResponse.swift
//  mediaclient
//
//  Created by Jonathan Eveillard on 2026-09-06.
//

struct EmbyUser: Codable{
    let name: String
    let id: String
    
    enum CodingKeys: String, CodingKey{
        case name = "Name"
        case id = "Id"
    }
}

// DTO response shape
struct EmbyAuthResponse: Codable {
    let user: EmbyUser
    let accessToken: String
    
    enum CodingKeys: String, CodingKey{
        case user = "User"
        case accessToken = "AccessToken"
    }
}
