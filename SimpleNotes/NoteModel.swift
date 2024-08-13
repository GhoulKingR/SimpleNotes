//
//  NoteModel.swift
//  SimpleNotes
//
//  Created by GhoulKingR on 12/08/2024.
//

import Foundation
import SwiftData

@Model
class Note: Identifiable {
    var id: String
    var title: String
    var body: String
    
    init(title: String, body: String) {
        self.id = UUID().uuidString
        self.title = title
        self.body = body
    }
}
