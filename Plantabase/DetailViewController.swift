//
//  DetailViewController.swift
//  Plantabase
//
//  Created by Shovkovy on 4/12/20.
//  Copyright © 2020 Shovkovy. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    var selectedItem:item?
    
    @IBOutlet weak var itemName: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        itemName.text = selectedItem?.itemName

        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
