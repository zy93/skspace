//
//  WOTVisitorsAppointmentVC.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/3.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "WOTVisitorsAppointmentVC.h"
#import "WOTVisitorsAppointmentCell.h"
#import "WOTVisitTypeCell.h"
#import "WOTPhotosBaseUtils.h"
#import "WOTSelectWorkspaceListVC.h"//1
#import "WOTVisitorsAppointmentSubmitCell.h"
#import "WOTRadioView.h"
#import "WOTDatePickerView.h"
#import "WOTVisitorsModel.h"
#import "WOTConstants.h"
#import "JudgmentTime.h"
#import "WOTElasticityView.h"
#import "WOTPickerView.h"
#import "WOTSearchMemberVC.h"

@interface WOTVisitorsAppointmentVC ()<UIScrollViewDelegate, WOTVisitorsAppointmentSubmitCellDelegate, WOTVisitorsAppointmentCellDelegate, WOTVisitTypeCellDelegate, WOTPickerViewDelegate, WOTPickerViewDataSource>
{
    NSArray *tableList;
    NSArray *tableSubtitleList;
    NSMutableArray *contentList;
    NSString *time;
    UIImage *headImage;
    CGFloat topViewHeight;
    NSArray *pickerData;
    BOOL isSelectSex;
}
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet WOTElasticityView *topView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *topViewHeightConstraints;
@property (weak, nonatomic) IBOutlet UIView *contentBGView;
@property (weak, nonatomic) IBOutlet UIButton *headBtn;

@property (weak, nonatomic) IBOutlet UIView *nameBGView;
@property (weak, nonatomic) IBOutlet UITextField *nameText;


@property (weak, nonatomic) IBOutlet UIView *genderBGView;
@property (weak, nonatomic) IBOutlet UILabel *genderValueLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseGenderBtn;

@property (weak, nonatomic) IBOutlet UIView *telBGView;
@property (weak, nonatomic) IBOutlet UITextField *telText;

@property (weak, nonatomic) IBOutlet UIView *communityBGView;
@property (weak, nonatomic) IBOutlet UILabel *communityValueLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseCommunityBtn;

@property (weak, nonatomic) IBOutlet UIView *accessTypeBGView;
@property (weak, nonatomic) IBOutlet UILabel *accessTypeValueLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseAccessTypeBtn;

@property (weak, nonatomic) IBOutlet UIView *accessTargetBGView;
@property (weak, nonatomic) IBOutlet UILabel *accessTargetValueLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseAccessTargetBtn;

@property (weak, nonatomic) IBOutlet UIView *accessReasonBGView;
@property (weak, nonatomic) IBOutlet UITextField *accessReasonText;

@property (weak, nonatomic) IBOutlet UIView *accessNumberBGView;
@property (weak, nonatomic) IBOutlet UITextField *accessNumberText;

@property (weak, nonatomic) IBOutlet UIView *accessDateBGView;
@property (weak, nonatomic) IBOutlet UILabel *accessDateValueLab;
@property (weak, nonatomic) IBOutlet UIButton *chooseAccessDateBtn;

@property (weak, nonatomic) IBOutlet UIButton *commitBtn;

@property (nonatomic, strong) WOTDatePickerView *datepickerview;
@property (nonatomic, strong) JudgmentTime *judgmentTime;
@property (nonatomic, strong) WOTPickerView *pickerView;
@property (nonatomic, assign) BOOL isValidTime;
@end

@implementation WOTVisitorsAppointmentVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    CGFloat radius = 5.f;
    
    [self addShadowWith:self.nameBGView];
    [self addShadowWith:self.genderBGView];
    [self addShadowWith:self.telBGView];
    [self addShadowWith:self.communityBGView];
    [self addShadowWith:self.accessTypeBGView];
    [self addShadowWith:self.accessTargetBGView];
    [self addShadowWith:self.accessReasonBGView];
    [self addShadowWith:self.accessNumberBGView];
    [self addShadowWith:self.accessDateBGView];
    self.contentBGView.layer.cornerRadius =radius;
//    self.contentBGView.hidden = YES;
    self.contentBGView.backgroundColor = UIColorFromRGB(0xf1f1f1);
    self.topView.backgroundColor = UIColorFromRGB(0xff7371);
    topViewHeight = self.topViewHeightConstraints.constant;
    self.commitBtn.layer.cornerRadius = 5.f;

    
    [self configNav];
    [self setupView];
    [self addData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [self.navigationController.navigationBar setHidden:NO];
    self.judgmentTime = [[JudgmentTime alloc] init];
}

-(void)configNav{
    self.navigationItem.title = @"访客预约";
    
    //navi颜色
    self.navigationController.navigationBar.translucent = YES;
    UIColor *color = [UIColor clearColor];
    CGRect rect = CGRectMake(0, 0, SCREEN_WIDTH, 64);
    UIGraphicsBeginImageContext(rect.size);
    CGContextRef context = UIGraphicsGetCurrentContext();
    CGContextSetFillColorWithColor(context, color.CGColor);
    CGContextFillRect(context, rect);
    UIImage *image = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();
    [self.navigationController.navigationBar setBackgroundImage:image forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = YES;
    
//    //解决布局空白问题
//    BOOL is7Version=[[[UIDevice currentDevice]systemVersion] floatValue] >= 7.0 ? YES : NO;
//    if (is7Version) {
//        self.edgesForExtendedLayout=UIRectEdgeNone;
//    }
}




-(void)setupView
{
    __weak typeof(self) weakSelf = self;
    _datepickerview = [[NSBundle mainBundle]loadNibNamed:@"WOTDatePickerView" owner:nil options:nil].lastObject;
    [_datepickerview setFrame:CGRectMake(0, self.view.frame.size.height - 300, self.view.frame.size.width, 300)];
    _datepickerview.cancelBlokc = ^(){
        weakSelf.datepickerview.hidden = YES;
    };
    _datepickerview.okBlock = ^(NSInteger year,NSInteger month,NSInteger day,NSInteger hour,NSInteger min){
        weakSelf.datepickerview.hidden = YES;
        NSLog(@"%ld年%ld月%ld日",year,month,day);
        weakSelf.isValidTime = [self.judgmentTime judgementTimeWithYear:year month:month day:day];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (self.isValidTime) {
                time = [NSString stringWithFormat:@"%02d/%02d/%02d ",(int)year, (int)month, (int)day];

                _datepickerview.hidden  = YES;
            }else
            {
                [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:self.view];
                time = @"";
                _datepickerview.hidden  = NO;
            }
        });
    };
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden = YES;
 
}

-(void)addData
{
    tableList = @[@"访客照片", @"姓名", @"性别", @"手机号码", @"访问社区", @"访问类型", @"受访对象", @"来访事由", @"到访人数", @"到访日期", @"提交"];
    contentList = [NSMutableArray new];
    for (int i=0; i<tableList.count; i++) {
        [contentList addObject:@""];
    }
    [contentList replaceObjectAtIndex:2 withObject:@"男"];
    [contentList replaceObjectAtIndex:5 withObject:@(2)];
    tableSubtitleList = @[@"", @"必填", @"MAN", @"必填", @"请选择", @"", @"必填", @"必填", @"必填", @"请选择"];
}

-(void)addShadowWith:(UIView *)view
{
    view.backgroundColor = UIColorFromRGB(0xe1e1e1);
    view.layer.borderWidth = 1.f;
    view.layer.borderColor = UIColorFromRGB(0xcccccc).CGColor;
    view.layer.cornerRadius =5.f;
    view.layer.shadowColor = UIColorFromRGB(0xd5d5d5).CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,0);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowRadius = 3;//阴影半径，默认3
    view.layer.shadowOpacity = 1.f;//阴影透明度，默认0
}


#pragma mark - UIImagePickerControllerDelegate

// 拍照完成回调
- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingImage:(UIImage *)image editingInfo:(nullable NSDictionary<NSString *,id> *)editingInfo NS_DEPRECATED_IOS(2_0, 3_0)
{
    
    if(picker.sourceType == UIImagePickerControllerSourceTypeCamera)
    {
        UIImageWriteToSavedPhotosAlbum(image, nil, nil, nil);
    }
    
//    enterpriseLogoPath = editingInfo[UIImagePickerControllerReferenceURL];
//    tableInputDatadic[@"firmLogo"] = enterpriseLogoPath;
    headImage = image;
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

//进入拍摄页面点击取消按钮
- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}


#pragma  mark - action

- (IBAction)selectSex:(id)sender {
    pickerData = @[@"男", @"女"];
    isSelectSex = YES;
    [self.pickerView reloadData];
    [self.pickerView popPickerView];

}
- (IBAction)selectSpace:(id)sender {
    UIViewController *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSelectWorkspaceListVC"];
    __weak typeof(self) weakSelf = self;
    WOTSelectWorkspaceListVC *lc = (WOTSelectWorkspaceListVC*)vc;//1
    lc.selectSpaceBlock = ^(WOTSpaceModel *model){
        weakSelf.spaceId = model.spaceId;
        weakSelf.spaceName = model.spaceName;
        weakSelf.communityValueLab.text = weakSelf.spaceName;
        
    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)selectType:(id)sender {
    pickerData = @[@"商务", @"面试", @"私人", @"参观"];
    isSelectSex = NO;
    [self.pickerView reloadData];
    [self.pickerView popPickerView];
}
- (IBAction)selectMember:(id)sender {
    
    if (!self.spaceId) {
        [MBProgressHUDUtil showMessage:@"请选择访问空间！" toView:self.view];
        return;
    }
    
    WOTSearchMemberVC *vc = (WOTSearchMemberVC*)[[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSearchMemberVC"];
    vc.spaceId = self.spaceId;
    vc.selectMemberBlock = ^(WOTLoginModel *model) {
        
    };
    [self.navigationController pushViewController:vc animated:YES];
}


#pragma mark - cell delegate
-(void)submitVisitorInfo:(WOTVisitorsAppointmentSubmitCell *)cell
{
    NSString *visitorName = contentList[1];
    NSString *sex = contentList[2];
    NSString *tel = contentList[3];
    NSNumber *spaceId = self.spaceId;
    NSNumber *type = contentList[5];
    NSString *userName = contentList[6];
    NSString *visitorInfo =contentList[7];
    NSNumber *number = contentList[8];
    NSString *tim = time;
    
    if (strIsEmpty(visitorName)) {
        [MBProgressHUDUtil showMessage:@"姓名不能为空" toView:self.view];
        return;
    }else if (strIsEmpty(tel)) {
        [MBProgressHUDUtil showMessage:@"电话不能为空" toView:self.view];
        return;
        
    }else if (spaceId.integerValue<=0) {
        if (![NSString valiMobile:tel]) {
            [MBProgressHUDUtil showMessage:@"电话格式不正确！" toView:self.view];
            return;
        }
        [MBProgressHUDUtil showMessage:@"请选择访问社区" toView:self.view];
        return;
    }else if (strIsEmpty(userName)) {
        [MBProgressHUDUtil showMessage:@"请选择访问对象" toView:self.view];
        return;
    }else if (strIsEmpty(visitorInfo)) {
        [MBProgressHUDUtil showMessage:@"请输入访问事由" toView:self.view];
        return;
    }else if (number.integerValue<=0) {
        [MBProgressHUDUtil showMessage:@"请输入到访人数" toView:self.view];
        return;
    }else if (strIsEmpty(tim)){
        [MBProgressHUDUtil showMessage:@"请选择到访日期" toView:self.view];
        return;
    }
    
    
    [MBProgressHUDUtil showLoadingWithMessage:@"请稍后" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [WOTHTTPNetwork visitorAppointmentWithVisitorName:visitorName headPortrait:headImage sex:sex papersType:@(0) papersNumber:@"123456" tel:tel spaceId:spaceId accessType:type userName:userName visitorInfo:visitorInfo peopleNum:number visitTime:tim response:^(id bean, NSError *error) {
            WOTVisitorsModel *model = bean;
            if (model.code.integerValue==200) {
                [hud setLabelText:@"信息已提交，请等待管理人员审核"];
                [hud hide:YES afterDelay:2.f];
                
            }
        }];
    }];
    
    
}

-(void)textFiledEndEnter:(WOTVisitorsAppointmentCell *)cell text:(NSString *)text
{
    if (!text) {
        return;
    }
    [contentList replaceObjectAtIndex:cell.index.row withObject:text];
}

-(void)selectVisitType:(WOTVisitTypeCell *)cell type:(NSInteger)type
{
    [contentList replaceObjectAtIndex:cell.index.row withObject:@(type)];
}

#pragma mark - scrollview delegate
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    //通过滑动的便宜距离重新给图片设置大小
    CGFloat yOffset = scrollView.contentOffset.y + 64;
    if((yOffset<0 && yOffset > -100) ||
       (yOffset>0 && yOffset<60) )
    {
        CGFloat height = topViewHeight;
        height = height - yOffset;
//        self.topViewHeightConstraints.constant = height;
        [self.topView scrollViewPoint:CGPointMake(0, -yOffset) isEnd:NO];
    }
}

-(void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView
{
//    [self.topView scrollViewPoint:CGPointMake(0, 0) isEnd:YES];
}

//#pragma mark - 处理键盘遮挡问题
//- (UITableView *)table {
//    if (!_table) {
//        UITableViewController* tvc=[[UITableViewController alloc] initWithStyle:UITableViewStylePlain];
//        [self addChildViewController:tvc];
//        [tvc.view setFrame:self.view.frame];
//        _table=tvc.tableView;
//        _table.delegate = self;
//        _table.dataSource = self;
//        _table.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
//    }
//    return _table;
//}

//-(UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
//{
//    UIView *view = [UIView new];
//    return view;
//}

#pragma mark - picker delegate
-(NSInteger)numberOfComponentsInPickerView:(WOTPickerView *)pickerView
{
    return 1;
}
-(NSInteger)pickerView:(WOTPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return pickerData.count;
}

-(NSString *)pickerView:(WOTPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return pickerData[row];
}

-(void)pickerView:(WOTPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"-----%@",pickerData[row]);
    if (isSelectSex) {
        self.genderValueLab.text = pickerData[row];
    }
    else {
        self.accessTypeValueLab.text = pickerData[row];
    }
}

-(WOTPickerView *)pickerView
{
    if (!_pickerView) {
        _pickerView = [[WOTPickerView alloc] init];
        _pickerView.dataSource = self;
        _pickerView.delegate = self;
        [self.view addSubview:_pickerView];
        [_pickerView popPickerView];
    }
    return  _pickerView;
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
