//
//  WOTMapCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/11.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SKSapceLocationView.h"

@interface WOTMapCell : UITableViewCell
@property (weak, nonatomic) IBOutlet SKSapceLocationView *locationView;

@end
