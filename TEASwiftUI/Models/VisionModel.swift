//
//  VisionModel.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 7/3/23.
//

import Foundation
import AVKit
import SwiftUI
import VisionKit

enum ScanTypes: String {
    case text, barcode
}

enum DataScannerAccessStatusType {
    case notDertermined
    case cameraAccessNotGranted
    case cameraNotAvailable
    case scannerAvailable
    case scannerNotAvailable
}

@MainActor
final class VisionModel: ObservableObject {
    @Published var dataScannerAcessStatus: DataScannerAccessStatusType = .notDertermined
    @Published var recognizedItems: [RecognizedItem] = []
    @Published var storedItems: [StoredModel] = []
    @Published var scanType: ScanTypes = .text
    @Published var textContentType: DataScannerViewController.TextContentType?
    @Published var recognizedMultipleItems: Bool = false
    @Published var textFieldText: String = ""

    var recognizedDataType: DataScannerViewController.RecognizedDataType {
        scanType == .barcode ? .barcode() : .text(textContentType: textContentType)
    }
    
    var headerText: String {
        if recognizedItems.isEmpty {
            return "Scanning \(scanType.rawValue)"
        } else {
            return "Recognized \(recognizedItems.count) item(s)"
        }
    }
    
    var dataScannerViewId: Int {
        var hasher = Hasher()
        hasher.combine(scanType)
        hasher.combine(recognizedMultipleItems)
        if let textContentType {
            hasher.combine(textContentType)
        }
        return hasher.finalize()
    }
    
    private var isScannerAvailable: Bool {
        DataScannerViewController.isAvailable && DataScannerViewController.isSupported
    }
    
    func returnStoredItems() {
        for i in storedItems {
            textFieldText = i.string?.capitalizedSentence ?? "No stored items."
        }
    }
    
    func requestDataScannerAccessStatus() async {
        guard UIImagePickerController.isSourceTypeAvailable(.camera) else {
            dataScannerAcessStatus = .cameraNotAvailable
            return
        }
        
        switch AVCaptureDevice.authorizationStatus(for: .video) {
        case .authorized:
            dataScannerAcessStatus = isScannerAvailable ? .scannerAvailable : .scannerNotAvailable
            
        case .restricted, .denied:
            dataScannerAcessStatus = .cameraAccessNotGranted
            
        case .notDetermined:
            let granted = await AVCaptureDevice.requestAccess(for: .video)
            if granted {
                dataScannerAcessStatus = isScannerAvailable ? .scannerAvailable : .scannerAvailable
            } else {
                dataScannerAcessStatus = .cameraAccessNotGranted
            }
        default: break
        }
    }
}
