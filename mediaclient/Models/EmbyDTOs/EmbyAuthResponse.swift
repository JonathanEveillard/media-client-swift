//
//  EmbyAuthResponse.swift
//  mediaclient
//
//  Created by Jonathan Eveillard on 2026-09-06.
//

// DTO response shape
struct UserResponseDTOL: Codable {
    let name: String
    let id: String
    let type: String
    let productionYear: Int?
}
