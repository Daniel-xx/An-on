//
//  DefaultTextFields.swift
//  An·on
//
//  Created by Daniel Travers on 01/08/2017.
//  Copyright © 2017 Daniel Travers. All rights reserved.
//

import UIKit

class DefaultTextFields: UITextField {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.borderColor = UIColor.gray.cgColor
        layer.borderWidth = 0
        layer.backgroundColor = UIColor.gray.cgColor
        
    }
    

    
  }
