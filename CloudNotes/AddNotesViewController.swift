//
//  AddNotesViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 28/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class AddNotesViewController: UIViewController {
    @IBOutlet var textArea: UITextView!
    @IBOutlet var blur: UIVisualEffectView!
    override func viewDidLoad() {
        super.viewDidLoad()
blur.layer.cornerRadius = 15
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func AddPressed(_ sender: Any) {
        notesArray.append(textArea.text)
        if textArea.text != nil {
            dismiss(animated: true, completion: nil)
        }else{
            let alert = UIAlertController(title: "Error", message: "Text Area is Emplty", preferredStyle: UIAlertControllerStyle.alert)
            let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
            alert.addAction(cancel)
            self.present(alert, animated: true, completion: nil)
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
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
