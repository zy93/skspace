//
//  WOTH5VC.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTH5VC : UIViewController
@property (weak, nonatomic) IBOutlet UIWebView *web;

//直接打开H5
@property (nonatomic, strong) NSString *url;
@end
