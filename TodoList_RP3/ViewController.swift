//
//  ViewController.swift
//  TodoList_RP3
//
//  Created by 이상헌 on 2021/07/18.
//

import UIKit

var list = [Todolist]()


class ViewController: UIViewController {
    
    @IBOutlet weak var checkBoxButton: UIButton!
    
    @IBOutlet weak var tableView: UITableView!
//    @IBOutlet weak var editButton: UIBarButtonItem!
//    @IBOutlet weak var searchBar: UISearchBar!
    
    var filterArr: [Todolist] = []
    
    var isFiltering: Bool {
        let searchController = self.navigationItem.searchController
        let isActive = searchController?.isActive ?? false
        let isSearchBarHasText = searchController?.searchBar.text?.isEmpty == false
        return isActive && isSearchBarHasText
    }
    
//    let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneButtonTap))
//
//    //done 버튼 tap시 수정모드 종료
//    @objc
//    func doneButtonTap(){
//        self.navigationItem.leftBarButtonItem = editButton
//        tableView.setEditing(false, animated: true)
//    }
//
    @IBAction func editButtonAction(_ sender: Any) {
        
        //리스트 비어 있을 때 return
        guard !list.isEmpty
        else{
            return
        }
        //TableView editing 모드
        if tableView.isEditing == false {
            tableView.setEditing(true, animated: true)
            (sender as? UIBarButtonItem)?.title = "Done"
        } else {
            tableView.setEditing(false, animated: true)
            (sender as? UIBarButtonItem)?.title = "Edit"
        }
    
    }
    
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        
        list.remove(at: indexPath.row)
        tableView.reloadData()
        
        }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        let searchController = UISearchController(searchResultsController: nil)
        
        searchController.searchBar.placeholder = "Search To Do"
        searchController.searchBar.scopeButtonTitles = [ "All",
            "RP", "Daily", "운동 Record"
        ]
        searchController.searchBar.showsScopeBar = true
        searchController.obscuresBackgroundDuringPresentation = true
        self.navigationItem.hidesSearchBarWhenScrolling = false
        
        self.navigationItem.searchController = searchController
        
        searchController.searchResultsUpdater = self
        
        
        
        
        //tableView 데이터 연결 시켜주기 delegate: 데이터 갯수, datasource : 데이터 행렬
        tableView.delegate = self
        tableView.dataSource = self
        
//        list.append(Todolist(title: "todo1", content: "할 일을 입력해주세요."))
//        list.append(Todolist(title: "todo2", content: "할 일을 입력해주세요."))
//        list.append(Todolist(title: "todo3", content: "할 일을 입력해주세요."))
        
//        doneButton.style = .plain
//        doneButton.target = self
//
        loadAllData()
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
    
        tableView.reloadData()
        
    }
    
    //userdefault 불러오기
    func loadAllData(){
        let userDefaults = UserDefaults.standard
        guard let data = userDefaults.object(forKey: "items") as? [[String: AnyObject]] else{ return }
        print(data.description)
        print(type(of: data))
        list = data.map {
            var title = $0["title"] as? String
            var content = $0["content"] as? String
            var isComplete = $0["isComplete"] as? Bool
            
            return Todolist(title: title!,
                            content: content!,
                            isComplete: isComplete!)
        }
    }
    
    //userdefault 저장
    func saveAllData() {
        let data = list.map{
            [
                "title" : $0.title, //0번부터 저장
                "content" : $0.content!,
                "isComplete": $0.isComplete
            ]
        }
    
    let userDefaults = UserDefaults.standard
    userDefaults.set(data, forKey: "items") //키, value 설정
    userDefaults.synchronize() //동기화
    }
    
    override func viewDidAppear(_ animated: Bool) {
        
        saveAllData()
        tableView.reloadData()
        
    }
    
    
    
    override func viewWillDisappear(_ animated: Bool) {
        
    }
        
    override func viewDidDisappear(_ animated: Bool) {
        
    }
    
    //cell 데이터 넘겨주기
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "sgDetail"{
            let cell = sender as! UITableViewCell
            let indexPath = self.tableView.indexPath(for: cell)
            
            let detailView = segue.destination as! detailViewController
            
            detailView.receiveItems(list[(indexPath! as NSIndexPath).row])
            
            detailView.selectedCell(Int(indexPath!.row))
            }
        
    }

    
    
}
extension ViewController: UITableViewDataSource, UITableViewDelegate, CheckBoxTableViewCellDelegate {
    func checkBoxToggle(sender: CheckBoxTableViewCell) {
        if let selectedIndexPath = tableView.indexPath(for: sender){
            list[selectedIndexPath.row].isComplete = !list[selectedIndexPath.row].isComplete
        
            tableView.reloadData()
            saveAllData()
            }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if isFiltering {
            return filterArr.count
        }
            return list.count
        }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell (withIdentifier: "cell", for: indexPath) as! CheckBoxTableViewCell
        
        cell.delegate = self
        
        if self.isFiltering {
            cell.nameLabel.text = self.filterArr[indexPath.row].title
        } else {
            cell.nameLabel.text = list[indexPath.row].title
        }
        cell.detailTextLabel?.text = list[indexPath.row].content
        cell.checkBoxButton.isSelected = list[indexPath.row].isComplete
        
        return cell

        }
    
}

extension ViewController: UISearchResultsUpdating{
    func updateSearchResults(for searchController: UISearchController) {
        
        guard let text = searchController.searchBar.text?.lowercased() else {return}
        self.filterArr = list.filter { $0.title.lowercased().hasPrefix(text) }
        dump(searchController.searchBar.text)
        print(filterArr)
        
        self.tableView.reloadData()
    }
}
//extension ViewController: UISearchBarDelegate{
//
//    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
//
//        filterData = []
//
//        if searchText == "" {
//
//            filterData = list
//        } else{
//
//        for todo in list {
//
//            if todo.title.lowercased().contains(searchText.lowercased()) {
//
//                filterData.append(todo)
//
//                }
//        }
//
//        }
//        tableView.reloadData()
//    }
//}

//    func tableView(_ tableView: UITableView, moveRowAt sourceIndexPath: IndexPath, to destinationIndexPath: IndexPath) {
//        <#code#>
//    }
//
    

    
 


