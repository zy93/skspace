//
//  WOTSearchVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/29.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTSearchVC.h"

#import "WOTOrderCell.h"
@interface WOTSearchVC ()

@end

@implementation WOTSearchVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self configNaviBackItem];
    [self configNaviView:@"请输入关键字" block:^(){
        
    }];
  [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"orderlistCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)setDataSource:(NSArray *)dataSource{
    if (dataSource) {
         dataSource = [[NSArray alloc]init];
    }
   
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return _dataSource.count;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 70;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    WOTOrderCell *companycell = (WOTOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"orderlistCellID"];
    

    return companycell;
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
