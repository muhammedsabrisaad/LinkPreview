//
//  MessagesViewModel.swift
//  LinkPreview
//
//  Created by Muhammed Sabri Saad on 05/12/2021.
//

import SwiftUI
import LinkPresentation

class MessagesViewModel: ObservableObject {
    @Published var message:String = ""
    @Published var messages:[Message] = []
    
    func sendMessage() {
        if !isMessageURL() {
            addMessage()
            return
        }
        
        guard let url = URL(string: message) else {
            return
        }
        let urlMessage = Message(messageString: message,loading: true,linkURL: url)
        messages.append(urlMessage)
        
        let provider = LPMetadataProvider()
        provider.startFetchingMetadata(for: url) {[self] meta, err in
            DispatchQueue.main.async {
                self.message = ""
                
                if let _ = err {
                    self.addMessage()
                    return
                }
                
                guard let meta = meta else {
                    self.addMessage()
                    return
                }
                
                if let index = messages.firstIndex(where: { mess in
                    return urlMessage.id == mess.id
                    
                }) {
                    messages[index].linkMetaData = meta
                }
            }
        }
    }
    
    func isMessageURL() -> Bool {
        if let url = URL(string: message) {
            return UIApplication.shared.canOpenURL(url)
        }
        return false
    }
    func addMessage() {
        messages.append(Message(messageString: message))
        message = ""
    }
}
