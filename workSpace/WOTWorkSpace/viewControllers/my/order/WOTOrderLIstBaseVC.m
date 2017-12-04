//
//  WOTOrderLIstBaseVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/6/28.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTOrderLIstBaseVC.h"


#import "WOTOrderCell.h"
@interface WOTOrderLIstBaseVC ()

@end

@implementation WOTOrderLIstBaseVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:@"WOTOrderCell" bundle:nil] forCellReuseIdentifier:@"orderlistCellID"];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 115;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    
    WOTOrderCell *cell = (WOTOrderCell *)[tableView dequeueReusableCellWithIdentifier:@"orderlistCellID"];
    switch (_orderlisttype) {
        case WOTPageMenuVCTypeMetting:
       
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeLabel,cell.dateLabel,cell.timeLabel,cell.moneyLabel, nil]  withTexts:@[@"预定地点",@"预定时间",@"下单时间",@"金额总数"]];
            
             [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[@"方圆大厦优客工场",@"2017-06-30 12:34:56",@"2017-06-23 12:34:56",@"¥2343"]];
            break;
        case WOTPageMenuVCTypeStation:
            
            [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeLabel,cell.dateLabel,cell.timeLabel,cell.moneyLabel, nil]  withTexts:@[@"预定地点",@"预定时间",@"预定数量",@"金额总数"]];
            
              [[WOTConfigThemeUitls shared] setLabelTexts:[NSArray arrayWithObjects:cell.placeValue,cell.dateValue,cell.timeValue,cell.moneyValue, nil]  withTexts:@[@"方圆大厦优客工场",@"2017-06-30 12:34:56",@"34量",@"¥5456"]];
        default:
            break;
    }
//    if (!cell) {
//      
//        NSArray *nibArray = [[NSBundle mainBundle] loadNibNamed:@"WOTOrderCell" owner:nil options:nil];
//        for (id obj in nibArray) {
//            if ([obj isMemberOfClass:[WOTOrderCell class]]) {
//                // Assign cell to obj
//                cell = (WOTOrderCell *)obj;
//                break;
//            }
//        }
//    }
    
    return cell;
    
    
}

-(void)createData{
    
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
