//
//  PageTitleView.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

let kScrollLineH: CGFloat = 3
let kNormalColor: (CGFloat,CGFloat,CGFloat) = (85,85,85)
let kSelecteColor: (CGFloat,CGFloat,CGFloat) = (255,128,0)
let kNormalFont: CGFloat = 16
let kSeleteFont: CGFloat = 24

protocol PageTitleViewDeleagte: class {
 
    func pageTitleView(titleView: PageTitleView, selectedIndex index: Int)
}

class PageTitleView: UIView {
    
    fileprivate var currentLabelIndex: Int = 0
    
    private var titles: [String]
    
    weak var deleagte: PageTitleViewDeleagte?
    //MARK: 懒加载属性
    private lazy var scrollView: UIScrollView = {
        let temp = UIScrollView()
        temp.showsHorizontalScrollIndicator = false
        temp.scrollsToTop = false
        temp.bounces = false
        return temp
    }()
    private lazy var scrollLine: UIView = {
        let temp = UIView()
        temp.backgroundColor = UIColor.orange
        return temp
    }()
    private lazy var titleLabels: [UILabel] = []
    
    init(frame: CGRect, titles: [String]) {
        
        self.titles = titles
        
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension PageTitleView {
    
    fileprivate func setupUI() {
        
        self.scrollView.frame = bounds
        
        addSubview(scrollView)
        
        setTitlelabel()
        setBottomMenuAndScrollLine()
    }
    
    private func setTitlelabel() {
        
        let labelW: CGFloat = frame.width/CGFloat(titles.count)
        let labelH: CGFloat = 44 - kScrollLineH
        let labelY: CGFloat = 0
        
        for (index, title) in titles.enumerated() {
            
            let label = UILabel()
            label.text = title
            label.tag = index
            label.font = UIFont.systemFont(ofSize: kNormalFont)
            label.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.2)
            label.textAlignment = .center
            let labelX: CGFloat = labelW * CGFloat(index)
            label.frame = CGRect(x: labelX, y: labelY, width: labelW, height: labelH)
            label.isUserInteractionEnabled = true
            let ges = UITapGestureRecognizer(target: self, action: #selector(labelTap(tap:)))
            label.addGestureRecognizer(ges)
            
            self.scrollView.addSubview(label)
            self.titleLabels.append(label)
        }
    }
    
    private func setBottomMenuAndScrollLine() {
        //添加底线
        let bottom = UIView()
        bottom.backgroundColor = UIColor.lightGray
        bottom.frame = CGRect(x: 0, y: frame.height - kScrollLineH, width: frame.width, height: kScrollLineH)
        self.addSubview(bottom)
        
        if let firstLabel = self.titleLabels.first {
            
            firstLabel.textColor = UIColor(red: kSelecteColor.0, green: kSelecteColor.1, blue: kSelecteColor.2)
            
            firstLabel.font = UIFont.systemFont(ofSize: kSeleteFont)
            
            self.addSubview(scrollLine)
            
            scrollLine.frame = CGRect(x: firstLabel.frame.origin.x, y: frame.height - kScrollLineH, width: firstLabel.frame.width, height: kScrollLineH)
        }
    }
}
//MARK: label的点击
extension PageTitleView {
    
    @objc fileprivate func labelTap(tap: UITapGestureRecognizer) {
        //获取当前label的下标值
         guard let currenlabel = tap.view as? UILabel else { return }
        
        //获取之前的label
        let oldLabel = self.titleLabels[currentLabelIndex]
        
        //切换label的颜色
        oldLabel.textColor = UIColor(red: kNormalColor.0, green: kNormalColor.1, blue: kNormalColor.1)
        currenlabel.textColor = UIColor(red: kSelecteColor.0, green: kSelecteColor.1, blue: kSelecteColor.2)
        
        UIView.animate(withDuration: 0.3) {
            oldLabel.font = UIFont.systemFont(ofSize: kNormalFont)
            currenlabel.font = UIFont.systemFont(ofSize: kSeleteFont)
        }
        
        //保存最新的label的下标
        self.currentLabelIndex = currenlabel.tag
        
        //滚动条位置发生改变
        let scrollLineX = CGFloat(currenlabel.tag) * scrollLine.frame.width
        
        UIView.animate(withDuration: 0.15) {
            self.scrollLine.frame.origin.x = scrollLineX
        }
        //通知代理
        deleagte?.pageTitleView(titleView: self, selectedIndex: currentLabelIndex)
    }
}

//MARK: 暴露给外部的方法
extension PageTitleView {
    
    func setTitleWithProgress(progress: CGFloat, soureIndex: Int, targetInde: Int) {
        //取出需要处理的label
        let soureLabel = titleLabels[soureIndex]
        let targetLabel = titleLabels[targetInde]
        
        //处理滑动逻辑
        let moveX = targetLabel.frame.origin.x - soureLabel.frame.origin.x
        
        let moveLenth = moveX * progress
        
        scrollLine.frame.origin.x = soureLabel.frame.origin.x + moveLenth
        
        let colorDiffence = (kSelecteColor.0 - kNormalColor.0,kSelecteColor.1 - kNormalColor.1,kSelecteColor.2 - kNormalColor.2)
        
        soureLabel.textColor = UIColor(red: kSelecteColor.0 - colorDiffence.0 * progress, green: kSelecteColor.1 - colorDiffence.1 * progress, blue: kSelecteColor.2 - colorDiffence.2 * progress)
        targetLabel.textColor = UIColor(red: kNormalColor.0 + colorDiffence.0 * progress, green: kNormalColor.1 + colorDiffence.1 * progress, blue: kNormalColor.2 + colorDiffence.2 * progress)
        
        soureLabel.font = UIFont.systemFont(ofSize: kSeleteFont - (kSeleteFont-kNormalFont) * progress)
        targetLabel.font = UIFont.systemFont(ofSize: kNormalFont + (kSeleteFont-kNormalFont) * progress)
        
        currentLabelIndex = targetInde
        
    }
}
