//
//  SKRoomListVC.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/5/29.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKRoomListVC.h"
#import "Masonry.h"
#import "SKRoomTableViewCell.h"
#import "WOTHTTPNetwork.h"
#import "WOTOrderVC.h"
#import "SKRoomModel.h"

@interface SKRoomListVC ()<UITableViewDelegate,UITableViewDataSource>
@property(nonatomic,strong)UITableView *roomListTableView;
@property(nonatomic,strong)NSMutableArray *roomArray;
@end

@implementation SKRoomListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.roomListTableView];
    self.navigationItem.title = self.spaceModel.spaceName;
    self.roomArray = [[NSMutableArray alloc] init];
    [self layoutSubviews];
    [self.roomListTableView registerClass:[SKRoomTableViewCell class] forCellReuseIdentifier:@"SKRoomTableViewCell"];
    [self creatquestData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.roomListTableView mas_makeConstraints:^(MASConstraintMaker *make) {
        if (@available(iOS 11.0, *)){
            make.top.equalTo(self.view.mas_safeAreaLayoutGuideTop);
            make.bottom.equalTo(self.view.mas_safeAreaLayoutGuideBottom);
            make.left.equalTo(self.view.mas_safeAreaLayoutGuideLeft);
            make.right.equalTo(self.view.mas_safeAreaLayoutGuideRight);
        }else{
            make.top.equalTo(self.view);
            make.bottom.equalTo(self.view);
            make.left.equalTo(self.view);
            make.right.equalTo(self.view);
        }
    }];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 150;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.roomArray.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    SKRoomTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKRoomTableViewCell"];
    
    if (!cell) {
        cell = (SKRoomTableViewCell *)[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"SKRoomTableViewCell"];
    }
    SKRoomModel *model = self.roomArray[indexPath.row];
    [cell.roomImageView sd_setImageWithURL:[NSURL URLWithString:model.showPicture] placeholderImage:[UIImage imageNamed:@"bookStation"]];
    cell.roomNameLabel.text = model.subareaName;
    cell.bookStationInfoNumLabel.text = [NSString stringWithFormat:@"%@/位",model.stationNum];
    cell.nowPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.mmprice];
    //cell.formerlyPriceLabel.text = [NSString stringWithFormat:@"¥%@",model.averagePrice];
    NSAttributedString *attrStr =
    [[NSAttributedString alloc]initWithString:[NSString stringWithFormat:@"¥%@",model.averagePrice]
                                   attributes:
     @{NSFontAttributeName:[UIFont systemFontOfSize:15.f],
       NSForegroundColorAttributeName:UICOLOR_GRAY_66,
       NSStrikethroughStyleAttributeName:@(NSUnderlineStyleSingle|NSUnderlinePatternSolid),
       NSStrikethroughColorAttributeName:UICOLOR_GRAY_66}];
    cell.formerlyPriceLabel.attributedText = attrStr;
    cell.selectionStyle = UITableViewCellSelectionStyleNone;
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    WOTOrderVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTOrderVC"];
    vc.spaceModel = self.spaceModel;
    SKRoomModel *model = self.roomArray[indexPath.row];
    NSData * data = [NSData dataWithContentsOfURL:[NSURL URLWithString:model.particularsPicture]];
    UIImage *image = [UIImage imageWithData:data];
    NSLog(@"宽%f,高%f",image.size.width,image.size.height);
    if (image.size.height == 0) {
        vc.imageheight = 0;
    }else
    {
        vc.imageheight = image.size.height*SCREEN_WIDTH/image.size.width;
    }
    
    vc.roomModel = model;
    vc.spaceSourceType = SPACE_SOURCE_TYPE_OTHER;
    [WOTSingtleton shared].orderType = ORDER_TYPE_LONGTIME_BOOKSTATION;
    [self.navigationController pushViewController:vc animated:YES];
}

-(UITableView *)roomListTableView
{
    if (_roomListTableView == nil) {
        _roomListTableView = [[UITableView alloc] init];
        _roomListTableView.delegate = self;
        _roomListTableView.dataSource = self;
        //[_roomListTableView setTableFooterView:[UIView new]];
        _roomListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    }
    return _roomListTableView;
}

#pragma mark - 请求房间列表
-(void)creatquestData
{
    __weak typeof(self) weakSelf = self;
    [WOTHTTPNetwork queryRoomListWithSpaceId:self.spaceModel.spaceId response:^(id bean, NSError *error) {
        SKRoomModel_msg *model_msg = (SKRoomModel_msg *)bean;
        if ([model_msg.code isEqualToString:@"200"]) {
            self.roomArray = [model_msg.msg.list mutableCopy];
            [weakSelf.roomListTableView reloadData];
        }
    }];
}

@end
