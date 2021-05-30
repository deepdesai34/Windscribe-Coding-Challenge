//
//  ServerListViewController.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import UIKit


class ServerListViewController: UIViewController {

    var viewModel: ServerListViewModel?
    weak var tableview: UITableView?
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ServerListViewModel()
        viewModel?.view = self
        viewModel?.listServers()
    }
    
    open func setupViews() {
        let tableview: UITableView = {
             let table = UITableView()
             table.backgroundColor = UIColor.white
             table.translatesAutoresizingMaskIntoConstraints = false
             return table
         }()
        
        tableview.register(UITableViewCell.self, forCellReuseIdentifier: "cellId")
            
        view.addSubview(tableview)
            
        NSLayoutConstraint.activate([
            tableview.topAnchor.constraint(equalTo: self.view.topAnchor),
            tableview.bottomAnchor.constraint(equalTo: self.view.bottomAnchor),
            tableview.rightAnchor.constraint(equalTo: self.view.rightAnchor),
            tableview.leftAnchor.constraint(equalTo: self.view.leftAnchor)
        ])
        
        tableview.delegate = self
        tableview.dataSource = self
        
        self.tableview = tableview
    }
    
}

extension ServerListViewController: UITableViewDelegate,  UITableViewDataSource {
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return viewModel?.listOfLocations.count ?? 0
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return viewModel?.listOfLocations[section].nodes.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        
        return viewModel?.listOfLocations[section].name
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
//        let cell = self.tableview?.dequeueReusableCell(withIdentifier: "cellId", for: indexPath)
        
        let cell = UITableViewCell(style: .default, reuseIdentifier: "cellId")
        cell.backgroundColor = UIColor.white
        return cell
    }
    
   
    
    
}

