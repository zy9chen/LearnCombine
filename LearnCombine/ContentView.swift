//
//  ContentView.swift
//  LearnCombine
//
//  Created by Zhaoyang Chen on 2020-11-25.
//

import SwiftUI

struct ContentView: View {
    @StateObject var viewModel = ViewModel()
    
    var body: some View {
        Text(viewModel.time)
            .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
