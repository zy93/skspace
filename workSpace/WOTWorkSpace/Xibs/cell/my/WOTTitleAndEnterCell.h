//
//  WOTTitleAndEnterCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/29.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTTitleAndEnterCell;

@protocol WOTTitleAndEnterCellDelegate <NSObject>
-(void)enterCell:(WOTTitleAndEnterCell *)cell didEnterText:(NSString *)text;
@end

@interface WOTTitleAndEnterCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UILabel *titleLab;
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (weak, nonatomic) IBOutlet UIView *lineView;

@property (nonatomic, strong) id <WOTTitleAndEnterCellDelegate> delegate;
@end
