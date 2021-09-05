//
//  CheckBoxTableViewCell.swift
//  TodoList_RP3
//
//  Created by 이상헌 on 2021/07/20.
//

import UIKit

protocol CheckBoxTableViewCellDelegate {
    func checkBoxToggle(sender: CheckBoxTableViewCell)
}


class CheckBoxTableViewCell: UITableViewCell {

    var delegate: CheckBoxTableViewCellDelegate?
    
    @IBOutlet weak var checkBoxButton: UIButton!
    @IBOutlet weak var nameLabel: UILabel!
    
    @IBAction func checkToggled(_ sender: UIButton) {
        delegate?.checkBoxToggle(sender: self)
    }
    
}
