//
//  ServerListViewController.swift
//  Windscribe Coding Challenge
//
//  Created by Deep on 2021-05-30.
//

import UIKit


class ServerListViewController: UIViewController {

    var viewModel: ServerListViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        viewModel = ServerListViewModel()
        
        viewModel?.listServers()
    }


}

