//
//  ContentView.swift
//  TagListView
//
//  Created by Maxim Macari on 26/1/21.
//

import SwiftUI

struct ContentView: View {
    var body: some View {
        NavigationView{
            Home()
        }
        .navigationBarTitleDisplayMode(.inline)
        .navigationTitle("Tags")
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
