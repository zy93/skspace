//
//  WOTRefreshControlUitls.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/8/1.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTRefreshControlUitls.h"

@implementation WOTRefreshControlUitls


-(instancetype)initWithScroll:(UIScrollView *)scroll;{
    self=[super init];
    if (self) {

        self.commonRefresh = [[WOTConciseRefreshControl alloc]initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 100)];
        [self.commonRefresh attachToScrollView:scroll];
        
        
    }
    return self;
}


- (void)addTarget:(nullable id)target action:(SEL)action forControlEvents:(UIControlEvents)controlEvents;{

        [self.commonRefresh addTarget:target action:action forControlEvents:controlEvents];
  
}

-(void)stop{

    [self.commonRefresh endRefreshing];
    
}

@end
