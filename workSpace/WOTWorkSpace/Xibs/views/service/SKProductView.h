//
//  SKProductView.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 26/6/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SKProductView : UIView
@property (nonatomic, strong) UIImageView * topIV;
@property (nonatomic, strong) UIImageView * iconIV;
@property (nonatomic, strong) UILabel   *titleLab;
@property (nonatomic, strong) UILabel   *priceLab;

@end
