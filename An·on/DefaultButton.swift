//
//  DefaultButton.swift
//  An·on
//
//  Created by Daniel Travers on 01/08/2017.
//  Copyright © 2017 Daniel Travers. All rights reserved.
//

import UIKit

class DefaultButton: UIButton {

    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 35.0
        clipsToBounds = true
        
    }
    
    

}
