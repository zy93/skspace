//
//  SKAddDemandInfoViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/2.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKAddDemandInfoViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "SKSupportTypeView.h"

@interface SKAddDemandInfoViewController ()<UITextViewDelegate>

@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UILabel *typeLabel;
@property (nonatomic,strong)UILabel *typeInfoLabel;
@property (nonatomic,strong)UIImageView *typeImageView;

@property (nonatomic,strong)UIView *lineView;
@property (nonatomic,strong)UITextView *demandTextView;

@property (nonatomic,strong)UIButton *demandSubmitButton;

@property (nonatomic,strong)UIButton *topViewButton;

@end

@implementation SKAddDemandInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"获取支持";
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.typeLabel];
    [self.topView addSubview:self.typeInfoLabel];
    [self.topView addSubview:self.typeImageView];
    [self.topView addSubview:self.lineView];
    [self.topView addSubview:self.demandTextView];
    [self.topView addSubview:self.topViewButton];
    [self.view addSubview:self.demandSubmitButton];
    
    [self layoutSubviews];
}

-(void)layoutSubviews
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64+10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(275);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).with.offset(15);
        make.left.equalTo(self.topView).with.offset(15);
        make.width.mas_offset(100);
    }];
    
    [self.typeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView).with.offset(15);
        make.right.equalTo(self.topView).with.offset(-20);
    }];
    
    [self.typeImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        //make.top.equalTo(self.topView).with.offset(15);
        make.centerY.equalTo(self.typeLabel);
        make.right.equalTo(self.topView).with.offset(-5);
        make.width.mas_offset(7);
        make.height.mas_offset(13);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.topView).with.offset(5);
        make.right.equalTo(self.topView).with.offset(-5);
        make.height.mas_offset(1);
    }];
    
    [self.demandTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
        make.right.equalTo(self.topView).with.offset(-5);
        make.left.equalTo(self.topView).with.offset(5);
        make.bottom.equalTo(self.topView).with.offset(15);
        
    }];
    
    [self.demandSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.view).with.offset(-20);
        make.left.equalTo(self.view).with.offset(20);
        make.right.equalTo(self.view).with.offset(-20);
        make.height.mas_offset(48);
    }];
    
    [self.topViewButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topView);
        make.right.equalTo(self.topView);
        make.left.equalTo(self.topView);
        make.bottom.equalTo(self.lineView.mas_top);
    }];
}

-(UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

-(UILabel *)typeLabel
{
    if (_typeLabel == nil) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.text = @"支持类型";
    }
    return _typeLabel;
}

-(UILabel *)typeInfoLabel
{
    if (_typeInfoLabel == nil) {
        _typeInfoLabel = [[UILabel alloc] init];
        _typeInfoLabel.text = self.typeString;
    }
    return _typeInfoLabel;
}

-(UIImageView *)typeImageView
{
    if (_typeImageView == nil) {
        _typeImageView = [[UIImageView alloc] init];
        _typeImageView.image = [UIImage imageNamed:@"demandImage"];
    }
    return _typeImageView;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        _lineView.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _lineView;
}

-(UITextView *)demandTextView
{
    if (_demandTextView == nil) {
        _demandTextView = [[UITextView alloc] init];
        _demandTextView.text = @"*请填写您的服务需求";
        _demandTextView.delegate = self;
        _demandTextView.textColor =[UIColor grayColor];
    }
    return _demandTextView;
}

-(UIButton *)demandSubmitButton
{
    if (_demandSubmitButton == nil) {
        _demandSubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_demandSubmitButton setBackgroundImage:[UIImage imageNamed:@"submit"] forState:UIControlStateNormal];
        [_demandSubmitButton addTarget:self action:@selector(demandSubmitButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _demandSubmitButton;
}

-(UIButton *)topViewButton
{
    if (_topViewButton == nil) {
        _topViewButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_topViewButton addTarget:self action:@selector(chooseTypeMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _topViewButton;
}

#pragma mark - UITextViewDelegate
- (void)textViewDidEndEditing:(UITextView *)textView
{
    if(textView.text.length < 1){
        textView.text = @"*请填写您的服务需求";
        textView.textColor = [UIColor grayColor];
    }
}

- (void)textViewDidBeginEditing:(UITextView *)textView
{
    if([textView.text isEqualToString:@"*请填写您的服务需求"]){
        textView.text=@"";
        textView.textColor=[UIColor blackColor];
    }
}

#pragma mark - 发布需求
-(void)demandSubmitButtonMethod
{
    
}

#pragma mark - 类型
-(void)chooseTypeMethod
{
    SKSupportTypeView *supportTypeView = [[SKSupportTypeView alloc] initWithFrame:CGRectMake(0, 64,kScreenW, kScreenH-64)];
    supportTypeView.sureBtnsClick = ^(NSString *typeString){
        self.typeString = typeString;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.typeInfoLabel.text = typeString;
        });
    };
    [supportTypeView showInView:self.navigationController.view];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
