//
//  LibrarySection.swift
//  mediaclient
//
//  Created by Jonathan Eveillard on 2026-09-06.
//

enum ItemType{
    case movie
    case show
    case unknown
}

struct LibrarySection {
    let id: String
    let name: String
    let type: ItemType
}
