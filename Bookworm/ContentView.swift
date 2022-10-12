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
  @FetchRequest(sortDescriptors: []) var books: FetchedResults<Book>

  @State private var showingAddScreen = false

  //MARK: - View Body
    var body: some View {
      NavigationView {
        Text("Count: \(books.count)")
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
