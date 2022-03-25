//
//  OptionVC.swift
//  Demo
//
//  Created by Shivam Verma on 14/09/21.
//

import UIKit

protocol OptionVCInputs: AnyObject {
    func configure()
}

protocol OptionVCOutputs: AnyObject {
    func viewDidLoad()
    func popWithSelectedItems(selectedItems:[Options])
}

class OptionVC: UIViewController {

    let arryOfStr:[Options] = [.album,.artist,.book, .movie, .musicVideo, .podcast, .song]
    var selectedItems:[Options] = Array()
    var presenter:OptionVCOutputs?
    
    @IBOutlet weak var tblView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        presenter?.viewDidLoad()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(true)
        presenter?.popWithSelectedItems(selectedItems:selectedItems)
    }
}

extension OptionVC:OptionVCInputs
{
    func configure() {
        tblView.delegate = self
        tblView.dataSource = self
        let v = UIView(frame: tblView.frame)
        v.backgroundColor = .black
        tblView.backgroundView = v
        tblView.separatorColor = .white
        self.view.backgroundColor = .black
        tblView.tableFooterView = UIView(frame: .zero)
        self.tblView.allowsMultipleSelection = true
        self.tblView.allowsMultipleSelectionDuringEditing = true
    }
}

extension OptionVC: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arryOfStr.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let obj = arryOfStr[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell") as! OptionCell
        cell.textLabel?.text = obj.rawValue
        cell.textLabel?.textColor = .white
        cell.backgroundColor = .black
        cell.selectionStyle = .none
        if self.selectedItems.contains(obj)
        {
            cell.accessoryType = .checkmark
        }
        else
        {
            cell.accessoryType = .none
        }
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let cell = tableView.cellForRow(at: indexPath)
        
        if cell!.isSelected
        {
            if cell!.accessoryType == .none
            {
                cell?.setSelected(true, animated: true)
                cell!.accessoryType = .checkmark
                selectedItems.append(arryOfStr[indexPath.row])
            }
            else
            {
                cell?.setSelected(false, animated: true)
                selectedItems.removeAll { obj in
                    return obj == arryOfStr[indexPath.row]
                }
                cell!.accessoryType = .none
            }
        }
    }
}


class OptionCell: UITableViewCell {
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }

    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
}
