//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

class HomeViewController: MainViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.orange
        
        setUpNavigationBar()
    }
    
    private func setUpNavigationBar() {
        
        let size = CGSize(width: 40, height: 40)
        //历史按钮
        let historyBtn = UIButton(type: .detailDisclosure)
        historyBtn.frame = CGRect(origin: .zero, size: size)
        let historyItem = UIBarButtonItem(customView: historyBtn)
        
        //搜索按钮
        let searchBtn = UIButton(type: .contactAdd)
        searchBtn.frame = CGRect(origin: .zero, size: size)
        let searchItem = UIBarButtonItem(customView: searchBtn)
        
        //二维码按钮
        let qrcodeBtn = UIButton(type: .infoLight)
        qrcodeBtn.frame = CGRect(origin: .zero, size: size)
        let qrcodeItem = UIBarButtonItem(customView: qrcodeBtn)
        
        self.navigationItem.rightBarButtonItems = [historyItem, searchItem, qrcodeItem]
        
    }
}
