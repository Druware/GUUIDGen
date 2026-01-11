//
//  ContentView.swift
//  GUUIDGen
//
//  Created by Andrew Satori on 11/9/21.
//

import SwiftUI
import Foundation

struct ContentView: View {
    @StateObject private var model : GUUIDGenAppModel = GUUIDGenAppModel()
    var body: some View {
        VStack(alignment: .leading)
        {
            HStack(alignment: .top) {
                VStack(alignment: .leading) {
                        Text("Choose the desired format below, then select \"Copy\" to copy the results to the clipboard. The result can then be pasted anywhere text is supported.")
                    GroupBox(label:Label("GUUID Format", systemImage: "questionmark.circle").font(.headline)) {
                        Picker("", selection: $model.guidFormat) {
                                Text("IMPLEMENT_OLECREATE(...)").tag(GUIDFormat.oleCreate)
                                Text("DEFINE_GUID(...)").tag(GUIDFormat.define)
                                Text("static const struct GUId = {...}").tag(GUIDFormat.staticConst)
                                Text("String Format {...}").tag(GUIDFormat.string)
                            }
                            .padding(.vertical)
                            .pickerStyle(.radioGroup)
                            .frame( maxWidth: .infinity)

                    }
                }.padding(.horizontal, 8)
                .padding(.vertical, 8)
                VStack(alignment: .leading) {
                    Button(action: {
                        let pasteBoard = NSPasteboard.general
                        pasteBoard.clearContents()
                        pasteBoard.writeObjects([model.uuidString as NSString])
                    }) {
                        Text("Copy").frame(width: 92)
                    }.keyboardShortcut(.defaultAction)
                    Button(action: {
                        model.newGuid()
                    }) {
                        Text("New Guid").frame(width: 92)
                    }.keyboardShortcut("n", modifiers: [.command])
                    Button(action: {
                        NSApplication.shared.keyWindow?.close()
                    }) {
                        Text("Exit").frame(width: 92)
                    }.keyboardShortcut(.cancelAction)
                    Spacer()
                }.padding(.horizontal, 8).padding(.vertical, 8)
            }
            Spacer()
            Divider()
            GroupBox(label:
                        Label("Result", systemImage: "doc.text").font(.headline)) {
                Text(model.uuidString).frame(minWidth: 200, maxWidth: .infinity)
            }.padding(8)
        }.padding(8)
        .frame(maxWidth: 380, maxHeight: 380)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
            .frame(minWidth: 0, minHeight:240.0)
            .frame(maxWidth: 380, maxHeight: 380)
    }
}
