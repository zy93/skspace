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

//H5地址
@property (nonatomic,copy) NSString *url;
@property (nonatomic,copy) NSString *titleStr;
@property (nonatomic,copy) NSString *infoStr;

+(WOTH5VC *)loadH5VC;


@end
