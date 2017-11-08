//
//  PageContentView.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit
private let contenCellId = "contenCellId"

protocol PageContentViewDelegate: class {
    
    func pageContentView(contentView: PageContentView, progress: CGFloat, soureIndex: Int, targetIndex: Int)
}

class PageContentView: UIView {
    
    private var childvcs: [UIViewController]
    fileprivate weak var parentVC: UIViewController?
    fileprivate var startoffSetX: CGFloat = 0
    weak var delegate: PageContentViewDelegate?
    var isForbidScrollDeleage: Bool = false
    //MARK: 懒加载属性
    fileprivate lazy var collectionView: UICollectionView = { [weak self] in
        
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = (self?.bounds.size)!
        layout.minimumLineSpacing = 0
        layout.minimumInteritemSpacing = 0
        layout.scrollDirection = .horizontal
        
        let temp = UICollectionView(frame: .zero, collectionViewLayout: layout)
        temp.showsHorizontalScrollIndicator = false
        temp.bounces = false
        temp.isPagingEnabled = true
        temp.register(UICollectionViewCell.self, forCellWithReuseIdentifier: contenCellId)
        
        return temp
    }()
    
    init(frame: CGRect, childVC: [UIViewController], parentVC: UIViewController?) {
        self.childvcs = childVC
        self.parentVC = parentVC
        
        super.init(frame: frame)
        
        setupUI()
    }
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
}
//设置子控件
extension PageContentView {
    
    fileprivate func setupUI() {
        for child in self.childvcs {
            
           parentVC?.addChildViewController(child)
        }
        addSubview(collectionView)
        collectionView.frame = bounds
        collectionView.dataSource = self
        collectionView.delegate = self
    }
}
//MARK: UICollextionView的代理方法及代理方法
extension PageContentView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return childvcs.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: contenCellId, for: indexPath)
        
        for view in cell.contentView.subviews {
            
            view.removeFromSuperview()
        }
        
        let vc = childvcs[indexPath.row]
        vc.view.frame = cell.contentView.bounds
        cell.contentView.addSubview(vc.view)
        
        return cell
    }
    
    func scrollViewWillBeginDragging(_ scrollView: UIScrollView) {
        startoffSetX = scrollView.contentOffset.x
        
        isForbidScrollDeleage = false
    }
    
    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        
        if isForbidScrollDeleage { return }
        
        var progress: CGFloat = 0
        var sourceIndex: Int = 0
        var targetIndex: Int = 0
    
        //判断左滑右滑
        let currentoffSetx = scrollView.contentOffset.x
        if currentoffSetx > startoffSetX {
            //左滑
            progress = currentoffSetx/scrollView.frame.width - floor(currentoffSetx/scrollView.frame.width)
                //(currentoffSetx - startoffSetX)/scrollView.frame.width
            
            sourceIndex = Int(currentoffSetx/scrollView.frame.width)
            
            targetIndex = sourceIndex + 1
            
            if targetIndex >= childvcs.count {
                
                progress = 1
                
                targetIndex = childvcs.count - 1
            }
            
            if currentoffSetx - startoffSetX == scrollView.frame.width {
                
                progress = 1
                
                targetIndex = sourceIndex
            }
            
        } else {
            //右滑
            progress = 1 - (currentoffSetx/scrollView.frame.width - floor(currentoffSetx/scrollView.frame.width))
                //(startoffSetX - currentoffSetx)/scrollView.frame.width
            
            targetIndex = Int(currentoffSetx/scrollView.frame.width)
            
            sourceIndex = targetIndex + 1
            
            if sourceIndex >= childvcs.count {
                sourceIndex = childvcs.count - 1
            }
        }
        
        self.delegate?.pageContentView(contentView: self, progress: progress, soureIndex: sourceIndex, targetIndex: targetIndex)
        
        print("progress:\(progress), soureIndex:\(sourceIndex), targetIndex:\(targetIndex)")
    }
}
//MARK: 暴露给外部的方法
extension PageContentView {
    
    func setCurrentIndex(currentIndex: Int) {
        
        isForbidScrollDeleage = true
        
        let offset = CGFloat(currentIndex) * collectionView.frame.width
        
        collectionView.setContentOffset(CGPoint(x: offset, y: 0)  , animated: true)
        
    }
}
