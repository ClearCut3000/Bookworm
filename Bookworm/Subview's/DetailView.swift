//
//  DetailView.swift
//  Bookworm
//
//  Created by Николай Никитин on 15.10.2022.
//

import SwiftUI

struct DetailView: View {

  //MARK: - View Properties
  let book: Book
  @Environment(\.managedObjectContext) var moc
  @Environment(\.dismiss) var dismiss
  @State private var showingDeleteAlert = false

  //MARK: - View Body
  var body: some View {
    ScrollView {
      ZStack(alignment: .bottomTrailing) {
        Image(book.genre ?? "Fantasy")
          .resizable()
          .scaledToFit()
        Text(book.genre?.uppercased() ?? "FANTASY")
          .font(.caption)
          .fontWeight(.black)
          .padding(8)
          .foregroundColor(.white)
          .background(.black.opacity(0.75))
          .clipShape(Capsule())
          .offset(x: -5, y: -5)
      }
      Text(book.author ?? "Unknown Authot")
        .font(.title)
        .foregroundColor(.secondary)
      Text(book.review ?? "No review")
        .padding()
      RatingView(rating: .constant(Int(book.rating)))
        .font(.largeTitle)
    }
    .navigationTitle(book.title ?? "Unknown Book")
    .navigationBarTitleDisplayMode(.inline)
    .alert("Delete Book?", isPresented: $showingDeleteAlert) {
      Button("Delete", role: .destructive, action: deleteBook)
      Button("Cancel", role: .cancel) { }
    } message: {
      Text("Are you sure?")
    }
    .toolbar {
      Button {
        showingDeleteAlert = true
      } label: {
        Label("Delete this book", systemImage: "trash")
      }
    }
  }

  //MARK: - View Methods
  func deleteBook() {
    moc.delete(book)
    if moc.hasChanges {
      try? moc.save()
    }
    dismiss()
  }
}

