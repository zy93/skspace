//
//  WOTOrderForBookStationCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTOrderForBookStationCell.h"
#import "MBProgressHUD+Extension.h"
#import "WOTSingtleton.h"
//#import ""

@interface WOTOrderForBookStationCell()

@property (nonatomic, assign)int orderNumberInt;
//@property (nonatomic, assign)int


@end

@implementation WOTOrderForBookStationCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }

}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)selectStartTime:(id)sender {
    self.isHiddenDataPickerView = NO;
    [WOTSingtleton shared].buttonType = BUTTON_TYPE_STARTTIME;
    if ([_delegate respondsToSelector:@selector(showDataPickerView:)]) {
        [_delegate showDataPickerView:self];
    }

}

- (IBAction)selectEndTime:(id)sender {
    self.isHiddenDataPickerView = NO;
    [WOTSingtleton shared].buttonType = BUTTON_TYPE_ENDTIME;
    if ([_delegate respondsToSelector:@selector(showDataPickerView:)]) {
        [_delegate showDataPickerView:self];
    }
}

- (IBAction)subButton:(id)sender {
    _orderNumberInt = [self.orderNumber.text intValue];
    _orderNumberInt -=1;
    if (_orderNumberInt <0) {
        [MBProgressHUDUtil showMessage:@"已经最小数量" toView:self.superview];
    }else
    {
         [WOTSingtleton shared].buttonType = BUTTON_TYPE_SUBBUTTON;
        self.orderNumber.text =  [NSString stringWithFormat:@"%d",_orderNumberInt];
        if ([_delegate respondsToSelector:@selector(changeValue:)]) {
            [_delegate changeValue:self];
        }
    }
}

- (IBAction)addButton:(id)sender {
    _orderNumberInt = [self.orderNumber.text intValue];
    _orderNumberInt +=1;
    if (_orderNumberInt > [self.spaceModel.alreadyTakenNum intValue]) {
        [MBProgressHUDUtil showMessage:@"数量超过剩余最大工位数量" toView:self.superview];
    }else
    {
         [WOTSingtleton shared].buttonType = BUTTON_TYPE_ADDBUTTON;
        self.orderNumber.text =  [NSString stringWithFormat:@"%d",_orderNumberInt];
        if ([_delegate respondsToSelector:@selector(changeValue:)]) {
            [_delegate changeValue:self];
        }
    }
    
}

@end
