//
//  SKRepairsViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2017/12/29.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKRepairsViewController.h"
#import "UIColor+ColorChange.h"
#import "Masonry.h"
#import "TZImagePickerController.h"
#import "TZTestCell.h"
#import <Photos/Photos.h>

@interface SKRepairsViewController ()<UITextViewDelegate,TZImagePickerControllerDelegate,UICollectionViewDelegate,UICollectionViewDataSource>

@property(nonatomic,strong)UIView *lineView1;
@property(nonatomic,strong)UILabel *repairsTypeLabel;
@property(nonatomic,strong)UIButton *repairsButton;
@property(nonatomic,strong)UILabel *repairsLabel;
@property(nonatomic,strong)UIButton *cleanButton;
@property(nonatomic,strong)UILabel *cleanLabel;
@property(nonatomic,strong)UIButton *otherButton;
@property(nonatomic,strong)UILabel *otherLabel;
@property(nonatomic,strong)UIView *lineView2;
@property(nonatomic,strong)UILabel *repairsDescribeLabel;
@property(nonatomic,strong)UITextView *describeTextView;
@property (strong, nonatomic) UICollectionView *collectionView;
@property (strong, nonatomic) UICollectionViewFlowLayout *layout;
@property(nonatomic,strong)UIView *lineView3;
@property(nonatomic,strong)UILabel *repairsAddressLabel;
@property(nonatomic,strong)UITextField *repairsAddressTextField;
@property(nonatomic,strong)UIView *lineView4;
@property(nonatomic,strong)UIButton *submitButton;

@property (nonatomic, strong) NSMutableArray *selectedPhotos;
//@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, assign) int startServiceImageNum;
@property (nonatomic, assign) int endServiceImageNum;
@property (nonatomic, assign) int titleLabelHeight;
@property (nonatomic, assign) int collectionViewHeight;
@property (nonatomic, assign) int buttonHeight;

@property (nonatomic,strong)NSString *repairsTypeStr;
@end

@implementation SKRepairsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.navigationItem.title = @"问题报修";
    self.view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:self.lineView1];
    [self.view addSubview:self.repairsTypeLabel];
    [self.view addSubview:self.lineView2];
    [self.view addSubview:self.repairsButton];
    [self.view addSubview:self.repairsLabel];
    [self.view addSubview:self.cleanButton];
    [self.view addSubview:self.cleanLabel];
    [self.view addSubview:self.otherButton];
    [self.view addSubview:self.otherLabel];
    [self.view addSubview:self.repairsDescribeLabel];
    [self.view addSubview:self.describeTextView];
    [self.view addSubview:self.lineView3];
    [self.view addSubview:self.repairsAddressLabel];
    [self.view addSubview:self.repairsAddressTextField];
    [self.view addSubview:self.lineView4];
    [self.view addSubview:self.submitButton];
    [self configCollectionView];
    [self layoutSubviews];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.tabBarController.tabBar setHidden:YES];
    self.navigationController.navigationBarHidden = NO;
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    [self.tabBarController.tabBar setHidden:NO];
}

#pragma mark - 布局约束
-(void)layoutSubviews
{
    [self.lineView1 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.view).with.offset(64);
        make.left.equalTo(self.view);
        make.right.equalTo(self.view);
        make.height.mas_offset(1);
    }];
    
    [self.repairsTypeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView1.mas_bottom).with.offset(14);
        make.left.equalTo(self.view).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.lineView2 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repairsTypeLabel.mas_bottom).with.offset(15);
        make.left.equalTo(self.view).with.offset(5);
        make.right.equalTo(self.view).with.offset(-5);
        make.height.mas_offset(1);
    }];
    
    [self.repairsButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.repairsTypeLabel.mas_right).with.offset(5);
    }];
    
    [self.repairsLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.repairsButton.mas_right).with.offset(5);
    }];
    
    [self.cleanButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.repairsLabel.mas_right).with.offset(10);
    }];
    
    [self.cleanLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.cleanButton.mas_right).with.offset(5);
    }];
    
    [self.otherButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.cleanLabel.mas_right).with.offset(10);
    }];
    
    [self.otherLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsTypeLabel.mas_centerY);
        make.left.equalTo(self.otherButton.mas_right).with.offset(5);
    }];
    
    [self.repairsDescribeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView2.mas_bottom).with.offset(14);
        make.left.equalTo(self.view).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.describeTextView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repairsDescribeLabel.mas_top);
        make.left.equalTo(self.repairsDescribeLabel.mas_right).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.height.mas_offset(100);
    }];
    
    [self.collectionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.describeTextView.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(5);
        make.right.equalTo(self.view).with.offset(-5);
        make.height.mas_offset(80);
    }];
    
    [self.lineView3 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.collectionView.mas_bottom).with.offset(5);
        make.left.equalTo(self.view).with.offset(5);
        make.right.equalTo(self.view).with.offset(-5);
        make.height.mas_offset(1);
    }];
    
    [self.repairsAddressLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.lineView3.mas_bottom).with.offset(14);
        make.left.equalTo(self.view).with.offset(10);
        make.width.mas_offset(100);
    }];
    
    [self.repairsAddressTextField mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(self.repairsAddressLabel);
        make.left.equalTo(self.repairsAddressLabel.mas_right).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
    }];
    
    [self.lineView4 mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.repairsAddressTextField.mas_bottom).with.offset(15);
        make.left.equalTo(self.view).with.offset(5);
        make.right.equalTo(self.view).with.offset(-5);
        make.height.mas_offset(1);
    }];
    
    [self.submitButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.view).with.offset(10);
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-10);
        make.height.mas_offset(48);
    }];
}

#pragma mark - 初始化滚动视图
- (void)configCollectionView {
    self.collectionViewHeight = 1;
    _layout = [[UICollectionViewFlowLayout alloc] init];
    _layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
    _collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:_layout];
    _collectionView.backgroundColor = [UIColor whiteColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [self.view addSubview:_collectionView];
    [_collectionView registerClass:[TZTestCell class] forCellWithReuseIdentifier:@"TZTestCell"];
}

#pragma mark - UICollectionViewDataSource
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _selectedPhotos.count + 1;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath {
    TZTestCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"TZTestCell" forIndexPath:indexPath];
    cell.videoImageView.hidden = YES;
    if (indexPath.row == _selectedPhotos.count) {
        cell.imageView.image = [UIImage imageNamed:@"AddImage"];
        cell.deleteBtn.hidden = YES;
        cell.gifLable.hidden = YES;
    } else {
        cell.imageView.image = _selectedPhotos[indexPath.row];
        
        cell.deleteBtn.hidden = NO;
    }
    cell.imageView.contentMode = UIViewContentModeScaleToFill;
    cell.deleteBtn.tag = indexPath.row;
    [cell.deleteBtn addTarget:self action:@selector(deleteBtnClik:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == _selectedPhotos.count) {
        BOOL showSheet = NO;
        if (showSheet) {
            UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"去相册选择", nil];
            [sheet showInView:self.view];
        } else {
            [self pushTZImagePickerController];
        }
    } else {
        
    }
}


#pragma mark - TZImagePickerController
- (void)pushTZImagePickerController {
    
    TZImagePickerController *imagePickerVc = [[TZImagePickerController alloc] initWithMaxImagesCount:4 columnNumber:3 delegate:self pushPhotoPickerVc:YES];
    
    [imagePickerVc setDidFinishPickingPhotosHandle:^(NSArray<UIImage *> *photos, NSArray *assets, BOOL isSelectOriginalPhoto) {
        
    }];
    
    [self presentViewController:imagePickerVc animated:YES completion:nil];
}
- (void)imagePickerController:(TZImagePickerController *)picker didFinishPickingPhotos:(NSArray *)photos sourceAssets:(NSArray *)assets isSelectOriginalPhoto:(BOOL)isSelectOriginalPhoto {
    _selectedPhotos = [NSMutableArray arrayWithArray:photos];
    [self viewDidLayoutSubviews];
    [_collectionView reloadData];
    if (iOS8Later) {
        for (PHAsset *phAsset in assets) {
            NSLog(@"location:%@",phAsset.location);
        }
    }
}

#pragma mark - 图片删除方法
- (void)deleteBtnClik:(UIButton *)sender {
    [_selectedPhotos removeObjectAtIndex:sender.tag];
    [_collectionView performBatchUpdates:^{
        NSIndexPath *indexPath = [NSIndexPath indexPathForItem:sender.tag inSection:0];
        [_collectionView deleteItemsAtIndexPaths:@[indexPath]];
    } completion:^(BOOL finished) {
        [_collectionView reloadData];
    }];
}

#pragma mark - 维修方法
-(void)repairsButtonMethod
{
    self.repairsTypeStr = @"维修";
    [self.repairsButton setBackgroundImage:[UIImage imageNamed:@"repairsSelect"] forState:UIControlStateNormal];
    [self.cleanButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
    [self.otherButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
}

#pragma mark - 清洁方法
-(void)cleanButtonMethod
{
    self.repairsTypeStr = @"清洁";
    [self.repairsButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
    [self.cleanButton setBackgroundImage:[UIImage imageNamed:@"repairsSelect"] forState:UIControlStateNormal];
    [self.otherButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
}

#pragma mark - 其他方法
-(void)otherButtonMethod
{
    self.repairsTypeStr = @"其他";
    [self.repairsButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
    [self.cleanButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
    [self.otherButton setBackgroundImage:[UIImage imageNamed:@"repairsSelect"] forState:UIControlStateNormal];
}

#pragma mark - 提交方法
-(void)subMitButtonMethod
{
    
}

#pragma mark - UITextViewDelegate
-(BOOL)textViewShouldBeginEditing:(UITextView *)textView
{
    self.describeTextView.text=@"";
    self.describeTextView.textColor = [UIColor blackColor];
    return YES;
}

-(BOOL)textViewShouldEndEditing:(UITextView *)textView
{
    if ([self.describeTextView.text isEqualToString:@""]) {
        self.describeTextView.text = @"请输入文字描述";
        self.describeTextView.textColor = [UIColor lightGrayColor];
    }
    return YES;
}

#pragma mark - 以下为空间初始化
-(UIView *)lineView1
{
    if (_lineView1 == nil) {
        _lineView1 = [[UIView alloc] init];
        _lineView1.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _lineView1;
}

-(UIView *)lineView2
{
    if (_lineView2 == nil) {
        _lineView2 = [[UIView alloc] init];
        _lineView2.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _lineView2;
}

-(UIView *)lineView3
{
    if (_lineView3 == nil) {
        _lineView3 = [[UIView alloc] init];
        _lineView3.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _lineView3;
}

-(UIView *)lineView4
{
    if (_lineView4 == nil) {
        _lineView4 = [[UIView alloc] init];
        _lineView4.backgroundColor = [UIColor colorWithHexString:@"dddddd"];
    }
    return _lineView4;
}

-(UILabel *)repairsTypeLabel
{
    if (_repairsTypeLabel == nil) {
        _repairsTypeLabel = [[UILabel alloc] init];
        _repairsTypeLabel.text = @"报修类型：";
    }
    return _repairsTypeLabel;
}

-(UIButton *)repairsButton
{
    if (_repairsButton == nil) {
        _repairsButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_repairsButton setBackgroundImage:[UIImage imageNamed:@"repairsSelect"] forState:UIControlStateNormal];
        [_repairsButton addTarget:self action:@selector(repairsButtonMethod) forControlEvents:UIControlEventTouchDown];
        self.repairsTypeStr = @"维修";
    }
    return _repairsButton;
}

-(UILabel *)repairsLabel
{
    if (_repairsLabel == nil) {
        _repairsLabel = [[UILabel alloc] init];
        _repairsLabel.text = @"维修";
        [_repairsLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    }
    return _repairsLabel;
}

-(UIButton *)cleanButton
{
    if (_cleanButton == nil) {
        _cleanButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_cleanButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
        [_cleanButton addTarget:self action:@selector(cleanButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _cleanButton;
}

-(UILabel *)cleanLabel
{
    if (_cleanLabel == nil) {
        _cleanLabel = [[UILabel alloc] init];
        _cleanLabel.text = @"清洁";
        [_cleanLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    }
    return _cleanLabel;
}

-(UIButton *)otherButton
{
    if (_otherButton == nil) {
        _otherButton = [UIButton buttonWithType:UIButtonTypeCustom];
        [_otherButton setBackgroundImage:[UIImage imageNamed:@"repairsNoSelect"] forState:UIControlStateNormal];
        [_otherButton addTarget:self action:@selector(otherButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _otherButton;
}

-(UILabel *)otherLabel
{
    if (_otherLabel == nil) {
        _otherLabel = [[UILabel alloc] init];
        _otherLabel.text = @"其他";
        [_otherLabel setFont:[UIFont fontWithName:@"Helvetica" size:15]];
    }
    return _otherLabel;
}

-(UILabel *)repairsDescribeLabel
{
    if (_repairsDescribeLabel == nil) {
        _repairsDescribeLabel = [[UILabel alloc] init];
        _repairsDescribeLabel.text = @"报修描述：";
    }
    return _repairsDescribeLabel;
}

-(UITextView *)describeTextView
{
    if (_describeTextView == nil) {
        _describeTextView = [[UITextView alloc] init];
        _describeTextView.text = @"请输入文字描述";
        _describeTextView.textColor = [UIColor lightGrayColor];
        _describeTextView.delegate = self;
        [_describeTextView setFont:[UIFont systemFontOfSize:15]];
    }
    return _describeTextView;
}

-(UILabel *)repairsAddressLabel
{
    if (_repairsAddressLabel == nil) {
        _repairsAddressLabel = [[UILabel alloc] init];
        _repairsAddressLabel.text = @"报修位置：";
    }
    return _repairsAddressLabel;
}

-(UITextField *)repairsAddressTextField
{
    if (_repairsAddressTextField == nil) {
        _repairsAddressTextField = [[UITextField alloc] init];
        _repairsAddressTextField.placeholder = @"请输入位置";
    }
    return _repairsAddressTextField;
}

-(UIButton *)submitButton
{
    if (_submitButton == nil) {
        _submitButton = [UIButton buttonWithType:UIButtonTypeCustom];
        _submitButton.backgroundColor = [UIColor colorWithHexString:@"528bfa"];
        [_submitButton setTitle:@"提交" forState:UIControlStateNormal];
        _submitButton.layer.cornerRadius = 5.f;
        _submitButton.layer.borderWidth = 1.f;
        _submitButton.layer.borderColor = [UIColor colorWithHexString:@"528bfa"].CGColor;
        [_submitButton addTarget:self action:@selector(subMitButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _submitButton;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end