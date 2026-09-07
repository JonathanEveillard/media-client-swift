//
//  EmbyClient.swift
//  mediaclient
//
//  Created by Jonathan Eveillard on 2026-09-06.
//

import Foundation

struct AuthRequestBody: Codable{
    let username: String
    let password: String
    
    enum CodingKeys: String, CodingKey {
        case username = "Username"
        case password = "Pw"
    }
}

// class EmbyClient conforms MediaServerClient
class EmbyClient: MediaServerClient {
    
    // Dependent on authenticate()
    var token:String?
    var userID:String?
    
    // Independent, requires specific fields only
    let host: String
    let port: String
    let useHTTPS: Bool
    let deviceID: String
    
    init(host: String, port: String, useHTTPS: Bool) {
        self.host = host
        self.port = port
        self.useHTTPS = useHTTPS
        self.deviceID = UUID().uuidString
    }
    
    func authenticate(username: String, password: String) async throws -> AuthResult {
        let scheme = useHTTPS ? "https" : "http"
        let urlString = "\(scheme)://\(host):\(port)/Users/AuthenticateByName"
        guard let url = URL(string: urlString) else {
            throw URLError(.badURL)
        }
        
        var request = URLRequest(url: url)
        
        // HTTP Method
        request.httpMethod = "POST"
        
        // Header
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        let authHeader = "Emby UserId=\"\", Client=\"Watchtower\", Device=\"Simulator\", DeviceId=\"\(deviceID)\", Version=\"1.0.0\""
        request.setValue(authHeader, forHTTPHeaderField: "X-Emby-Authorization")
        
        // Body
        let body = AuthRequestBody(username: username, password: password)
        let bodyData = try JSONEncoder().encode(body)
        request.httpBody = bodyData
        
        // HTTP Request
        let (data, response) = try await URLSession.shared.data(for: request)
        
        // HTTP Response
        guard let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 else {
            throw URLError(.userAuthenticationRequired)
        }
        
        // Decode JSON into EmbyAuthResponse
        let decoded = try JSONDecoder().decode(EmbyAuthResponse.self, from: data)
        
        // Update AuthResult
        self.token = decoded.accessToken
        self.userID = decoded.user.id
        
        // Return Value
        let result = AuthResult(accessToken: decoded.accessToken, userID: decoded.user.id)
        return result
    }
    
    func fetchLibrary() async throws -> [LibrarySection] {
        fatalError("not implemented")
    }

    func getStreamURL(for item: MediaItem) -> URL {
        fatalError("not implemented")
    }
}
