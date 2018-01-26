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
class ViewController: UIViewController {

    @IBOutlet var emailText: UITextField!
    @IBOutlet var passwordtext: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


    @IBAction func logInPressed(_ sender: Any) {
        Auth.auth().signIn(withEmail: emailText.text!, password: passwordtext.text!) { (user, error) in
            if error != nil {
                print(error!)
                Auth.auth().createUser(withEmail: self.emailText.text!, password: self.passwordtext.text!) { (user, error) in
                    if error != nil {
                        let alert=UIAlertController(title: "Error", message: "Password Shold be 6 or more than 6 characters", preferredStyle: UIAlertControllerStyle.alert)
                        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(cancel)
                        print(error!)
                        self.present(alert, animated: true, completion: nil)
                    }else {
                        let alert=UIAlertController(title: "Done!", message: "UserCreation Succeeded", preferredStyle: UIAlertControllerStyle.alert)
                        let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                        alert.addAction(cancel)
                        print("++++new User Created")
                        self.present(alert, animated: true, completion: nil)
                        self.performSegue(withIdentifier: "toList", sender: self)
                    }

                }
                
            } else {
                let alert=UIAlertController(title: "Done!", message: "SignIn Succeeded", preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
                DispatchQueue.main.async {
                    [unowned self] in
                    self.performSegue(withIdentifier: "toList", sender: self)
                }
            }
        }
    }
    
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
  
}

