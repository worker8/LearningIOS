//
//  ContentView.swift
//  LearniOS2
//
//  Created by Tan Jun Rong on 2023/12/27.
//

import SwiftUI


struct ContentView: View {
    @ObservedObject var viewModel = ViewModel()
    
    var body: some View {
        List {
            ForEach(0 ..< viewModel.models.count, id: \.self) { index in
                let model = viewModel.models[index]
                Text(model.title)
            }
            
        }
        .padding()
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        VStack {
            ContentView()
            ContentView()
        }
        
    }
}

class ViewModel : ObservableObject {
    @Published var models = [Model]()
    init() {
        APIFetchHandler.sharedInstance.fetchAPIData(completion:  { models in
            print("models.count: \(models.count)")
            self.models = models
        })
        
    }
}

