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


class NotesViewController: UIViewController,UITableViewDelegate {
    @IBOutlet var table: UITableView!
    var current_User:String!
    var db:Firestore!

    // DidLoad Method
    
    override func viewDidLoad() {
        super.viewDidLoad()
table.separatorColor = UIColor.red
       table.reloadData()
     db = Firestore.firestore()
        let user = Auth.auth().currentUser
        if let user = user {
            current_User = user.email
        }        // Do any additional setup after loading the view.
    }
    
    override func viewDidAppear(_ animated: Bool) {
        table.reloadData()

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
        
        
        UIApplication.shared.beginIgnoringInteractionEvents()
        db.collection("Notes").document(current_User).setData(["notes":notesArray]) { (error) in
            if let error = error {
                print(error)
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
            if let document = document {
                if let data = document.data()["notes"]! as? [String]{
                    print("++++\(data.count)")
                }
                
            } else {
                print("Document does not exist")
            }
        }
    }
    
    
    
}
extension NotesViewController:UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("NotesTableViewCell", owner: self, options: nil)?.first as! NotesTableViewCell
        tempCell.textArea.text = notesArray[indexPath.row]
        return tempCell
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 70
    }
    func textFieldShouldReturn(textField: UITextField) -> Bool {
        textField.resignFirstResponder()
        return true
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.table.endEditing(true)
    }

    
}
