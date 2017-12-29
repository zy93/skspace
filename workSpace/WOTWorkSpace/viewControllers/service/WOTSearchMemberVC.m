//
//  WOTSearchMemberVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/12/27.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTSearchMemberVC.h"
#import "WOTVisitorsMemberCell.h"

@interface WOTSearchMemberVC () <UITableViewDelegate, UITableViewDataSource>
{
    NSArray *memberList;
}
@property (weak, nonatomic) IBOutlet UITableView *table;
@property (weak, nonatomic) IBOutlet UITextField *text;
@property (weak, nonatomic) IBOutlet UIButton *btn;

@end

@implementation WOTSearchMemberVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
#pragma mark - action
- (IBAction)searchBtn:(id)sender {
    if (!self.text.text) {
        [MBProgressHUDUtil showMessage:@"请输入会员名" toView:self.view];
        return;
    }
    [self createRequest];
}

-(void)createRequest
{
    [WOTHTTPNetwork searchMemberWithName:self.text.text spaceId:self.spaceId response:^(id bean, NSError *error)
    {
        if (!error) {
            WOTSearchModel_model *model = (WOTSearchModel_model*)bean;
            if ([model.code isEqualToString:@"200"]) {
                memberList = model.msg.list;
            }
        }
    }];
}



#pragma mark - table delegate
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return memberList.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTVisitorsMemberCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTVisitorsMemberCell"];
    return cell;
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
