//
//  WOTRegisterServiceProvidersCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTRegisterServiceProvidersCell.h"
#import "Masonry.h"

@interface WOTRegisterServiceProvidersCell ()<UITextFieldDelegate>


@end

@implementation WOTRegisterServiceProvidersCell

//- (void)awakeFromNib {
//    [super awakeFromNib];
//    // Initialization code
////    if ([self respondsToSelector:@selector(setSeparatorInset:)]) {
////        [self setSeparatorInset:UIEdgeInsetsZero];
////    }
//}
- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self.contentView addSubview:self.titleLabel];
        [self.contentView addSubview:self.contentTextField];
        [self.contentView addSubview:self.iconImg];
        [self celllayoutSubviews];
    }
    return self;
}

-(void)celllayoutSubviews
{
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.left.equalTo(self.contentView).with.offset(20);
        //make.right.equalTo(self.contentTextField.mas_left).with.offset(15);
    }];
    
    [self.contentTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.centerY.equalTo(self);
        make.top.equalTo(self.contentView);
        make.left.equalTo(self.titleLabel.mas_right).with.offset(15);
        make.right.equalTo(self.contentView).with.offset(-20);
        make.bottom.equalTo(self.contentView);
       // make.width.mas_offset(150);
    }];
    
    [self.iconImg mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.contentView);
        make.right.equalTo(self.contentView).with.offset(-20);
        make.height.mas_offset(45);
        make.width.mas_offset(45);
    }];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
}

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
        _contentTextField.textAlignment = NSTextAlignmentRight;
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
