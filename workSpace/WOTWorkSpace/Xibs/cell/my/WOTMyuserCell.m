//
//  WOTMyuserCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/30.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyuserCell.h"
#import "UIView+Extension.h"
#import "WOTSingtleton.h"
@implementation WOTMyuserCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    self.headView.layer.shadowOpacity = 0.5;// 阴影透明度
    self.headView.layer.shadowColor = [UIColor grayColor].CGColor;// 阴影的颜色
    self.headView.layer.shadowRadius = 3;// 阴影扩散的范围控制
    self.headView.layer.shadowOffset = CGSizeMake(1, 1);// 阴影的范围
    self.headView.layer.cornerRadius = 5.f;
    self.headView.layer.borderWidth = 1.f;
    self.headView.layer.borderColor = [UIColor whiteColor].CGColor;
    [self.headerImage setCorenerRadius:self.headerImage.frame.size.width/2 borderColor:UICOLOR_WHITE];
    [[WOTConfigThemeUitls shared] setLabelColorss:[NSArray arrayWithObjects:self.userName,self.memberLabel, nil] withColor:[UIColor blackColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goToSettingVC:(id)sender {
     if ([WOTSingtleton shared].isuserLogin) {
         if (_mycelldelegate) {
             [_mycelldelegate showSettingVC];
         }
     }else
     {
         [MBProgressHUDUtil showMessage:@"请先登录！" toView:self.superview];
     }
    
}




@end
