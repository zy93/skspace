//
//  WOTPersionalInformationTagCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTPersionalInformationTagCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIView *tagsVIew;

@property (weak, nonatomic) IBOutlet UIView *lineView;
@property(strong,nonatomic)NSArray *tagLabelArray;

@end
