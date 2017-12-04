//
//  WOTGETServiceCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WOTGETServiceCellDelegate <NSObject>

-(void)optionService:(NSString *)serviceName;

@end


@interface WOTGETServiceCell : UITableViewCell

@property (nonatomic, strong) id <WOTGETServiceCellDelegate> mDelegate;

@end
