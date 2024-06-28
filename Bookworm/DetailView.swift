//
//  DetailView.swift
//  Bookworm
//
//  Created by Tim Matlak on 27/06/2024.
//

import SwiftUI
import SwiftData

struct DetailView: View {
    @Environment(\.modelContext) var modelContext
    @Environment(\.dismiss) var dismiss
    @State private var showingDeleteAlert = false
    
    let book: Book
    
    var body: some View {
        ScrollView {
            ZStack(alignment: .topLeading) {
                Image(book.genre)
                    .resizable()
                    .scaledToFit()
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .padding(.horizontal, 8)
                Button(book.genre.uppercased()) { }
                    .font(.caption)
                    .buttonStyle(.bordered)
                    .tint(.white)
                    .padding().padding(.leading, 8)
            }
            VStack {
                Text(book.author)
                    .font(.title)
                Text(book.review)
                    .padding()
                RatingView(rating: .constant(book.rating))
                    .font(.title)
                    .padding(.top)
                Button(book.date.formatted(date: .abbreviated, time: .shortened)) { }
                    .padding(.top, 32)
                    .buttonStyle(.bordered)
                    .tint(.primary)
            }
        }
        .navigationTitle(book.title)
        .navigationBarTitleDisplayMode(.inline)
        .scrollBounceBehavior(.basedOnSize)
        .alert("Delete book", isPresented: $showingDeleteAlert) {
            Button("Delete", role: .destructive, action: deleteBook)
            Button("Cancel", role: .cancel) { }
        } message: {
            Text("Are you sure ?")
        }
        .toolbar {
            Button("Delete this book", systemImage: "trash") {
                showingDeleteAlert.toggle()
            }
        }
    }
    
    func deleteBook() {
        modelContext.delete(book)
        dismiss()
    }
}

#Preview {
    do {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try ModelContainer(for: Book.self, configurations: config)
        let example = Book(title: "Title", author: "Author", genre: "Horror", review: "This book was very good, it gave me a lot of new perspectives in live", rating: 4)
        
        return DetailView(book: example)
            .modelContainer(container)
    } catch {
        return Text("Failed to create preview: \(error.localizedDescription)")
    }
}
