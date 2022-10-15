//
//  EmojiRatingView.swift
//  Bookworm
//
//  Created by Николай Никитин on 14.10.2022.
//

import SwiftUI

struct EmojiRatingView: View {

  //MARK: - Properties
  let rating: Int16

  //MARK: - View Body
  var body: some View {
    switch rating {
    case 1:
      Text("🤬")
    case 2:
      Text("😡")
    case 3:
      Text("😕")
    case 4:
      Text("🙂")
    default:
      Text("😁")
    }
  }
}

struct EmojiRatingView_Previews: PreviewProvider {
  static var previews: some View {
    EmojiRatingView(rating: 3)
  }
}
