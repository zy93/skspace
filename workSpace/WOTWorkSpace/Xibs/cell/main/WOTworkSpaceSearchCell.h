//
//  WOTworkSpaceSearchCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface WOTworkSpaceSearchCell : UITableViewCell
@property (strong, nonatomic) UIView *searchField;
@property (nonatomic,copy)void(^searchBarBlock)(NSString *searchText);
@end
