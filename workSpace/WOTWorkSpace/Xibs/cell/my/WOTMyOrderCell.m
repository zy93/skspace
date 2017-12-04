//
//  WOTMyOrderCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyOrderCell.h"
#import "WOTConstants.h"
@interface WOTMyOrderCell()

@property (weak, nonatomic) IBOutlet UIView *mettingroomView;
@property (weak, nonatomic) IBOutlet UIView *stationView;

@property (weak, nonatomic) IBOutlet UILabel *mettingroomNum;
@property (weak, nonatomic) IBOutlet UILabel *mettingroomLabel;
@property (weak, nonatomic) IBOutlet UILabel *stationNum;
@property (weak, nonatomic) IBOutlet UILabel *stationLabel;

@property (weak, nonatomic) IBOutlet UILabel *allOrderLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewWidth;


@end

@implementation WOTMyOrderCell


- (void)awakeFromNib {
    [super awakeFromNib];
    self.viewWidth.constant = SCREEN_WIDTH/2;
    self.mettingroomView.backgroundColor = CLEARCOLOR;
    self.stationView.backgroundColor = CLEARCOLOR;
    self.mettingroomLabel.textColor = LowTextColor;
    self.stationLabel.textColor = LowTextColor;
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (IBAction)showMettingroomVC:(id)sender {
    if (_celldelegate) {
       
        [self.celldelegate showMettingRoomOrderList];
    }
    
    
}

- (IBAction)showStationVC:(id)sender {
    
    if (_celldelegate) {
        [self.celldelegate showStationOrderList];
    }
    
    
}
- (IBAction)showAllOrderVC:(id)sender {
    
    
    if (_celldelegate) {
        [self.celldelegate showAllOrderList];
    }
}


@end
