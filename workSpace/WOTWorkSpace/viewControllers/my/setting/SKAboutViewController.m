//
//  SKAboutViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKAboutViewController.h"
#import "Masonry.h"

@interface SKAboutViewController ()
@property(nonatomic,strong)UIImageView *logoImageView;
@property(nonatomic,strong)UIImageView *QRcodeImageView;
@property(nonatomic,strong)UILabel *versionLabel;
@property(nonatomic,strong)UILabel *telLabel;
@property(nonatomic,strong)UILabel *copyrightLabel;
@end

@implementation SKAboutViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"关于APP";
    [self.view addSubview:self.logoImageView];
    [self.view addSubview:self.copyrightLabel];
    [self.view addSubview:self.versionLabel];
    [self.view addSubview:self.telLabel];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewDidLayoutSubviews
{
    [self.logoImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(200);
        make.centerX.equalTo(self.view);
    }];
    
//    [self.QRcodeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.center.equalTo(self.view);
//    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.logoImageView.mas_bottom).with.offset(10);
        make.centerX.equalTo(self.view);
        //make.bottom.equalTo(self.telLabel.mas_top).with.offset(-10);
    }];
    
    [self.telLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-30);
    }];
    
    [self.copyrightLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.view);
        make.bottom.equalTo(self.view).with.offset(-10);
    }];
}

-(UIImageView *)logoImageView
{
    if (_logoImageView == nil) {
        _logoImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"logoImage"]];
    }
    return _logoImageView;
}

-(UIImageView *)QRcodeImageView
{
    if (_QRcodeImageView == nil) {
        _QRcodeImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"QRcodeImage"]];
    }
    return _QRcodeImageView;
}

-(UILabel *)versionLabel
{
    if (_versionLabel == nil) {
        _versionLabel = [[UILabel alloc] init];
        _versionLabel.text = @"版本号：1.1.2";
    }
    return _versionLabel;
}

-(UILabel *)telLabel
{
    if (_telLabel == nil) {
        _telLabel = [[UILabel alloc] init];
        _telLabel.text = @"北京国投尚科信息科技有限公司 版权所有";
        _telLabel.textColor = [UIColor grayColor];
        [_telLabel setFont:[UIFont systemFontOfSize:12]];
    }
    return _telLabel;
}

-(UILabel *)copyrightLabel
{
    if (_copyrightLabel == nil) {
        _copyrightLabel = [[UILabel alloc] init];
        _copyrightLabel.text = @"Beijing GuoTouShangKe Technology Co., Ltd.All.Rights Reserved.";
        _copyrightLabel.textColor = [UIColor grayColor];
        [_copyrightLabel setFont:[UIFont systemFontOfSize:10]];
    }
    return _copyrightLabel;
}


@end
