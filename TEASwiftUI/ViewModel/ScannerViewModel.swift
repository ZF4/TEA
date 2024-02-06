//
//  DataScannerView.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 7/3/23.
//

import Foundation
import SwiftUI
import VisionKit

struct ScannerViewModel: UIViewControllerRepresentable {
    @Binding var recognizedItems: [RecognizedItem]
    @Binding var storedItems: [StoredModel]
    @EnvironmentObject var model: VisionModel
    let recognizedDataType: DataScannerViewController.RecognizedDataType
    let recognizesMultipleItems: Bool
    
    func makeUIViewController(context: Context) -> DataScannerViewController {
        let vc = DataScannerViewController(
        recognizedDataTypes: [recognizedDataType],
        qualityLevel: .balanced,
        recognizesMultipleItems: recognizesMultipleItems,
        isGuidanceEnabled: true,
        isHighlightingEnabled: true
        )
        return vc
    }
    
    func updateUIViewController(_ uiViewController: DataScannerViewController, context: Context) {
        uiViewController.delegate = context.coordinator
        try? uiViewController.startScanning()
    }
        
    func makeCoordinator() -> Coordinator {
        Coordinator(recognizedItems: $recognizedItems, storedItems: $storedItems)
    }
    
    class Coordinator: NSObject, DataScannerViewControllerDelegate {
        @Binding var recognizedItems: [RecognizedItem]
        @Binding var storedItems: [StoredModel]
        var model = VisionModel()
        
        init(recognizedItems: Binding<[RecognizedItem]>, storedItems: Binding<[StoredModel]>) {
            self._recognizedItems = recognizedItems
            self._storedItems = storedItems
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didTapOn item: RecognizedItem) {
            UINotificationFeedbackGenerator().notificationOccurred(.success)

            let data = TransientModel(item: item).toStoredItem()
            storedItems.append(data)
            print("Did tap on \(item)")
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didAdd addedItems: [RecognizedItem], allItems: [RecognizedItem]) {

        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, didRemove removedItems: [RecognizedItem], allItems: [RecognizedItem]) {
        }
        
        func dataScanner(_ dataScanner: DataScannerViewController, becameUnavailableWithError error: DataScannerViewController.ScanningUnavailable) {
            print("Become unavailble with error ***\(error)")
        }
    }
}
