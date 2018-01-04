//
//  SKAboutViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/3.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKAboutViewController.h"
#import "Masonry.h"

@interface SKAboutViewController ()
@property (nonatomic,strong)UIImageView *logoImageView;
@property (nonatomic,strong)UIImageView *QRcodeImageView;
@property (nonatomic,strong)UILabel *versionsLabel;
@property (nonatomic,strong)UILabel *telLabel;
@end

@implementation SKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于APP";
    
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.QRcodeImageView];
    [self.view addSubview:self.versionsLabel];
    [self.view addSubview:self.telLabel];
    
    [self layoutSubviews];
    
}

-(void)layoutSubviews
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.top.equalTo(self.view).with.offset(100);
    }];
    
    [self.QRcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(self.view);
    }];
    
    [self.versionsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.telLabel.mas_top).with.offset(-10);
        make.centerX.equalTo(self.view);
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-10);
        make.centerX.equalTo(self.view);
    }];
}

-(UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] init];
        _logoImageView.image = [UIImage imageNamed:@"logoImage"];
    }
    return _logoImageView;
}

-(UIImageView *)QRcodeImageView
{
    if (_QRcodeImageView == nil) {
        _QRcodeImageView = [[UIImageView alloc] init];
        _QRcodeImageView.image = [UIImage imageNamed:@"QRcodeImage"];
    }
    return _QRcodeImageView;
}

-(UILabel *)versionsLabel
{
    if (_versionsLabel == nil) {
        _versionsLabel = [[UILabel alloc] init];
        _versionsLabel.text = @"版本号：1.1.2";
    }
    return _versionsLabel;
}

-(UILabel *)telLabel
{
    if (_telLabel == nil) {
        _telLabel = [[UILabel alloc] init];
        _telLabel.text = @"服务电话：400-1111";
    }
    return _telLabel;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
