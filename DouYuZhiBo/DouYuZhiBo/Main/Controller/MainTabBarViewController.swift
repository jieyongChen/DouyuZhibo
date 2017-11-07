//
//  MainTabBarViewController.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        //添加子控制器
        addChildVc(storyBoardName: "Home")
        addChildVc(storyBoardName: "Follow")
        addChildVc(storyBoardName: "Live")
        addChildVc(storyBoardName: "Profile")
    }
    
    private func addChildVc(storyBoardName: String) {
        //1.通过storyboard获取控制器
        let childVC = UIStoryboard(name: storyBoardName, bundle: nil).instantiateInitialViewController()!
        //2.将childVC设置为子控制器
        addChildViewController(childVC)
    }
}
