//
//  ContentView.swift
//  Bookworm
//
//  Created by Николай Никитин on 11.10.2022.
//

import SwiftUI

struct ContentView: View {

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
              }
            }
          }
        }
      }
      .navigationTitle("BookWorm")
      .toolbar {
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
}

struct ContentView_Previews: PreviewProvider {
  static var previews: some View {
    ContentView()
  }
}
