//
//  StarterViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 29/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import SwiftKeychainWrapper

class StarterViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    @IBAction func LogoutPressed(_ sender: Any) {
        let keychainresult = KeychainWrapper.standard.removeObject(forKey: KEY_UID)
        try! Auth.auth().signOut()
        dismiss(animated: true, completion: nil)
        
    }
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
