//
//  WOTMyuserCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/30.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyuserCell.h"
#import "UIView+Extension.h"
@implementation WOTMyuserCell

- (void)awakeFromNib {
    [super awakeFromNib];
   
    
    [self.headerImage setCorenerRadius:self.headerImage.frame.size.width/2 borderColor:White];
    [[WOTConfigThemeUitls shared] setLabelColorss:[NSArray arrayWithObjects:self.userName,self.constellation,self.signature, nil] withColor:[UIColor whiteColor]];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)goToSettingVC:(id)sender {
    
    if (_mycelldelegate) {
        [_mycelldelegate showSettingVC];
    }
}
- (IBAction)goToPersionalInformationVC:(id)sender {
    if (_mycelldelegate) {
        [_mycelldelegate showPersonalInformationVC];
    }
}

@end
