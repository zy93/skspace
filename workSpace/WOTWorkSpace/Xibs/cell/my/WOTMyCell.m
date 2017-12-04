//
//  WOTMyCell.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/27.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMyCell.h"

@implementation WOTMyCell

-(instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self loadSubViews];
    }
    return self;
}
- (void)awakeFromNib {
    [super awakeFromNib];
   
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)loadSubViews{
    _headerImageView = [[UIImageView alloc]init];
    _headerImageView.image = [UIImage imageNamed:@"defaultHeaderVIew"];
    
    _accountName = [[UILabel alloc]init];
    _accountName.numberOfLines = 0;
    
    _signature = [[UILabel alloc]init];
    _signature.font = [UIFont systemFontOfSize:15];
    _nextImageView = [[UIImageView alloc]init];
    _nextImageView.image = [UIImage imageNamed:@"backAcssory"];
    
    _settingBtn = [[UIButton alloc]init];
    
    [_settingBtn setBackgroundImage:[UIImage imageNamed:@"setting"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(popToSettingVC) forControlEvents: UIControlEventTouchUpInside];
    
    [self.contentView addSubview:_headerImageView];
    [self.contentView addSubview:_accountName];
    [self.contentView addSubview:_signature];
    [self.contentView addSubview:_nextImageView];
    [self.contentView addSubview:_settingBtn];
}

-(void)layoutSubviews{
    [_headerImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.left.mas_equalTo(self.contentView).offset(10);
        maker.centerY.mas_equalTo(self.contentView);
        maker.height.mas_equalTo(60);
        maker.width.mas_equalTo(60);
    }];
    [_accountName mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.centerY.mas_equalTo(self.contentView).offset(-15);
        maker.left.mas_equalTo(_headerImageView.mas_right).offset(10);
        maker.right.mas_equalTo(_nextImageView.mas_left).offset(5);
    
    }];
    [_signature mas_makeConstraints:^(MASConstraintMaker *maker){
        maker.left.equalTo(_accountName);
        maker.top.equalTo(_accountName.mas_bottom).offset(5);
        maker.right.mas_equalTo(_nextImageView.mas_left).offset(5);
    }];
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.trailingMargin.mas_equalTo(self.contentView).offset(-8);
        maker.centerY.mas_equalTo(self.contentView);
        maker.height.mas_equalTo(15);
        maker.width.mas_equalTo(20);
    }];
    
    [_nextImageView mas_makeConstraints:^(MASConstraintMaker *maker){
        
        maker.trailingMargin.mas_equalTo(self.contentView).offset(-8);
        maker.centerY.mas_equalTo(self.contentView);
        maker.height.mas_equalTo(7);
        maker.width.mas_equalTo(13);
    }];
    
    
    
}


@end
