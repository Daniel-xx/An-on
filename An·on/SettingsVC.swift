//
//  SettingsVC.swift
//  An·on
//
//  Created by Daniel Travers on 02/08/2017.
//  Copyright © 2017 Daniel Travers. All rights reserved.
//

import UIKit
import SwiftKeychainWrapper
import Firebase

class SettingsVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    @IBAction func signOutPressed(_ sender: Any) {
        KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        print("DAN: Key Removed from Keychain")
        try! Auth.auth().signOut()
        print("DAN: FIR LOGGED OUT")
        performSegue(withIdentifier: "signOut", sender: nil)
        
    }
    

}
