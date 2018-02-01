//
//  NotesViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 26/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import FirebaseAuth
import Firebase
import RealmSwift



class NotesViewController: UIViewController,UITableViewDelegate {
  
    @IBOutlet var blurView: UIVisualEffectView!
    @IBOutlet var viewLeading: NSLayoutConstraint!
    @IBOutlet var cellEditClassView: UITextView!
    @IBOutlet var cellEditView: UIView!
    @IBOutlet var table: UITableView!
    var dataContain:[String]!
    var current_User:String!
    var db:Firestore!
    var realmNotes:Results<Notes>!
    var sections=["Fetched","Stored"]
    var notes = [String]()
    // DidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
viewLeading.constant = -315
        blurView.layer.cornerRadius = 15
     db = Firestore.firestore()
       tableFormat()
        getUser()
        gettingFromRealm()
        
        
        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()
gettingFromRealm()
    }

    @IBAction func AddNotes(_ sender: Any) {
    }
    @IBAction func homePressed(_ sender: Any) {
        dismiss(animated: true, completion: nil)
    }
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func syncPressed(_ sender: Any) {
        
        for i in 0...realmNotes.count-1 {
            notes.append(realmNotes[i]._Notes!)
  }
        
        db.collection("Notes").document(current_User).setData(["notes":notes]) { (error) in
            if let error = error {
                print("++++++\(error)")
            }
        }
     
    
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */
    @IBAction func fetchPressed(_ sender: Any) {
        let docRef = db.collection("Notes").document(current_User)
        
        docRef.getDocument { (document, error) in
            if document?.exists == true{
            if let document = document {
                if let data = document.data()["notes"]! as? [String]{
                   
                    for i in 0...data.count-1 {
                    let notesObj = Notes()
                    notesObj._Notes = data[i]
                    notesObj.writeRealm()
                        self.table.reloadData()
                }
                }
                
            } else {
                print("Document does not exist")
            }
            } else {
                let alert = UIAlertController(title: "Error", message: "Document Not Exist", preferredStyle: UIAlertControllerStyle.alert)
                let cancel = UIAlertAction(title: "Ok", style: .cancel, handler: nil)
                alert.addAction(cancel)
                self.present(alert, animated: true, completion: nil)
            }
        }
    }
    
    func getUser(){
        let user = Auth.auth().currentUser
        if let user = user {
            current_User = user.email
        }
    }
    
    func tableFormat(){
        table.separatorColor = UIColor.red
        table.reloadData()
        
    }
    
    func gettingFromRealm(){
        realmNotes = uiRealm.objects(Notes.self)
        self.table.reloadData()
    }
    
    
    @IBAction func updateCell(_ sender: Any) {
        viewLeading.constant = -315
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded() })
    }
    
}// end View Controller


extension NotesViewController:UITableViewDataSource{
   
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       
        if section == 0 {
            if dataContain != nil {
                
                return dataContain.count
                
            } else {
                return 0
            }
        } else {
            if realmNotes != nil {
                return realmNotes.count
                
            } else {
                return 0
            }
        }
       
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("NotesTableViewCell", owner: self, options: nil)?.first as! NotesTableViewCell
        tempCell.textArea.text = realmNotes[indexPath.row]._Notes
        return tempCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! uiRealm.write {
                uiRealm.delete(realmNotes[indexPath.row])
            }
            table.reloadData()
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        viewLeading.constant = 0
        UIView.animate(withDuration: 0.3, animations: {
            self.view.layoutIfNeeded() })
            cellEditClassView.text = realmNotes[indexPath.row]._Notes
        
    }

}
