//
//  SKFocusListTableViewCell.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKFocusListTableViewCell.h"
#import "Masonry.h"


@interface SKFocusListTableViewCell ()



@end

@implementation SKFocusListTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self createView];
        [self viewLayout];
    }
    return self;
}

-(void)viewLayout
{
    [self.userHeadImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(10);
        make.height.width.mas_offset(45);
    }];
    
    [self.userName mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self).with.offset(10);
        make.left.equalTo(self.userHeadImageView.mas_right).with.offset(10);
    }];
    
    [self.userCompany mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.userName.mas_bottom).with.offset(10);
        make.left.equalTo(self.userHeadImageView.mas_right).with.offset(10);
    }];
    
    [self.cancelFocusButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-10);
        make.height.mas_offset(22);
        make.width.mas_offset(62);
    }];
    
}

-(void)createView
{
    self.userHeadImageView = [[UIImageView alloc] init];
    [self addSubview:self.userHeadImageView];
    
    self.userName = [[UILabel alloc] init];
    [self addSubview:self.userName];
    
    self.userCompany = [[UILabel alloc] init];
    [self.userCompany setFont:[UIFont systemFontOfSize:12]];
    self.userCompany.textColor = [UIColor grayColor];
    [self addSubview:self.userCompany];
    
    self.cancelFocusButton = [YMButton buttonWithType:UIButtonTypeCustom];
    [self.cancelFocusButton setBackgroundImage:[UIImage imageNamed:@"focus"] forState:UIControlStateNormal];
    [self addSubview:self.cancelFocusButton];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
