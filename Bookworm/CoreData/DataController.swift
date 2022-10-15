//
//  DataController.swift
//  Bookworm
//
//  Created by Николай Никитин on 11.10.2022.
//

import CoreData
import Foundation

class DataController: ObservableObject {
  let container = NSPersistentContainer(name: "Bookworm")

  init() {
    container.loadPersistentStores { description, error in
      if let error = error {
        print("CoreData failed to load: \(error.localizedDescription)")
      }
    }
  }
}
