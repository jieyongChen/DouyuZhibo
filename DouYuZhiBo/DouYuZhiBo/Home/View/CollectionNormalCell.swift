//
//  CollectionNormalCell.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/8.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

class CollectionNormalCell: UITableViewCell {
    
    private lazy var showImageView: UIImageView? = {
        let temp = UIImageView()
        return temp
        
    }()
    
    private lazy var iconImageView: UIImageView? = {
        let temp = UIImageView()
        return temp
    }()

    override init(style: UITableViewCellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
