//
//  SKDemandInfoViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/4.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKDemandInfoViewController.h"
#import "Masonry.h"
#import "UIColor+ColorChange.h"
#import "SKTypeView.h"

@interface SKDemandInfoViewController ()<UITextViewDelegate>

@property(nonatomic,strong)UIView *topview;
@property(nonatomic,strong)UILabel *typeLabel;
@property(nonatomic,strong)UILabel *typeInfoLabel;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UIButton *chooseTypeButton;
@property(nonatomic,strong)UIView *lineView;
@property(nonatomic,strong)UITextView *demandInfoTextView;
@property(nonatomic,strong)UIButton *demandSubmitButton;

@end

@implementation SKDemandInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor colorWithHexString:@"f9f9f9"];
    self.navigationItem.title = @"获取支持";
    [self.view addSubview:self.topview];
    [self.topview addSubview:self.typeLabel];
    [self.topview addSubview:self.typeInfoLabel];
    [self.topview addSubview:self.imageView];
    [self.topview addSubview:self.chooseTypeButton];
    [self.topview addSubview:self.lineView];
    [self.topview addSubview:self.demandInfoTextView];
    [self.view addSubview:self.demandSubmitButton];
    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.topview mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64+10);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(275);
    }];
    
    [self.typeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.topview).with.offset(15);
        make.left.equalTo(self.topview).with.offset(10);
    }];
    
    [self.typeInfoLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeLabel);
        make.right.equalTo(self.topview).with.offset(-20);
    }];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.typeInfoLabel);
        make.right.equalTo(self.topview).with.offset(-5);
    }];
    
    [self.lineView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.topview).with.offset(5);
        make.right.equalTo(self.topview).with.offset(-5);
        make.height.mas_offset(1);
    }];
    
    [self.demandInfoTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView.mas_bottom).with.offset(5);
        make.left.equalTo(self.topview).with.offset(10);
        make.right.equalTo(self.topview).with.offset(-10);
        make.bottom.equalTo(self.topview);
    }];
    
    [self.demandSubmitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.height.mas_offset(48);
    }];
    
    [self.chooseTypeButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.typeLabel.mas_top);
        make.left.equalTo(self.typeLabel.mas_left);
        make.right.equalTo(self.imageView.mas_right);
        make.bottom.equalTo(self.lineView.mas_top);
    }];
    
}

#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.demandInfoTextView.text=@"";
    self.demandInfoTextView.textColor = [UIColor blackColor];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.demandInfoTextView.text isEqualToString:@""]) {
        self.demandInfoTextView.text = @"*请填写您的服务需求";
        self.demandInfoTextView.textColor = [UIColor lightGrayColor];
    }
    return YES;
}

#pragma mark - 提交方法
-(void)demandSubMitButtonMethod
{
    if (![WOTSingtleton shared].isuserLogin) {
        [MBProgressHUDUtil showMessage:@"请先登录后再提交！" toView:self.view];
        return;
    }
    
    if (strIsEmpty(self.demandInfoTextView.text) || [self.demandInfoTextView.text isEqualToString:@"*请填写您的服务需求"]) {
        [MBProgressHUDUtil showMessage:@"请填写需求内容后再提交！" toView:self.view];
        return;
    }


    [WOTHTTPNetwork issueDemandWithUserId:[WOTUserSingleton shareUser].userInfo.userId
                                 userName:[WOTUserSingleton shareUser].userInfo.userName
                                  spaceId:[WOTUserSingleton shareUser].userInfo.spaceId
                                  userTel:[WOTUserSingleton shareUser].userInfo.tel
                               demandType:self.typeInfoLabel.text
                            demandContent:self.demandInfoTextView.text
                                 response:^(id bean, NSError *error) {
                                     WOTBaseModel *model = (WOTBaseModel *)bean;
                                     if ([model.code isEqualToString:@"200"]) {
                                         [MBProgressHUDUtil showLoadingWithMessage:@"提交成功" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
                                             [hud hide:YES afterDelay:1.f complete:^{
                                                 dispatch_async(dispatch_get_main_queue(), ^{
                                                     [self.navigationController popToRootViewControllerAnimated:YES];
                                                 });
                                                 
                                             }];
                                         }];
                                     }
                                     else
                                     {
                                         [MBProgressHUDUtil showMessage:@"提交失败！" toView:self.view];
                                     }
                                 }];
}

#pragma mark - 选择支持类型
-(void)chooseTypeButtonMethod
{
    SKTypeView *typeView = [[SKTypeView alloc] initWithFrame:(CGRect){0, 64, kScreenW, kScreenH-64}];
    typeView.sureBtnsClick = ^(NSString *typeString){
        self.typeString = typeString;
        dispatch_async(dispatch_get_main_queue(), ^{
            self.typeInfoLabel.text = typeString;
        });
       
    };
    [typeView showInView:self.navigationController.view];
}

-(UIView *)topview
{
    if (_topview == nil) {
        _topview = [[UIView alloc] init];
        _topview.backgroundColor = [UIColor whiteColor];
    }
    return _topview;
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

-(UIImageView *)imageView
{
    if (_imageView == nil) {
        _imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"demandImage"]];
    }
    return _imageView;
}

-(UITextView *)demandInfoTextView
{
    if (_demandInfoTextView == nil) {
        _demandInfoTextView = [[UITextView alloc] init];
        _demandInfoTextView.delegate = self;
        _demandInfoTextView.text = @"*请填写您的服务需求";
        _demandInfoTextView.textColor = [UIColor lightGrayColor];
        _demandInfoTextView.font = [UIFont systemFontOfSize:15];
    }
    return _demandInfoTextView;
}

-(UIButton *)demandSubmitButton
{
    if (_demandSubmitButton == nil) {
        _demandSubmitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _demandSubmitButton.backgroundColor = [UIColor colorWithHexString:@"528bfa"];
        [_demandSubmitButton setTitle:@"提交" forState:UIControlStateNormal];
        _demandSubmitButton.layer.cornerRadius = 5.f;
        _demandSubmitButton.layer.borderWidth = 1.f;
        _demandSubmitButton.layer.borderColor = [UIColor colorWithHexString:@"528bfa"].CGColor;
        [_demandSubmitButton addTarget:self action:@selector(demandSubMitButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _demandSubmitButton;
}

-(UIButton *)chooseTypeButton
{
    if (_chooseTypeButton == nil) {
        _chooseTypeButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_chooseTypeButton addTarget:self action:@selector(chooseTypeButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _chooseTypeButton;
}

-(UIView *)lineView
{
    if (_lineView == nil) {
        _lineView = [[UIView alloc] init];
        [_lineView setBackgroundColor:[UIColor colorWithHexString:@"dddddd"]];
    }
    return _lineView;
}

@end
