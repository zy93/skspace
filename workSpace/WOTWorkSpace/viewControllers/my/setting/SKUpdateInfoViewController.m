//
//  SKUpdateInfoViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/1/5.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKUpdateInfoViewController.h"
#import "Masonry.h"

@interface SKUpdateInfoViewController ()

@property(nonatomic,strong)UIView *topView;
@property(nonatomic,strong)UITextField *importTextField;
@end

@implementation SKUpdateInfoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationController.navigationBar.backgroundColor = UICOLOR_MAIN_BACKGROUND;
    self.navigationItem.title = self.navigationStr;
    [self.view addSubview:self.topView];
    [self.topView addSubview:self.importTextField];
    [self addRightBtn];
}

-(void)viewDidLayoutSubviews
{
    [self.topView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(50);
    }];
    
    [self.importTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.topView);
    }];
}

- (void)addRightBtn {
    UIBarButtonItem *rightBarItem = [[UIBarButtonItem alloc] initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self action:@selector(saveInfo)];
    rightBarItem.tintColor = UICOLOR_MAIN_ORANGE;
    self.navigationItem.rightBarButtonItem = rightBarItem;
}

#pragma mark - 保存方法
- (void)saveInfo {
    NSLog(@"onClickedOKbtn");
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(UIView *)topView
{
    if (_topView == nil) {
        _topView = [[UIView alloc] init];
        _topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}

-(UITextField *)importTextField
{
    if (_importTextField == nil) {
        _importTextField = [[UITextField alloc] init];
        _importTextField.placeholder = self.placeholderStr;
    }
    return _importTextField;
}


@end
