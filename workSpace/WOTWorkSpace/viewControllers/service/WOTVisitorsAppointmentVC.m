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
#import "WOTAppointmentModel.h"
#import "WOTConstants.h"
#import "JudgmentTime.h"
#import "WOTElasticityView.h"
#import "WOTPickerView.h"
#import "WOTSearchMemberVC.h"
#import "WOTVisitorsResultVC.h"

@interface WOTVisitorsAppointmentVC ()<UIScrollViewDelegate, WOTPickerViewDelegate, WOTPickerViewDataSource>
{
    UIImage *headImage;
    CGFloat topViewHeight;
    UITextField *temporarilyText;
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
@property (nonatomic, strong) NSArray *pickerData;

@property (nonatomic, assign) BOOL isValidTime;
@property (nonatomic, strong) NSString *visitTime;
@property (nonatomic, strong) NSString *spaceName;
@property (nonatomic, strong) NSNumber *spaceId;
@property (nonatomic, strong) NSNumber *accessType;
@property (nonatomic, strong) WOTLoginModel *userModel;

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
    
    self.genderValueLab.textColor = UICOLOR_MAIN_TEXT_PLACEHOLDER;
    self.communityValueLab.textColor = UICOLOR_MAIN_TEXT_PLACEHOLDER;
    self.accessTypeValueLab.textColor = UICOLOR_MAIN_TEXT_PLACEHOLDER;
    self.accessTargetValueLab.textColor = UICOLOR_MAIN_TEXT_PLACEHOLDER;
    self.accessDateValueLab.textColor = UICOLOR_MAIN_TEXT_PLACEHOLDER;

    self.contentBGView.layer.cornerRadius =radius;
    self.accessNumberText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.telText.keyboardType = UIKeyboardTypeNumbersAndPunctuation;
    self.contentBGView.backgroundColor = UICOLOR_GRAY_F1;
//    self.topView.backgroundColor = UICOLOR_MAIN_ORANGE;
    topViewHeight = self.topViewHeightConstraints.constant;
    self.commitBtn.layer.cornerRadius = 5.f;
    temporarilyText = [[UITextField alloc]init];
    temporarilyText.hidden = YES;
    [self.view addSubview:temporarilyText];
    
    [self setupView];
}

- (NSArray *)getRGBWithColor:(UIColor *)color
{
    CGFloat red = 0.0;
    CGFloat green = 0.0;
    CGFloat blue = 0.0;
    CGFloat alpha = 0.0;
    [color getRed:&red green:&green blue:&blue alpha:&alpha];
    return @[@(red), @(green), @(blue), @(alpha)];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
    self.judgmentTime = [[JudgmentTime alloc] init];
    [self configNav];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self clearNav];
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
}

-(void)clearNav {
    self.navigationController.navigationBar.translucent = NO;
    [self.navigationController.navigationBar setBackgroundImage:nil forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.clipsToBounds = NO;
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
        weakSelf.isValidTime = [weakSelf.judgmentTime judgementTimeWithYear:year month:month day:day];
        dispatch_async(dispatch_get_main_queue(), ^{
            if (weakSelf.isValidTime) {
                weakSelf.visitTime = [NSString stringWithFormat:@"%02d/%02d/%02d ",(int)year, (int)month, (int)day];
                weakSelf.accessDateValueLab.text = weakSelf.visitTime;
                weakSelf.accessDateValueLab.textColor = UICOLOR_BLACK;
                weakSelf.datepickerview.hidden  = YES;
            }else
            {
                [MBProgressHUDUtil showMessage:@"请选择有效时间！" toView:weakSelf.view];
                weakSelf.visitTime = @"";
                weakSelf.datepickerview.hidden  = NO;
            }
        });
    };
    [self.view addSubview:_datepickerview];
    _datepickerview.hidden = YES;
 
}

-(void)addShadowWith:(UIView *)view
{
    view.backgroundColor = UICOLOR_GRAY_E1;
    view.layer.borderWidth = 1.f;
    view.layer.borderColor = UICOLOR_GRAY_CC.CGColor;
    view.layer.cornerRadius =5.f;
    view.layer.shadowColor = UICOLOR_GRAY_99.CGColor;//shadowColor阴影颜色
    view.layer.shadowOffset = CGSizeMake(0,3);//shadowOffset阴影偏移,x向右偏移4，y向下偏移4，默认(0, -3),这个跟shadowRadius配合使用
    view.layer.shadowRadius = 3.f;//阴影半径，默认3
    view.layer.shadowOpacity = .5f;//阴影透明度，默认0
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
    self.pickerData = @[@"男", @"女"];
    isSelectSex = YES;
    [self.pickerView reloadData];
    __weak typeof(self) weakSelf = self;
    self.pickerView.selectBlock = ^(BOOL status, NSInteger row) {
        if (status) {
            weakSelf.genderValueLab.text = weakSelf.pickerData[row];
            weakSelf.genderValueLab.textColor = UICOLOR_BLACK;

        }
    };
    [temporarilyText becomeFirstResponder];
    [temporarilyText resignFirstResponder];
    _datepickerview.hidden = YES;
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
        weakSelf.communityValueLab.textColor = UICOLOR_BLACK;

    };
    [self.navigationController pushViewController:vc animated:YES];
    
}
- (IBAction)selectType:(id)sender {
    self.pickerData = @[@"商务", @"面试", @"私人", @"参观"];
    isSelectSex = NO;
    [self.pickerView reloadData];
    __weak typeof(self) weakSelf = self;
    self.pickerView.selectBlock = ^(BOOL status, NSInteger row) {
        if (status) {
            weakSelf.accessTypeValueLab.text = weakSelf.pickerData[row];
            weakSelf.accessType = @(row);
            weakSelf.accessTypeValueLab.textColor = UICOLOR_BLACK;

        }
    };
    [temporarilyText becomeFirstResponder];
    [temporarilyText resignFirstResponder];
    [self.pickerView popPickerView];
}
- (IBAction)selectMember:(id)sender {
    
    if (!self.spaceId) {
        [MBProgressHUDUtil showMessage:@"请选择访问空间！" toView:self.view];
        return;
    }
    __weak typeof(self) weakSelf = self;

    WOTSearchMemberVC *vc = (WOTSearchMemberVC*)[[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTSearchMemberVC"];
    vc.spaceId = self.spaceId;
    vc.selectMemberBlock = ^(WOTLoginModel *model) {
        weakSelf.accessTargetValueLab.text = model.userName;
        weakSelf.accessTargetValueLab.textColor = UICOLOR_BLACK;
        weakSelf.userModel = model;
    };
    [self.navigationController pushViewController:vc animated:YES];
}

- (IBAction)selectDate:(id)sender {
    [temporarilyText becomeFirstResponder];
    [temporarilyText resignFirstResponder];
    _datepickerview.hidden  = NO;
}

- (IBAction)submit:(id)sender {
    NSString *visitorName = self.nameText.text;
    NSString *sex = self.genderValueLab.text;
    NSString *tel = self.telText.text;
    NSNumber *spaceId = self.spaceId;
    NSNumber *type = self.accessType;
    NSString *userName = self.accessTargetValueLab.text;
    NSString *visitorInfo = self.accessReasonText.text;
    NSNumber *number = @(self.accessNumberText.text.integerValue);
    NSString *tim = self.visitTime;
    
    if (strIsEmpty(visitorName)) {
        [MBProgressHUDUtil showMessage:@"请输入访客姓名" toView:self.view];
        return;
    }else if (strIsEmpty(sex) || [sex isEqualToString:@"请选择"]) {
        [MBProgressHUDUtil showMessage:@"请选择性别" toView:self.view];
        return;
        
    }else if (strIsEmpty(tel)) {
        [MBProgressHUDUtil showMessage:@"请输入访客电话" toView:self.view];
        return;
        
    }else if (spaceId.integerValue<=0) {
        if (![NSString valiMobile:tel]) {
            [MBProgressHUDUtil showMessage:@"电话格式不正确" toView:self.view];
            return;
        }
        [MBProgressHUDUtil showMessage:@"请选择访问社区" toView:self.view];
        return;
    }else if (!type) {
        [MBProgressHUDUtil showMessage:@"请选择访问类型" toView:self.view];
        return;
        
    }else if (strIsEmpty(userName) || [userName isEqualToString:@"请选择"]) {
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
    
//    __weak typeof(self) weakSelf = self;
    WOTVisitorsResultVC *vc = [[UIStoryboard storyboardWithName:@"Service" bundle:nil] instantiateViewControllerWithIdentifier:@"WOTVisitorsResultVC"];

    [MBProgressHUDUtil showLoadingWithMessage:@"请稍后" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        
        [WOTHTTPNetwork visitorAppointmentWithVisitorName:visitorName sex:sex tel:tel  spaceId:self.spaceId spaceName:self.spaceName accessType:type targetName:userName targetId:self.userModel.userId targetAlias:self.userModel.alias visitorInfo:visitorInfo peopleNum:number visitTime:tim response:^(id bean, NSError *error) {
            WOTVisitorsModel *model = bean;
            if ([model.code isEqualToString:@"200"]) {
                vc.isSuccess = YES;
            }
            else {
                vc.isSuccess = NO;
            }
            [hud hide:YES];
            [self.navigationController pushViewController:vc animated:YES];
        }];
    }];
    
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
    return self.pickerData.count;
}

-(NSString *)pickerView:(WOTPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return self.pickerData[row];
}

-(void)pickerView:(WOTPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    NSLog(@"-----%@",self.pickerData[row]);
    if (isSelectSex) {
        self.genderValueLab.text = self.pickerData[row];
        self.genderValueLab.textColor = UICOLOR_BLACK;

    }
    else {
        self.accessTypeValueLab.text = self.pickerData[row];
        self.accessTypeValueLab.textColor = UICOLOR_BLACK;

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
