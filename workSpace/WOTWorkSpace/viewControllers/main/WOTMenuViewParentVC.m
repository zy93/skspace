//
//  WOTMenuViewParentVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/6.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTMenuViewParentVC.h"

@interface WOTMenuViewParentVC()<WOTMenuDelegate,WOTMenuDataSource>

@end

@implementation WOTMenuViewParentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}




-(void)menu:(DropMenuView *)menu tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    
}


- (WOTMenuView *)menuView1 {
    if (!_menuView1 && [self.menu1Array count] > 0) {
        
        _menuView1 = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0,[self createmenuViewBaseViews][0].frame.origin.y + [self createmenuViewBaseViews][0].frame.size.height)];
        _menuView1.transformImageView = [self createmenuViewImageViews][0];
        _menuView1.titleLabel =[self createmenuViewLabels][0];
        
        _menuView1.dataSource = self;
        _menuView1.delegate = self;
    }
    return _menuView1;
}



- (WOTMenuView *)menuView2 {
    if (!_menuView2 && [self.menu2Array count] > 0) {
        
        _menuView2 = [[WOTMenuView alloc] initWithOrigin:CGPointMake(0, [self createmenuViewBaseViews][1].frame.origin.y + [self createmenuViewBaseViews][1].frame.size.height)];
        _menuView2.transformImageView = [self createmenuViewImageViews][1];
        _menuView2.titleLabel = [self createmenuViewLabels][1];
        
        _menuView2.dataSource = self;
        _menuView2.delegate = self;
    }
    return _menuView2;
}





-(NSArray<__kindof UIImageView *> *)createmenuViewImageViews{
    return [[NSArray alloc]init];
}

-(NSArray<__kindof UIView *> *)createmenuViewBaseViews{
    return [[NSArray alloc]init];
}


-(NSArray<__kindof UILabel *> *)createmenuViewLabels{
    return [[NSArray alloc]init];
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
