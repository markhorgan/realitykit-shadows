// Copyright (c) 2022 Mark Horgan
//
// This source code is for individual learning purposes only. You may not copy,
// modify, merge, publish, distribute, create a derivative work or sell copies
// of the software in any work that is intended for pedagogical or
// instructional purposes.

import SwiftUI

struct ContentView: View {
    @State private var modelType: ModelType = .usdz
    
    var body: some View {
        VStack {
            ARViewContainer(modelType: $modelType).edgesIgnoringSafeArea([.top, .leading, .trailing])
            Menu {
                Button("USDZ") {
                    modelType = .usdz
                }
                Button("Programatic") {
                    modelType = .programatic
                }
            } label: {
                Text("Model Type")
                    .frame(height: 44)
            }
        }
    }
}

struct ARViewContainer: UIViewRepresentable {
    @Binding var modelType: ModelType
    
    func makeUIView(context: Context) -> CustomARView {
        return CustomARView(frame: .zero)
    }
    
    func updateUIView(_ uiView: CustomARView, context: Context) {
        uiView.setModel(modelType)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
