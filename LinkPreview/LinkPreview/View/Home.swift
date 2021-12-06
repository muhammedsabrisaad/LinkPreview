//
//  Home.swift
//  LinkPreview
//
//  Created by Muhammed Sabri Saad on 05/12/2021.
//

import SwiftUI

struct Home: View {
    
    @StateObject var messageData:MessagesViewModel = MessagesViewModel()
    
    var body: some View {
        NavigationView {
            ScrollView(.vertical, showsIndicators: false) {
                VStack(spacing: 15) {
                    ForEach(messageData.messages) { message in
                        CardView(message: message)
                    }
                }
            }
            .safeAreaInset(edge: .bottom) {
                HStack(spacing:13) {
                    TextField("Enter Message", text: $messageData.message)
                        .textFieldStyle(.roundedBorder)
                        .textCase(.lowercase)
                        .textInputAutocapitalization(.none)
                        .disableAutocorrection(true)
                    Button {
                        messageData.sendMessage()
                        UIApplication.shared.endEditing()
                    } label: {
                        Image(systemName: "paperplane")
                            .font(.title3)
                        
                    }
                }
                .padding()
                .padding(.top)
                .background(.ultraThickMaterial)
            }
            .navigationTitle("Link Preview")
        }
        .preferredColorScheme(.dark)
    }
    
    @ViewBuilder
    func CardView(message:Message) -> some View {
        Group {
            if message.loading {
                Group{
                    if let metaData = message.linkMetaData {
                        LinkPreview(metaData: metaData)
                            .aspectRatio(contentMode: .fit)
                            .frame(width: getRect().width - 80,alignment: .leading)
                            .cornerRadius(15)
                            .frame(maxWidth: .infinity,alignment: .trailing)
                        
                    }else {
                        HStack(spacing: 15) {
                            Text(message.linkURL?.host ?? "")
                                .font(.caption)
                            ProgressView()
                                .tint(.white)
                        }
                        .padding(.vertical,10)
                        .padding(.horizontal,10)
                        .background(Color.gray.opacity(0.35))
                        .cornerRadius(10)
                        .frame(maxWidth: .infinity,alignment: .trailing)
                    }
                }
            }else {
                Text(message.messageString)
                    .padding(.vertical,10)
                    .padding(.horizontal)
                    .foregroundColor(Color.white)
                    .background(Color.blue)
                    .cornerRadius(10)
                    .frame(width: getRect().width - 88,alignment: .trailing)
                    .frame(maxWidth: .infinity,alignment: .trailing)
            }
        }
    }
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}

extension View {
    func getRect() ->CGRect {
        return UIScreen.main.bounds
    }
}

extension UIApplication {
    func endEditing() {
        sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
    }
}
