//
//  WOTEnterTextVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/7.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterTextVC.h"
#import "WOTMaintenanceApplyVC.h"
#import "WOTMainAppleRepairVC.h"
@interface WOTEnterTextVC ()
@property (weak, nonatomic) IBOutlet UITextView *enterText;

@end

@implementation WOTEnterTextVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self configNav];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"输入描述";
    
    UIBarButtonItem *doneItem = [[UIBarButtonItem alloc] initWithTitle:@"完成" style:UIBarButtonItemStylePlain target:self action:@selector(selectDoneAction)];
    
    [self.navigationItem setRightBarButtonItem:doneItem];
    //解决布局空白问题
    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
    if (is7Version) {
        self.edgesForExtendedLayout=UIRectEdgeNone;
    }
}

#pragma mark - action
-(void)selectDoneAction
{
    if (_popVCWithEnterString) {
        self.popVCWithEnterString(_enterText.text);
    }
    [self.navigationController popViewControllerAnimated:YES];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
