//
//  WOTServiceProvidersCategoryVC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTServiceProvidersCategoryVC : UIViewController
@property (nonatomic, strong) NSArray *selectServiceList;
@property (nonatomic,strong)void(^selectServiceBlock)(NSArray *);

@end
