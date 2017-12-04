//
//  UItableView+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UItableView+Extension.h"


@implementation UITableView(Extension)

-(void)layoutConstraintsToView:(UIView *)superview{
    [self mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.top.mas_equalTo(superview);
        maker.left.mas_equalTo(superview);
        maker.right.mas_equalTo(superview);
        maker.bottom.mas_equalTo(superview);
        
    }];
}

@end
