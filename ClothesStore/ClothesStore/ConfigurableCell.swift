//
//  ConfigurableCell.swift
//  ClothesStore
//
//  Created by Kyle Davidson on 06/12/2016.
//  Copyright © 2016 Kyle Davidson. All rights reserved.
//

import Foundation

protocol ConfigurableCell {
    associatedtype Object
    func configure(forObject object: Object)
}
