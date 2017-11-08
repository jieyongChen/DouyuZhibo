//
//  HomeViewController.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

class HomeViewController: MainViewController {
    //MARK: 懒加载属性
    private lazy var pagetitleView: PageTitleView = {
        
        let frame = CGRect(x: 0, y: 0, width: kScreenW, height: 44)
        let titles = ["推荐","游戏","趣玩","我的"]
        let temp = PageTitleView(frame: frame, titles: titles)
        temp.backgroundColor = UIColor.white
        
        return temp
    }()
    
    private lazy var pageContentView: PageContentView = { [weak self] in 
        //确定frame
        let contenH = KScreenH - CGFloat(safeAreaToTop + safeAreaToBottom + 44)
        let contentFrame = CGRect(x: 0, y: 44, width: kScreenW, height: contenH)
        
        //创建所有的子控制器
        var childs: [UIViewController] = []
        childs.append(RecommendViewController())
        for _ in 0...2 {
            let vc = UIViewController()
            vc.view.backgroundColor = UIColor(red: CGFloat(arc4random_uniform(255)), green: CGFloat(arc4random_uniform(255)), blue: CGFloat(arc4random_uniform(255)))
            childs.append(vc)
        }
        let temp = PageContentView(frame: contentFrame, childVC: childs, parentVC: self)
        return temp
        
    }()

    override func viewDidLoad() {
        super.viewDidLoad()

        self.view.backgroundColor = UIColor.brown
        
        setupUI()
    }
}
//MARK: 添加子控件
extension HomeViewController {
    
    fileprivate func setupUI() {
        //不需要调整UIScrollView的内边距
        automaticallyAdjustsScrollViewInsets = false
        
        setUpNavigationBar()
        
        self.view.addSubview(pagetitleView)
        
        pagetitleView.deleagte = self
        
        self.view.addSubview(pageContentView)
        
        pageContentView.delegate = self
        
        pageContentView.backgroundColor = UIColor.red
        
    }
    //MARK: 设置navigationbarItem
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
//MARK: PagetitleView的代理方法
extension HomeViewController: PageTitleViewDeleagte {
    
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int) {
        
        self.pageContentView.setCurrentIndex(currentIndex: index)
    }
}
//MARK: PageContentView的代理方法
extension HomeViewController: PageContentViewDelegate {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, soureIndex: Int, targetIndex: Int) {
        
        self.pagetitleView.setTitleWithProgress(progress: progress, soureIndex: soureIndex, targetInde: targetIndex)
    }
}

