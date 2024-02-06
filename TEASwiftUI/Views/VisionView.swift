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
            cameraView
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
    
    private var cameraView: some View {
        ScannerViewModel(recognizedItems: $model.recognizedItems, storedItems: $model.storedItems, recognizedDataType: model.recognizedDataType, recognizesMultipleItems: model.recognizedMultipleItems)
            .background { Color.gray.opacity(0.3) }
            .ignoresSafeArea()
            .id(model.dataScannerViewId)
            .sheet(isPresented: .constant(true)) {
                textView
                    .presentationBackground(.ultraThinMaterial)
                    .presentationDetents([.fraction(0.25)])
                    .presentationBackgroundInteraction(.enabled(upThrough: .fraction(0.25)))
                    .interactiveDismissDisabled()
                    .onAppear {
                        guard let windowScene = UIApplication.shared.connectedScenes.first as? UIWindowScene,
                              let controller = windowScene.windows.first?.rootViewController?.presentedViewController else {
                            return
                        }
                        controller.view.backgroundColor = .clear
                    }
            }
    }
    
    private var textView: some View {
        VStack {
            HStack {
                Image(systemName: "info.circle.fill")
                Text("Tap on the word you want to save once it is highlighted.")
                    .foregroundStyle(Color.white)
            }
            .padding(.bottom, 10)
            
            Button("Dismiss camera") {
                model.returnStoredItems()
                
                dismiss()
            }
            .buttonStyle(.bordered)
            .tint(.blue)
        }
    }
}

//struct VisionView_Previews: PreviewProvider {
//    static var previews: some View {
//            VisionView()
//    }
//}
