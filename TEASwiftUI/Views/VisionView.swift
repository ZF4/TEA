//
//  VisionView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 7/4/23.
//

import SwiftUI
import VisionKit

struct VisionView: View {
    @EnvironmentObject var model: VisionModel
    @State var textFieldText: String = ""
    @State var scanText: String = ""
    @State private var showingSheet: Bool = false
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        switch model.dataScannerAcessStatus {
        case .scannerAvailable:
            sheetView
        case .cameraNotAvailable:
            Text("Your device doesn't have a camera")
        case .scannerNotAvailable:
            Text("Your device doesn't have support for scanning data with this app")
        case .cameraAccessNotGranted:
            Text("Please provide access to the camera in settings")
        case .notDertermined:
            Text("Requesting camera access")
        }
    }
    
    private var sheetView: some View {
        VStack {
            ScannerViewModel(recognizedItems: $model.recognizedItems, storedItems: $model.storedItems, recognizedDataType: model.recognizedDataType, recognizesMultipleItems: model.recognizedMultipleItems)
                .ignoresSafeArea()
                .id(model.dataScannerViewId)
            
//            textView
            
            Button("Press to dismiss camera view") {
                dismiss()
                
                model.returnStoredItems()
//                for i in vm.storedItems {
//                    vm.textFieldText = i.string?.capitalizedSentence ?? "No stored items."
//                }
            }
        }
        .onChange(of: model.recognizedMultipleItems) { _ in model.recognizedItems = [] }
    }
}

struct VisionView_Previews: PreviewProvider {
    static var previews: some View {
            VisionView()
    }
}
