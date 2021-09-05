//
//  detailViewController.swift
//  TodoList_RP3
//
//  Created by 이상헌 on 2021/07/19.
//

import UIKit

class detailViewController: UIViewController {

    
    @IBOutlet weak var titleItem: UITextField!
    @IBOutlet weak var tvContent: UITextView!
    
    @IBOutlet weak var contentItem: UITextView!
    
    @IBOutlet weak var tfTitle: UITextField!
    var receiveItem: Todolist?
    var cellNum : Int = 0
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tfTitle.text = receiveItem?.title
        tvContent.text = receiveItem?.content
    
        // Do any additional setup after loading the view.
    }
    
    func receiveItems(_ item: Todolist){
        
        receiveItem = item
        
    }
    
    func selectedCell(_ num: Int){
        
        cellNum = num
        
    }
    @IBAction func doneButtonAction(_ sender: Any) {
        
        let title = tfTitle.text!
        let content = tvContent.text!
        
        let item: Todolist = Todolist(title: title, content: content)
        
        list[cellNum] = (item)
        
        self.navigationController?.popViewController(animated: true)
        
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
