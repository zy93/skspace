//
//  WOTEnterCell.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/28.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTEnterCell;

@protocol WOTEnterCellDelegate <NSObject>
-(void)enterCell:(WOTEnterCell*)cell textDidChange:(NSString *)searchText;
@end

@interface WOTEnterCell : UITableViewCell <UITextFieldDelegate>
@property (weak, nonatomic) IBOutlet UITextField *textField;
@property (nonatomic, strong) id <WOTEnterCellDelegate> delegate;
@end
