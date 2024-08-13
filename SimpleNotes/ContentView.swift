//
//  ContentView.swift
//  SimpleNotes
//
//  Created by GhoulKingR on 12/08/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var context
    @Query private var notes: [Note]
    @State private var selected = ""
    @State private var text = ""
    @State private var editTitle = false
    @State private var title = ""
    
    
    var body: some View {
        NavigationSplitView(sidebar: {
            List {
                ForEach(notes.reversed()) {note in
                    if selected == note.id {
                        if editTitle {
                            HStack {
                                TextField("Title...", text: $title)
                                    .onSubmit {
                                        note.title = title
                                        try? context.save()
                                        editTitle = false
                                    }
                                    .padding(10)
                                    .clipShape(RoundedRectangle(cornerRadius: 2))
                            }
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        } else {
                            HStack {
                                Text(note.title)
                                    .foregroundStyle(.white)
                                    .padding(10)
                                Spacer()
                            }
                            .background(Color.accentColor)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                            .onTapGesture {
                                editTitle = true
                            }
                        }
                    } else {
                        HStack {
                            Text(note.title)
                                .foregroundStyle(.white)
                                .padding(10)
                            Spacer()
                        }
                        .onTapGesture {
                            selected = note.id
                            text = note.body
                            title = note.title
                        }
                    }
                }
            }
        }, detail: {
            if !selected.isEmpty {
                if let index = notes.firstIndex(where: { $0.id == selected }) {
                    TextEditor(text: $text)
                        .padding(.top, 10)
                        .font(.body)
                        .background()
                        .onChange(of: text, {
                            notes[index].body = text
                            try? context.save()
                        })
                }
            }
        })
        .frame(minWidth: 500, minHeight: 500)
        .navigationTitle(!selected.isEmpty ? {
            if let index = notes.firstIndex(where: { $0.id == selected }) {
                return notes[index].title
            } else {
                return ""
            }
        }() : "Simple Notes")
        .toolbar(content: {
            HStack {
                if !selected.isEmpty {
                    Image(systemName: "trash")
                        .imageScale(.large)
                        .aspectRatio(contentMode: .fit)
                        .padding(.trailing, 10)
                        .onTapGesture {
                            if let index = notes.firstIndex(where: { $0.id == selected }) {
                                context.delete(notes[index])
                                selected = ""
                            }
                        }
                    Divider()
                }
                Image(systemName: "square.and.pencil")
                    .imageScale(.large)
                    .aspectRatio(contentMode: .fit)
                    .padding(.leading, 10)
                    .onTapGesture {
                        let newData = Note(title: "New Note", body: "")
                        context.insert(newData)
                        selected = newData.id
                        text = newData.body
                        title = newData.title
                    }
            }
        })
    }
}

#Preview {
    ContentView()
}
