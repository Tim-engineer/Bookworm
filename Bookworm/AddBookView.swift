//
//  AddBookView.swift
//  Bookworm
//
//  Created by Tim Matlak on 26/06/2024.
//

import SwiftUI

struct AddBookView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var title = ""
    @State private var author = ""
    @State private var genre = "Fantasy"
    @State private var review = ""
    @State private var rating = 3
    
    let genres = ["Fantasy", "Biography", "Horror", "Kids", "Mystery", "Poetry", "Romance", "Thriller", "Business"]
    
    var disabled: Bool {
        if title.isEmpty || title.hasPrefix(" ") || author.isEmpty || author.hasPrefix(" ") || review.isEmpty || review.hasPrefix(" ") {
            return true
        }
        return false
    }
    
    var body: some View {
        NavigationStack {
            Form {
                Section {
                    TextField("Name of book", text: $title)
                    TextField("Author's name", text: $author)
                    
                    Picker("Genre", selection: $genre) {
                        ForEach(genres, id: \.self) {
                            Text($0)
                        }
                    }
                    .frame(height: 120)
                }
                
                Section("Write a review") {
                    TextEditor(text: $review)
                    
                    RatingView(rating: $rating)
                }
            }
            .pickerStyle(.wheel)
            .autocorrectionDisabled()
            
            .toolbar {
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") {
                        let newBook = Book(title: title, author: author, genre: genre, review: review, rating: rating)
                        modelContext.insert(newBook)
                        dismiss()
                    }
                    .tint(.green)
                    .disabled(disabled)
                }
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") {
                        dismiss()
                    }
                    .tint(.red)
                }
            }
        }
    }
}

#Preview {
    AddBookView()
}
