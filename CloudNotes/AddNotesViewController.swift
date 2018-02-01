//
//  AddNotesViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 28/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import RealmSwift

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

            let notesObj = Notes()
            notesObj._Notes = textArea.text!
            notesObj.writeRealm()
        
        notesArray.append(textArea.text!)
            dismiss(animated: true, completion: nil)
       
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    

    
}
