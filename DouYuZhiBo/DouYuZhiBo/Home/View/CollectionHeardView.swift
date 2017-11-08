//
//  CollectionHeardView.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/8.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit
import SnapKit

class CollectionHeardView: UICollectionReusableView {
    
    private lazy var imageIView: UIImageView = {
        let temp = UIImageView()
        temp.image = #imageLiteral(resourceName: "Game_Highlighted")
        temp.sizeToFit()
        return temp
    }()
    
    private lazy var titleLabel: UILabel = {
        let temp = UILabel()
        temp.text = "颜值"
        temp.textAlignment = .left
        return temp
    }()
    private lazy var moreBtn: UIButton = {
        let temp = UIButton()
        temp.setTitle("更多>", for: .normal)
        temp.sizeToFit()
        return temp
    }()
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setupUI()
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}

extension CollectionHeardView {
    
    fileprivate func setupUI() {
        
        self.addSubview(imageIView)
        self.addSubview(titleLabel)
        self.addSubview(moreBtn)
        
        imageIView.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalToSuperview().offset(10)
        }
        titleLabel.snp.makeConstraints {
            $0.centerY.equalToSuperview()
            $0.left.equalTo(imageIView.snp.right).offset(5)
            $0.width.equalTo(50)
        }
        moreBtn.snp.makeConstraints {
            $0.right.equalToSuperview().offset(-10)
            $0.centerY.equalToSuperview()
        }
    }
}
