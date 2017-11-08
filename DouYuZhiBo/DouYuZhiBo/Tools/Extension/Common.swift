//
//  Common.swift
//  DouYuZhiBo
//
//  Created by MrChen on 2017/11/7.
//  Copyright © 2017年 MrChen. All rights reserved.
//

import UIKit

let kScreenW: CGFloat = UIScreen.main.bounds.width
let KScreenH: CGFloat = UIScreen.main.bounds.height

/*
 iphoneX特殊设置
 */
//判断是否是iPhoneX
let is_iPhoneX = (kScreenW == 375 && KScreenH == 812) ? true : false

//状态栏的高度
let statusbarHeight = is_iPhoneX ? 44 : 20

//安全区距离top的高度
let safeAreaToTop = is_iPhoneX ? (44 + 44) : (44 + 20)

//iPhoneX底部空白高度
let iPhoneBottom = is_iPhoneX ? 34 : 0

//安全区bottom距离底部的高度
let safeAreaToBottom = is_iPhoneX ? (49 + 34) : 49


