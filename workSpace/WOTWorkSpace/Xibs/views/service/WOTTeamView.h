//
//  WOTTeamView.h
//  WOTWorkSpace
//
//  Created by 张雨 on 2018/2/9.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>

@class WOTTeamView;

@protocol WOTTeamViewDelegate <NSObject>
-(void)teamView:(WOTTeamView *)teamView buttonClickWithTel:(NSString *)tel;
@end

@interface WOTTeamView : UIView

@property (nonatomic, strong) UIView * bgView;
@property (nonatomic, strong) UIImageView * iconIV;
@property (nonatomic, strong) UILabel *titleLab;
@property (nonatomic, strong) UILabel *subtitleLab;
@property (nonatomic, strong) UIButton * contactBtn;
@property (nonatomic, strong) NSString * tel;
@property (nonatomic, strong) id <WOTTeamViewDelegate> delegate;
@end
