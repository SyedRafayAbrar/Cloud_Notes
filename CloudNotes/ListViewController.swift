//
//  ListViewController.swift
//  CloudNotes
//
//  Created by Syed  Rafay on 26/01/2018.
//  Copyright © 2018 Syed  Rafay. All rights reserved.
//

import UIKit
import RealmSwift

class ListViewController: UIViewController, UITableViewDelegate {
    @IBOutlet var listTable: UITableView!
    @IBOutlet var addList: UITextField!
    var realmList:Results<List>!
    override func viewDidLoad() {
        super.viewDidLoad()
gettingFromRealm()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    override func viewDidAppear(_ animated: Bool) {
        listTable.reloadData()
        gettingFromRealm()
    }
    
    
    @IBAction func AddListPressed(_ sender: Any) {
        let ListObj = List()
        ListObj._List = addList.text!
        ListObj.writeRealm()
        
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


    
    func gettingFromRealm(){
        realmList = uiRealm.objects(List.self)
        self.listTable.reloadData()
    }

}


extension ListViewController:UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if realmList != nil {
            return realmList.count
        } else {
            return 0
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let tempCell = Bundle.main.loadNibNamed("ListTableViewCell", owner: self, options: nil)?.first as! ListTableViewCell
tempCell.cellLabel.text = realmList[indexPath.row]._List
        return tempCell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 65
    
    }

    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            try! uiRealm.write {
                uiRealm.delete(realmList[indexPath.row])
            }
            listTable.reloadData()
        }
    }
    
    
    /**
     * Called when the user click on the view (outside the UITextField).
     */
 
}
