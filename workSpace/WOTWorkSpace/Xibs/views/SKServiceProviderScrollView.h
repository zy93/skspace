//
//  SKServiceProviderScrollView.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/2/8.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^ImageBlock)(NSInteger tap);
@interface SKServiceProviderScrollView : UIScrollView
@property (nonatomic,copy)  ImageBlock imageBlock;
-(void)setData:(NSArray *)facilitatorData;
@end
