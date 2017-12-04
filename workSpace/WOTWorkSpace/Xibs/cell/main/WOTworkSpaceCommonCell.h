//
//  WOTworkSpaceCommonCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTworkSpaceCommonCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *workSpaceName;

@property (weak, nonatomic) IBOutlet UILabel *workSpaceLocation;
@property (weak, nonatomic) IBOutlet UILabel *stationNum;

@property (weak, nonatomic) IBOutlet UIImageView *workSpaceImage;

@property (weak, nonatomic) IBOutlet UIView *lineVIew;

@end
