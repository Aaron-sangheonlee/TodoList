//
//  listViewController.swift
//  TodoList_RP3
//
//  Created by 이상헌 on 2021/07/18.
//

import UIKit

class listViewController: UIViewController {

    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBAction func addListItemAction(_ sender: Any) {
        
        let title = titleTextField.text!
        let content = contentTextView.text! ?? ""
        
        //Done 버튼 클릭되었을 때 list에 데이터가 append
        let item: Todolist = Todolist(title: title, content: content)
        
        //객체 생성 확인 로그
        print("Add List title : \(item.title)")
        
        //ViewController에 생성한 전역변수에 append
        list.append(item)
        
        //리스트 화면으로 돌아가기
        self.navigationController?.popViewController(animated: true)
    }
    
    @IBAction func cancel(_ sender: Any) {
        self.navigationController?.popViewController(animated: true)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleTextField.layer.cornerRadius = 10
        titleTextField.layer.borderColor = UIColor.gray.cgColor
        titleTextField.layer.borderWidth = 1.5
        
        contentTextView.layer.borderColor = UIColor.gray.cgColor
        contentTextView.layer.borderWidth = 1.5 //테두리 두께
        contentTextView.layer.cornerRadius = 10 // 모서리 둥글게
        contentTextView.clipsToBounds = true
        
        
        
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
