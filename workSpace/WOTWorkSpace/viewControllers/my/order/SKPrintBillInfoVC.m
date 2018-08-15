//
//  SKPrintBillInfoVC.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 14/8/18.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKPrintBillInfoVC.h"
#import "UIColor+ColorChange.h"
#import "SKReceiptCell.h"
#import "SKReceiptStateCell.h"

@interface SKPrintBillInfoVC ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>

/* */
@property (nonatomic,strong) UITableView *tableView;
/* */
@property (nonatomic,strong) UIButton *submitButton;

@property (nonatomic,copy) NSArray *titleArray;

/*发票类型*/
@property (nonatomic,copy) NSString *receiptStateStr;
/*发票抬头*/
@property (nonatomic,copy) NSString *receiptTitleStr;
/*企业税号*/
@property (nonatomic,copy) NSString *dutyParagraphStr;
@end

@implementation SKPrintBillInfoVC

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView setTableFooterView:[UIView new]];
    self.view.backgroundColor = [UIColor colorWithRed:0.94 green:0.94 blue:0.96 alpha:1.00];
    self.navigationItem.title = @"发票信息";
    if (strIsEmpty(self.model.invoiceType)) {
        self.receiptStateStr = @"个人";
    }else
    {
       self.receiptStateStr = self.model.invoiceType;
    }
    
    if ([self.printBillState isEqualToString:@"未开"]) {
        self.submitButton.hidden = NO;
    } else {
        self.submitButton.hidden = YES;
    }
    
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.submitButton];
    [self layoutSubviews];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKReceiptCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKReceiptCell"];
    [self.tableView registerNib:[UINib nibWithNibName:@"SKReceiptStateCell" bundle:[NSBundle mainBundle]] forCellReuseIdentifier:@"SKReceiptStateCell"];
}

-(void)layoutSubviews
{
    [self.tableView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.bottom.equalTo(self.submitButton.mas_top);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view.mas_bottom).with.offset(-10);
        make.height.mas_offset(48);
    }];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.titleArray.count;
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row == 0) {
        SKReceiptStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKReceiptStateCell"];
        if (cell == nil) {
            cell = [[SKReceiptStateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SKReceiptStateCell"];
        }
        [cell.receiptState setTitle:self.printBillState forState:UIControlStateNormal];
        cell.receiptState.userInteractionEnabled = NO;
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }else if (indexPath.row == 1)
    {
        SKReceiptStateCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKReceiptStateCell"];
        if (cell == nil) {
            cell = [[SKReceiptStateCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SKReceiptStateCell"];
        }
        [cell.receiptState setTitle:self.receiptStateStr forState:UIControlStateNormal];
        cell.receiptState.indexPath = indexPath;
        [cell.receiptState addTarget:self action:@selector(chooseReceipt:) forControlEvents:UIControlEventTouchUpInside];
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
    else
    {
        SKReceiptCell *cell = [tableView dequeueReusableCellWithIdentifier:@"SKReceiptCell"];
        if (cell == nil) {
            cell = [[SKReceiptCell alloc] initWithStyle:UITableViewCellStyleValue1 reuseIdentifier:@"SKReceiptCell"];
        }
        cell.infoTextField.delegate = self;
        if (indexPath.row == 2) {
            cell.infoTextField.text = self.model.invoiceTitle;
        }else
        {
            cell.infoTextField.text = self.model.invoiceTaxNum;
        }
        
        cell.titleLabel.text = self.titleArray[indexPath.row];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
        return cell;
    }
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    if ([self.printBillState isEqualToString:@"未开"]) {
        UITableViewCell *cell = (UITableViewCell *)[textField superview];
        NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
        if ([self.receiptStateStr isEqualToString:@"企业"]) {
            if(indexPath.row == 2){
                self.receiptTitleStr = textField.text;
            }else if (indexPath.row == 3){
                self.dutyParagraphStr = textField.text;
            }
        }else
        {
            if(indexPath.row == 2){
                self.receiptTitleStr = textField.text;
            }
        }
        
        return YES;
    }
    else
    {
        return NO;
    }
    
}

-(BOOL)textFieldShouldEndEditing:(UITextField *)textField
{
    SKReceiptCell *cell = (SKReceiptCell *)[[textField superview] superview];
    NSIndexPath *indexPath = [self.tableView indexPathForCell:cell];
    if ([self.receiptStateStr isEqualToString:@"公司"]) {
        if(indexPath.row == 2){
            self.receiptTitleStr = textField.text;
        }else if (indexPath.row == 3){
            self.dutyParagraphStr = textField.text;
        }
    }else
    {
        if(indexPath.row == 2){
            self.receiptTitleStr = textField.text;
        }
    }
    
    return YES;
}

-(void)submitBtn
{
    if ([self.receiptStateStr isEqualToString:@"个人"]) {
        if (strIsEmpty(self.receiptTitleStr)) {
            [MBProgressHUDUtil showMessage:@"请填写发票抬头" toView:self.view];
            return;
        }
        NSDictionary *parmDic = @{@"orderNum":self.model.orderNum,
                                  @"invoiceState":@"申请中",
                                  @"invoiceType":self.receiptStateStr,
                                  @"invoiceTitle":self.receiptTitleStr};
        [WOTHTTPNetwork submitReceiptWithOrderDic:parmDic response:^(id bean, NSError *error) {
            WOTBaseModel *model = (WOTBaseModel *)bean;
            if ([model.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"提交成功！" toView:self.view];
                dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
                    [self.navigationController popToRootViewControllerAnimated:YES];
                });
            }else
            {
                [MBProgressHUDUtil showMessage:@"提交失败！" toView:self.view];
                return ;
            }
        }];
    }
    else
    {
        if (strIsEmpty(self.receiptTitleStr)) {
            [MBProgressHUDUtil showMessage:@"请填写发票抬头" toView:self.view];
            return;
        }
        
        if (strIsEmpty(self.dutyParagraphStr)) {
            [MBProgressHUDUtil showMessage:@"请填写企业税号" toView:self.view];
            return;
        }
        
        NSDictionary *parmDic = @{@"invoiceState":@"申请中",
                                  @"orderNum":self.model.orderNum,
                                  @"invoiceType":self.receiptStateStr,
                                  @"invoiceTitle":self.receiptTitleStr,
                                  @"invoiceTaxNum":self.dutyParagraphStr
                                  };
        [WOTHTTPNetwork submitReceiptWithOrderDic:parmDic response:^(id bean, NSError *error) {
            WOTBaseModel *model = (WOTBaseModel *)bean;
            if ([model.code isEqualToString:@"200"]) {
                [MBProgressHUDUtil showMessage:@"提交成功！" toView:self.view];
                [self.navigationController popToRootViewControllerAnimated:YES];
            }else
            {
                [MBProgressHUDUtil showMessage:@"提交失败！" toView:self.view];
                return ;
            }
        }];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

#pragma mark - 选择开票类型
-(void)chooseReceipt:(UIButton *)sender
{
    SKReceiptStateCell *cell = (SKReceiptStateCell *)[[sender superview] superview];
    //修改性别
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:nil
                                                                             message:nil
                                                                      preferredStyle:UIAlertControllerStyleActionSheet];

    UIAlertAction* womanAction = [UIAlertAction actionWithTitle:@"个人" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //[self updateUserSexWithSex:@"女"];
        self.receiptStateStr = @"个人";
        [cell.receiptState setTitle:@"个人" forState:UIControlStateNormal];
        _titleArray = @[@"开票状态:",@"发票类型:",@"发票抬头:"];
        [self.tableView reloadData];
    }];
    
    UIAlertAction* manAction = [UIAlertAction actionWithTitle:@"公司" style:UIAlertActionStyleDefault handler:^(UIAlertAction * action) {
        //[self updateUserSexWithSex:@"男"];
        self.receiptStateStr = @"公司";
        [cell.receiptState setTitle:@"公司" forState:UIControlStateNormal];
        _titleArray = @[@"开票状态:",@"发票类型:",@"发票抬头:",@"企业税号:"];
        [self.tableView reloadData];
    }];
    [alertController addAction:manAction];
    [alertController addAction:womanAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

-(UITableView *)tableView
{
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:CGRectZero style:UITableViewStyleGrouped];
        _tableView.delegate = self;
        _tableView.dataSource = self;
    }
    return _tableView;
}

-(UIButton *)submitButton
{
    if (!_submitButton) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        [_submitButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
        [_submitButton addTarget:self action:@selector(submitBtn) forControlEvents:UIControlEventTouchUpInside];
        _submitButton.backgroundColor = [UIColor colorWithHexString:@"ff7f3d"];
        _submitButton.layer.cornerRadius = 5.f;
        _submitButton.layer.borderWidth = 1.f;
        _submitButton.layer.borderColor =[UIColor colorWithHexString:@"ff7f3d"].CGColor;
    }
    return _submitButton;
}

-(NSArray *)titleArray
{
    if (!_titleArray) {
        if ([self.receiptStateStr isEqualToString:@"个人"]) {
            _titleArray = @[@"开票状态:",@"发票类型:",@"发票抬头:"];
        }else
        {
            _titleArray = @[@"开票状态:",@"发票类型:",@"发票抬头:",@"企业税号:"];
        }
        
    }
    return _titleArray;
}

@end
