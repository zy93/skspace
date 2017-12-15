//
//  SKCommentTableViewCell.h
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/14.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WFTextView.h"

@interface SKCommentTableViewCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *headImageView;
@property (weak, nonatomic) IBOutlet UILabel *commentatorLabel;
@property (weak, nonatomic) IBOutlet WFTextView *infoTextView;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@end
