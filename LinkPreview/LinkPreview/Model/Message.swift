//
//  Message.swift
//  LinkPreview
//
//  Created by Muhammed Sabri Saad on 05/12/2021.
//

import SwiftUI
import LinkPresentation

struct Message: Identifiable {
    var id = UUID().uuidString
    var messageString: String
    var date: Date = Date()
    var loading: Bool = false
    var linkMetaData: LPLinkMetadata?
    var linkURL:URL?
}
