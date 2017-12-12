//
//  WOTServiceForProvidersCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WOTServiceProvidersView.h"

@interface WOTServiceForProvidersCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIScrollView *providersScrollView;

-(void)setData:(NSInteger)da;

@end
