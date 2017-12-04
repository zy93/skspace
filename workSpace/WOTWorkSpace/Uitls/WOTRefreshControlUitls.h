//
//  WOTRefreshControlUitls.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/1.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//




#import "WOTConciseRefreshControl.h"


@interface WOTRefreshControlUitls : NSObject
@property(nonatomic,strong) WOTConciseRefreshControl * _Nullable commonRefresh;


-(instancetype _Nullable )initWithScroll:(UIScrollView *_Nullable)scroll;
-(void)stop;

-(void)addTarget:(nullable id)target action:(SEL _Nullable )action forControlEvents:(UIControlEvents)controlEvents;
@end
