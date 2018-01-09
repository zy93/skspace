//
//  WOTRegisterServiceProvidersCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTRegisterServiceProvidersCell.h"
#import "Masonry.h"

@implementation WOTRegisterServiceProvidersCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    
    
    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
        [self setSeparatorInset:UIEdgeInsetsZero];
    }
}
-(void)willMoveToSuperview:(UIView *)newSuperview
{
    [self addSubview:self.titleLabel];
    [self addSubview:self.contentTextField];
    [self addSubview:self.iconImg];
    [self celllayoutSubviews];
}

-(void)celllayoutSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.left.equalTo(self).with.offset(20);
        //make.right.equalTo(self.contentTextField.mas_left).with.offset(15);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(self);
        make.top.equalTo(self);
       // make.left.equalTo(self.titleLabel.mas_right).with.offset(15);
        make.right.equalTo(self).with.offset(-20);
        make.bottom.equalTo(self);
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self);
        make.right.equalTo(self).with.offset(-20);
        make.height.mas_offset(45);
        make.width.mas_offset(45);
    }];
}

//-(void)willMoveToSuperview:(UIView *)newSuperview
//{
//
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

//@property(nonatomic,strong)UILabel *titleLabel;
//@property(nonatomic,strong)UITextField *contentTextField;
//@property(nonatomic,strong)UIImageView *iconImg;
-(UILabel *)titleLabel
{
    if (_titleLabel == nil) {
        _titleLabel = [[UILabel alloc] init];
    }
    return _titleLabel;
}

-(UITextField *)contentTextField
{
    if (_contentTextField == nil) {
        _contentTextField = [[UITextField alloc] init];
    }
    return _contentTextField;
}

-(UIImageView *)iconImg
{
    if (_iconImg == nil) {
        _iconImg = [[UIImageView alloc] init];
    }
    return _iconImg;
}

@end
