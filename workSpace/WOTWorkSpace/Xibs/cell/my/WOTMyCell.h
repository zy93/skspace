//
//  WOTMyCell.h
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol WOTOMyCellDelegate <NSObject>


@required

-(void)showSettingVC;

@end

@interface WOTMyCell : UITableViewCell
@property(nonatomic,strong)UIImageView *headerImageView;
@property(nonatomic,strong)UIImageView *nextImageView;
@property(nonatomic,strong)UILabel *accountName;
@property(nonatomic,strong)UILabel *signature;
@property(nonatomic,strong)UIButton *settingBtn;
@property(nonatomic,strong)id<WOTOMyCellDelegate> mycelldelegate;
@end
