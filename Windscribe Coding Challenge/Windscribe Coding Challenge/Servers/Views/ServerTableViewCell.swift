//
//  ServerTableViewCell.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import UIKit

class ServerTableViewCell: UITableViewCell {
    
    
    let cellView: UIView = {
        let view = UIView()
        view.backgroundColor = .blue
        view.layer.cornerRadius = 10
        view.translatesAutoresizingMaskIntoConstraints = false
        return view
    }()
        
    let groupLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 14)
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    
    let hostNameLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    
    let ipLabel: UILabel = {
        let label = UILabel()
        label.textColor = UIColor.white
        label.font = UIFont.boldSystemFont(ofSize: 12)
        label.translatesAutoresizingMaskIntoConstraints = false
            
        return label
    }()
    

    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        self.accessoryType = .disclosureIndicator
        self.tintColor = .white
        setupCellView()
    }
        
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func setupCellView() {

        addSubview(cellView)
        cellView.addSubview(groupLabel)
        cellView.addSubview(hostNameLabel)
        cellView.addSubview(ipLabel)
        
        self.selectionStyle = .none
            
        NSLayoutConstraint.activate([
            cellView.topAnchor.constraint(equalTo: self.topAnchor, constant: 20),
            cellView.rightAnchor.constraint(equalTo: self.rightAnchor, constant: -10),
            cellView.leftAnchor.constraint(equalTo: self.leftAnchor, constant: 10),
            cellView.bottomAnchor.constraint(equalTo: self.bottomAnchor)
        ])
       
        NSLayoutConstraint.activate([
            groupLabel.heightAnchor.constraint(equalToConstant: 200),
            groupLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -25),
            groupLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            hostNameLabel.heightAnchor.constraint(equalToConstant: 200),
            hostNameLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: -5),
            hostNameLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
            ipLabel.heightAnchor.constraint(equalToConstant: 200),

            ipLabel.centerYAnchor.constraint(equalTo: cellView.centerYAnchor, constant: 15),
            ipLabel.leftAnchor.constraint(equalTo: cellView.leftAnchor, constant: 20),
            
        ])
   }
    
    func setup(node: Node) {
        
        groupLabel.text = node.group
        hostNameLabel.text = node.hostname
        ipLabel.text = node.ip
    }
}
