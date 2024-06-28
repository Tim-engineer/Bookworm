//
//  ContentView.swift
//  Bookworm
//
//  Created by Tim Matlak on 25/06/2024.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) var modelContext
    @Query(sort: [
        SortDescriptor(\Book.rating, order: .reverse),
        SortDescriptor(\Book.title)
    ]) var books: [Book]
    
    @State private var showingAddView = false
    var body: some View {
        NavigationStack {
            List {
                ForEach(books) { book in
                    Section {
                        NavigationLink(value: book) {
                            HStack {
                                EmojiRatingView(rating: book.rating)
                                    .font(.largeTitle)
                                
                                VStack(alignment: .leading) {
                                    Text(book.title)
                                        .font(.headline)
                                    Text(book.author)
                                        .foregroundStyle(.secondary)
                                }
                            }
                        }
                        .listRowBackground(colorForRating(for: book.rating).opacity(0.8))
                    }
                }
                .onDelete(perform: deleteBooks)
            }
            .navigationDestination(for: Book.self) { book in
                DetailView(book: book)
            }
            .navigationTitle("Bookworm")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    EditButton()
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Add book", systemImage: "plus") {
                        showingAddView.toggle()
                    }
                }
            }
            .sheet(isPresented: $showingAddView) {
                AddBookView()
            }
        }
    }
    
    func deleteBooks(at offsets: IndexSet) {
        for offset in offsets {
            let book = books[offset]
            modelContext.delete(book)
        }
    }
    
    func colorForRating(for rating: Int) -> Color {
        switch rating {
        case 1:
            return Color.pink
        case 2:
            return Color.red
        case 3:
            return Color.indigo
        case 4:
            return Color.blue
        default:
            return Color.purple
        }
    }
}

#Preview {
    ContentView()
}
