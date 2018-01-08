//
//  WOTMyuserCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/30.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol WOTOMyCellDelegate <NSObject>


@required

-(void)showSettingVC;
-(void)showPersonalInformationVC;
@end
@interface WOTMyuserCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *userName;
@property (weak, nonatomic) IBOutlet UIImageView *headerImage;
@property (weak, nonatomic) IBOutlet UILabel *memberLabel;
@property (weak, nonatomic) IBOutlet UIView *headView;
@property (weak, nonatomic) IBOutlet UIButton *loginButton;
@property (weak, nonatomic) IBOutlet UIButton *topButton;


@property(nonatomic,strong)id<WOTOMyCellDelegate> mycelldelegate;
@end
