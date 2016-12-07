//
//  Utils.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation
import UIKit

struct Utils {
    /// Given a product return an NSAttributedString containing the new price with the old price scored out
    static func buildReducedPriceLabel(forProduct product: Product) -> NSAttributedString? {
        guard let oldPriceVal = product.oldPrice else {
            return nil
        }
        
        let oldPrice = "£\(oldPriceVal)"
        let priceAttStr = NSMutableAttributedString(string: "\(oldPrice) £\(product.price)")
        priceAttStr.addAttribute(NSStrikethroughStyleAttributeName,
                                 value: 2,
                                 range: NSMakeRange(0, oldPrice.characters.count))
        
        return priceAttStr
    }
}
