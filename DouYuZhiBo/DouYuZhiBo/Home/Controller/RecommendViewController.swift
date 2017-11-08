//
//  RecommendViewController.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/8.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

private let kItemMargin: CGFloat = 10
private let kItemWidth: CGFloat = (kScreenW - 3 * kItemMargin)/2
private let kItemHeight: CGFloat = kItemWidth * 0.8
private let kNormalCellId = "kNormalCellId"
private let kCollectionHeardH: CGFloat = 44
private let kReusableCellID = "kReusableCellID"

class RecommendViewController: MainViewController {
    
    private lazy var collectionView: UICollectionView = { [weak self] in
        //1.创建布局
        let layout = UICollectionViewFlowLayout()
        layout.itemSize = CGSize(width: kItemWidth, height: kItemHeight)
        layout.minimumLineSpacing = 2
        layout.minimumInteritemSpacing = kItemMargin
        layout.headerReferenceSize = CGSize(width: kScreenW, height: kCollectionHeardH)
        layout.sectionInset = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 10)
        
        //2.创建collectionView
        let temp = UICollectionView(frame: (self?.view.bounds)!, collectionViewLayout: layout)
        temp.backgroundColor = UIColor.blue
        return temp

    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.backgroundColor = UIColor.red
        
        setupUI()

    }
}
extension RecommendViewController {
    
    fileprivate func setupUI() {
        
        collectionView.autoresizingMask = [.flexibleHeight,.flexibleWidth]
        
        collectionView.dataSource = self
        collectionView.register(UICollectionViewCell.self, forCellWithReuseIdentifier: kNormalCellId)
        collectionView.register(CollectionHeardView.self, forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: kReusableCellID)
        
        self.view.addSubview(collectionView)
        
    }
}

extension RecommendViewController: UICollectionViewDataSource {
    
    func numberOfSections(in collectionView: UICollectionView) -> Int {
        
        return 12
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if section == 0 { return 8 }
        
        return 4
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: kNormalCellId, for: indexPath)
        
        cell.backgroundColor = UIColor.purple
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, at indexPath: IndexPath) -> UICollectionReusableView {
        let heardView = collectionView.dequeueReusableSupplementaryView(ofKind: kind, withReuseIdentifier: kReusableCellID, for: indexPath)
        
        heardView.backgroundColor = UIColor.green
        
        return heardView
    }
}
