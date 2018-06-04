//
//  SKBookStationVC.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTPageMenuParentVC.h"

@protocol SKBookStationVCDelegate<NSObject>

-(void)questSpaceList:(NSString *)name;

@end

@interface SKBookStationVC : WOTPageMenuParentVC

@property(nonatomic,weak)id <SKBookStationVCDelegate> delegate;

@end
