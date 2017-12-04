//
//  WOTPhotosBaseUtils.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/18.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
@interface WOTPhotosBaseUtils : NSObject

@property(nonatomic,strong)UIViewController *vc;
@property(nonatomic,assign)BOOL onlyOne;
-(void)showSelectedPhotoSheet;
@end
