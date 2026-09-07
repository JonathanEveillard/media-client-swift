//
//  MediaServerClient.swift
//  mediaclient
//
//  Created by Jonathan Eveillard on 2026-09-06.
//

protocol MediaServerClient:AnyObject {
    
    func authenticate(username:String, password:String) async throws -> AuthResult
    func fetchLibrary() async throws -> [LibrarySection]
    func getStreamURL(for item: MediaItem) -> URL
}
