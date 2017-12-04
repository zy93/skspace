//
//  WOTIntelligenceDeviceListVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/25.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTIntelligenceDeviceListVC.h"
#import "WOTAirconditioningCell.h"
#import "WOTInteligenceDeviceCommonCell.h"
#import "WOTCurtainCell.h"
#import "WOTLightCell.h"
#import "WOTDeviceListRequestTool.h"

@interface WOTIntelligenceDeviceListVC ()<UITableViewDelegate,UITableViewDataSource,WOTAirconditioningDelegate,WOTLightCellDelegate,WOTCurtainCellDelegate,SRWebSocketDelegate>{
    BOOL airConditionOpen;
    BOOL curtainsOpen;
    BOOL lightOpen;
    NSInteger lightcellindex;
    NSMutableArray *lightSelectedindex;
    
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property(nonatomic,strong)WOTDeviceListRequestTool *deviceListTool;
@property(nonatomic,strong) NSArray<WOTDeviceInfoModel *> *deviceArray;
@property(nonatomic,strong)WOTDeviceInfoModel *currentdeviceInfo;
@property(nonatomic,strong)NSString *currentdeviceUrl;
@property(nonatomic,strong)NSNumber *groupId;
@end

@implementation WOTIntelligenceDeviceListVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"设备列表";
    [_tableView registerNib:[UINib nibWithNibName:@"WOTAirconditioningCell" bundle:nil] forCellReuseIdentifier:@"WOTAirconditioningCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTInteligenceDeviceCommonCell" bundle:nil] forCellReuseIdentifier:@"WOTInteligenceDeviceCommonCellID"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTCurtainCell" bundle:nil] forCellReuseIdentifier:@"WOTCurtainCell"];
    [_tableView registerNib:[UINib nibWithNibName:@"WOTLightCell" bundle:nil] forCellReuseIdentifier:@"WOTLightCell"];
    airConditionOpen = NO;
    curtainsOpen = NO;
    lightOpen = NO;
    lightSelectedindex = [[NSMutableArray alloc]init];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    switch (section) {
        case 0:
            return 2;
            break;
        case 1:
            return 2;
            break;
        case 2:
            return 2;
            break;
        default:
            break;
    }
    return 0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
  
    switch (indexPath.section) {
        case 0:
            if (indexPath.row == 0) {
                  return airConditionOpen?350:50;
            } else if (indexPath.row == 1){
                return curtainsOpen? 190:50;
            }
            break;
        case 1:
            if (lightOpen) {
                  return lightcellindex == indexPath.row?175:50;
            } else {
                return 50;
            }
          
        break;
        case 2:
            return 60;
            break;
        default:
            break;
    }
    return  0;
}


-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 0){
        return 0.01;
    } else {
        return  10;
    }
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell *commoncell;
    if (indexPath.section == 0) {
        if (indexPath.row == 0) {
            WOTAirconditioningCell *aircell = [tableView dequeueReusableCellWithIdentifier:@"WOTAirconditioningCellID" forIndexPath:indexPath];
            aircell.delegate = self;
            [aircell.cellSwitch setOn:airConditionOpen];
            aircell.bgview.hidden = !airConditionOpen;
            [aircell.lowBtn setTitleColor:aircell.lowBtn.isSelected?InteligenceDeviceSelectedColor:HighTextColor forState:UIControlStateNormal];
            
            commoncell = aircell;
        } else {
           WOTCurtainCell  *cutaincell = [tableView dequeueReusableCellWithIdentifier:@"WOTCurtainCell" forIndexPath:indexPath];
            cutaincell.titleLab.text = @"窗帘";
            cutaincell.delegate = self;
            [cutaincell.switchSW setOn:curtainsOpen];
            cutaincell.contentBGView.hidden = !curtainsOpen;
            commoncell = cutaincell;
        }
            
    } else if (indexPath.section == 2) {
        
        WOTInteligenceDeviceCommonCell *cell = [tableView dequeueReusableCellWithIdentifier:@"WOTInteligenceDeviceCommonCellID" forIndexPath:indexPath];
        cell.cellImage.image = [UIImage imageNamed:@"jack"];
        cell.cellTitle.text = @[@"1号插座",@"2号插座"][indexPath.row];
        commoncell = cell;
    } else if (indexPath.section == 1) {
        WOTLightCell *lightCell = [tableView dequeueReusableCellWithIdentifier:@"WOTLightCell" forIndexPath:indexPath];
        lightCell.iconImg.image = [UIImage imageNamed:@"lights"];
        lightCell.titleLab.text = @[@"1号灯",@"2号灯"][indexPath.row];
        lightCell.index = indexPath.row;
        lightCell.delegate = self;
        
      
        if (lightcellindex == indexPath.row && lightOpen ) {
              lightCell.contentBGView.hidden = NO;
            [lightCell.switchSW setOn:YES];
        } else {
              lightCell.contentBGView.hidden = YES;
            [lightCell.switchSW setOn:NO];
        }
        if (indexPath.row == lightcellindex) {
            [lightCell.switchSW setOn:lightOpen];
        }
        
        commoncell = lightCell;
    }
    return  commoncell;
}

/**
 *  aircondition delegate
*/
-(void)switchChangeState:(BOOL)switchState{
    airConditionOpen = switchState;
    if (airConditionOpen) {
        curtainsOpen = NO;
        lightOpen = NO;
    }
    [_tableView reloadData];
    
}
-(void)curtaincellOfSwitch:(WOTCurtainCell *)cell option:(BOOL)isOn{
    curtainsOpen = isOn;
    if (curtainsOpen) {
        airConditionOpen = NO;
        lightOpen = NO;
    }
    [_tableView reloadData];
}
-(void)lightcellOfSwitch:(NSInteger)index option:(BOOL)isOn{
    lightOpen = isOn;
    if (lightOpen) {
        airConditionOpen = NO;
        curtainsOpen = NO;
    }
    lightcellindex = index;
    if (isOn == YES ) {
        [lightSelectedindex addObject:[NSString stringWithFormat:@"%ld",index]];
    }
    if ([lightSelectedindex containsObject:[NSString stringWithFormat:@"%ld",index]] && isOn == NO) {
        [lightSelectedindex removeObject:[NSString stringWithFormat:@"%ld",index]];
    }
    [_tableView reloadData];
}



//MARK: device net connect


-(void)sendRequest{
    __weak typeof(self) weakself = self;
    self.deviceListTool = [WOTDeviceListRequestTool new];
    [self.deviceListTool sendRequestToGetAllDeviceWithGroupId:self.groupId Response:^(NSArray *arr) {
        dispatch_async(dispatch_get_main_queue(), ^{
            
            if (arr) {
                
                weakself.deviceArray = arr;
                dispatch_async(dispatch_get_main_queue(), ^{
                    [weakself.tableView reloadData];
                });
            }
            
        });
    }];
    
}


#pragma mark SRWebSocekt

-(void)webSocketDidOpen:(SRWebSocket *)webSocket{
    [MBProgressHUDUtil showMessage:@"设备连接成功" toView:self.view];
    
    
}
- (void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithString:(NSString *)string{
    NSLog(@"%@",string);
    if ([string containsString:@"thing not online"]) {
        [MBProgressHUDUtil showMessage:@"设备不在线" toView:self.view];
    }
}
-(void)webSocket:(SRWebSocket *)webSocket didReceiveMessageWithData:(NSData *)data{
    NSLog(@"%@",data);
}
-(void)webSocket:(SRWebSocket *)webSocket didFailWithError:(NSError *)error{
    NSLog(@"%@",error.userInfo);
   [MBProgressHUDUtil showMessage:@"网络连接错误" toView:self.view];
}

-(void)confitWebSocketUrl{
    
    //配置websocket
    if (self.currentdeviceInfo) {
        self.currentdeviceUrl = self.currentdeviceInfo.harborIp;
    }
    //截取ip
    NSRange range = [self.currentdeviceUrl rangeOfString:@":"];
    if (range.length>0) {
        self.currentdeviceUrl = [self.currentdeviceUrl substringWithRange:NSMakeRange(0, range.location)];
    }
    //加前缀
    if(![self.currentdeviceUrl containsString:@"ws://"]){
        self.currentdeviceUrl = [@"ws://" stringByAppendingString:self.currentdeviceUrl];
    }
    NSLog(@"%@",self.currentdeviceUrl);
    //加后缀
    self.currentdeviceUrl = [self.currentdeviceUrl stringByAppendingString:@":8999/IotHarborWebsocket"];
    self.webSocket = [[SRWebSocket alloc]initWithURL:[NSURL URLWithString:self.currentdeviceUrl]];
    self.webSocket.delegate = self;
    [self.webSocket open];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    [self.webSocket close];
}

/**字典转json*/
-(NSString*)dictionaryToJson:(NSDictionary *)dic

{
    
    NSError *parseError = nil;
    
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:dic options:NSJSONWritingPrettyPrinted error:&parseError];
    
    return [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
}
-(void)sendWebSocketStringWithParam:(NSDictionary*)param{
    
    NSString *sendStr = [self dictionaryToJson:param];
    NSError *error = [NSError new];
    NSLog(@"%@",sendStr);
    [self.webSocket sendString:sendStr error:&error];
    if (error.userInfo.allKeys.count>0) {
        NSLog(@"%@",error.userInfo);
        [MBProgressHUDUtil showMessage:@"发送错误" toView:self.view];
        
    }
}

-(NSString *)imageAddExStr:(NSString *)imageStr{
    NSString *exStr = [imageStr pathExtension];
    NSString *temp = [imageStr stringByDeletingPathExtension];
    temp = [temp stringByAppendingString:@"1"];
    temp = [temp stringByAppendingPathComponent:exStr];
    if (![temp containsString:@"http://"]&&[temp containsString:@"http:/"]) {
        temp = [temp stringByReplacingOccurrencesOfString:@"http:/" withString:@"http://"];
    }
    return temp;
}

#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    
//    
//}
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
//}
//*/

@end
