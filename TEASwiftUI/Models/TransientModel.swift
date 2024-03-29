//
//  TransientItem.swift
//  TEASwiftUI
//
//  Created by Zachary Farmer on 8/14/23.
//

import Foundation
import VisionKit
import SwiftUI

class TransientModel: Identifiable, Equatable, ObservableObject {
  var id: UUID { item.id }
  @Published var item: RecognizedItem
    
    init(item: RecognizedItem) {
        self.item = item
    }

  var textContent: String? {
    switch item {
    case .text(let rtext):
      return rtext.transcript
    case .barcode(let barcode):
      return barcode.payloadStringValue
    @unknown default:
      return nil
    }
  }

  static func == (lhs: TransientModel, rhs: TransientModel) -> Bool {
    lhs.id == rhs.id
  }

  var isText: Bool {
    switch item {
    case .text:
      return true
    default:
      return false
    }
  }

  var isBarcode: Bool {
    switch item {
    case .barcode:
      return true
    default:
      return false
    }
  }

  /// convert `VKRect` to a `CGRect`
  var bounds: CGRect {
    let vkrect = item.bounds
    let width = vkrect.topRight.x - vkrect.topLeft.x
    let height = vkrect.bottomRight.y - vkrect.topRight.y
    return CGRect(
      x: vkrect.topLeft.x + width / 2,
      y: vkrect.topLeft.y + height / 2,
      width: width,
      height: height
    )
  }
}

extension TransientModel {
  var icon: String {
    if isText {
      return "text.bubble"
    } else {
      return "barcode"
    }
  }
}

extension TransientModel {
  func toStoredItem() -> StoredModel {
    return StoredModel(
      id: id,
      string: textContent,
      type: isBarcode ? .barcode:.text,
      barcodeSymbology: {
        switch item {
        case .barcode(let barcode):
          return barcode.observation.symbology.rawValue
        default:
          return nil
        }
      }()
    )
  }
}
