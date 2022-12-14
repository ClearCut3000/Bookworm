//
//  BookWormView.swift
//  Bookworm
//
//  Created by Николай Никитин on 11.10.2022.
//

import SwiftUI

struct BookWormView: View {

  //MARK: - View Properties
  @Environment(\.managedObjectContext) var moc
  @FetchRequest(sortDescriptors: [
    SortDescriptor(\.title),
    SortDescriptor(\.author)
  ]) var books: FetchedResults<Book>

  @State private var showingAddScreen = false

  //MARK: - View Body
  var body: some View {
    NavigationView {
      List {
        ForEach(books) { book in
          NavigationLink {
            DetailView(book: book)
          } label: {
            HStack {
              EmojiRatingView(rating: book.rating)
                .font(.largeTitle)
              VStack(alignment: .leading) {
                Text(book.title ?? "Unknown title")
                  .font(.headline)
                Text(book.author ?? "Unknown author")
                  .foregroundColor(.secondary)
                Text(book.date?.formatted(date: .abbreviated, time: .omitted) ?? "Date not available")
                  .font(.caption)
              }
            }
          }
          .listRowBackground(book.rating < 2 ? Color.red.opacity(0.25) : Color.secondary.opacity(0.1))
        }
        .onDelete(perform: deleteBooks)
      }
      .navigationTitle("BookWorm")
      .toolbar {
        ToolbarItem(placement: .navigationBarLeading) {
          EditButton()
        }
        ToolbarItem(placement: .navigationBarTrailing) {
          Button {
            showingAddScreen.toggle()
          } label: {
            Label("Add Book", systemImage: "plus")
          }
        }
      }
      .sheet(isPresented: $showingAddScreen) {
        AddBookView()
      }
    }
  }

  //MARK: - View Methods
  func deleteBooks(at offsets: IndexSet) {
    for offset in offsets {
      let book = books[offset]
      moc.delete(book)
    }
    if moc.hasChanges {
      try? moc.save()
    }
  }
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    BookWormView()
  }
}
