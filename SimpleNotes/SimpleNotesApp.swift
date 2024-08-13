//
//  SimpleNotesApp.swift
//  SimpleNotes
//
//  Created by GhoulKingR on 12/08/2024.
//

import SwiftUI
import SwiftData

@main
struct SimpleNotesApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: Note.self)
    }
}
