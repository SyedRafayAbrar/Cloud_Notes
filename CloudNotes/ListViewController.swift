//
//  ListViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 26/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit

class ListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var listTable: UITableView!
    @IBOutlet var addList: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        listTable.reloadData()
    }
    
    
    @IBAction func AddListPressed(_ sender: Any) {
        todoArray.append(addList.text!)
        listTable.reloadData()
    }
    
    @IBAction func homePressed(_ sender: Any) {
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

    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        addList.resignFirstResponder()
        self.view.endEditing(true)
    }

}
extension UIViewController {
    func hideKeyboardWhenTappedAround() {
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(UIViewController.dismissKeyboard))
        tap.cancelsTouchesInView = false
        view.addGestureRecognizer(tap)
    }
    
    
    @objc func dismissKeyboard() {
        
  self.view.endEditing(true)
    }
}

extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return todoArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("ListTableViewCell", owner: self, options: nil)?.first as! ListTableViewCell
tempCell.cellLabel.text = todoArray[indexPath.row]
        return tempCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 50
    }

    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
 
}
