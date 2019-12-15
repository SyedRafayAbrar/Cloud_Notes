//
//  ViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 26/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import SwiftKeychainWrapper

class LoginViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func viewDidAppear(_ animated: Bool) {
        if let _ = KeychainWrapper.standard.string(forKey: KEY_UID){
            performSegue(withIdentifier: "toMenu", sender: nil)
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func logInPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordtext.text!) { (user, error) in
            if error != nil {
                print(error!)
                let alert=UIAlertController(title: "Error", message: "\(error!)", preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordtext.text!) { (user, error) in
                    if error != nil {
                        
                        let alert=UIAlertController(title: "Error", message: "\(error!)", preferredStyle: UIAlertControllerStyle.alert)
                        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(cancel)
                        print(error!)
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        if let user = user {
                            self.completeLogin(id: user.uid)
                            DispatchQueue.main.async {
                                [unowned self] in
                                self.performSegue(withIdentifier: "toMenu", sender: self)
                            }
                        }
                
                        print("++++new User Created")
                        
                        self.present(alert, animated: true, completion: nil)
                       
                    }

                }
                
            } else {
                print("SignIn Successfully")
                DispatchQueue.main.async {
                    [unowned self] in
                    self.performSegue(withIdentifier: "toMenu", sender: self)
                    if let user = user {
                        self.completeLogin(id: user.uid)
                    }
                    
                    
                }
            }
        }
    }
    
//    func textFieldShouldReturn(textField: UITextField) -> Bool {
//        textField.resignFirstResponder()
//        return true
//    }
//    
//    
//    /**
//     * Called when the user click on the view (outside the UITextField).
//     */
//    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
//        self.view.endEditing(true)
//    }
  
    func completeLogin(id:String){
        KeychainWrapper.standard.set(id, forKey: KEY_UID)
    }
    
}

