//
//  WOTPublishSocialTrendsVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/31.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTPublishSocialTrendsVC.h"
#import "WOTImageCollectionViewCell.h"
#import "WOTPhotosBaseUtils.h"
#import <Photos/Photos.h>
//#import "ZSImagePickerController.h"
#import "WOTMapManager.h"
#import "MBProgressHUD+Extension.h"
#import "ZLPhotoActionSheet.h"

#define TextViewPlaceholder @"想你所想，写你想讲..."
@interface WOTPublishSocialTrendsVC ()<UITextViewDelegate,UICollectionViewDelegate,UICollectionViewDataSource
//,ZSImagePickerControllerDelegate
>
{
    ZLPhotoActionSheet *actionSheet;
}
@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet UIView *collectionSuperVIew;
@property (weak, nonatomic) IBOutlet UILabel *locationLabel;
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *viewHeight;

@end

@implementation WOTPublishSocialTrendsVC

- (void)viewDidLoad {
    [super viewDidLoad];
    _textView.delegate = self;
    self.automaticallyAdjustsScrollViewInsets = NO;
    [self themeDefatultConfi];
    [self configNav];
    [[WOTConfigThemeUitls shared] touchViewHiddenKeyboard:self.view];
    [[WOTConfigThemeUitls shared] setHiddenKeyboardBlcok:^{
        [_textView resignFirstResponder];
        
        if ([_textView.text isEqualToString:TextViewPlaceholder] ||[_textView.text isEqualToString:@""] ) {
        _textView.text = TextViewPlaceholder;
        } else {
             [_textView.text stringByReplacingOccurrencesOfString:TextViewPlaceholder withString:@""];
        }
        _textView.textColor = LowTextColor;
        [self configNaviRightItemWithTitle:@"发布" textColor:MiddleTextColor];
    }];
    
    _collectionView.delegate = self;
    _collectionView.dataSource =self;
    [_collectionView setScrollEnabled:NO];
    [_collectionView registerNib:[UINib nibWithNibName:@"WOTImageCollectionViewCell" bundle:nil] forCellWithReuseIdentifier:@"WOTImageCollectionViewCellID"];
    
    [self loadLoaction];
    [self.photosArray addObject:[self createAddImage]];

    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)configNav{
    self.navigationItem.title = @"发消息";
    [self configNaviBackItem];
    
    
}

-(void)viewWillLayoutSubviews{
 _viewHeight.constant = (SCREEN_WIDTH-20)/3.5 * ceil(_photosArray.count*0.3) + 30;
}

-(void)loadLoaction
{
    [[WOTMapManager shared].mapmanager requestLocationWithReGeocode:YES completionBlock:^(CLLocation *location, AMapLocationReGeocode *regeocode, NSError *error) {
        if (error)
        {
            NSLog(@"locError:{%ld - %@};", (long)error.code, error.localizedDescription);
            if (error.code == AMapLocationErrorLocateFailed)
            {
                return;
            }
        }
        
        NSLog(@"location:%@", location);
        NSLog(@"纬度:%f,经度:%f",location.coordinate.latitude,location.coordinate.longitude);
        if (regeocode)
        {
            NSLog(@"reGeocode:%@", regeocode);
            self.locationLabel.text = [NSString stringWithFormat:@"%@%@",regeocode.street,regeocode.POIName];
        }
    }];
}

-(UIImage *)createAddImage{
//    UIView *addView = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 200, 200)];
//    addView.backgroundColor = RGB(242.0, 243.0, 244.0);
//    UIImageView *imageView = [[UIImageView alloc]initWithFrame:CGRectMake(0,0, 40, 40)];
//    imageView.center = addView.center;
//    
//    imageView.image = [UIImage imageNamed:@"camera_icon"];
//    [addView addSubview:imageView];
//    UILabel * label = [[UILabel alloc]initWithFrame:CGRectMake(0,addView.center.y+20, 200, 30)];
//    label.text = @"照片／视频";
//    label.textAlignment = NSTextAlignmentCenter;
//    label.font  = [UIFont systemFontOfSize:20];
//    [addView addSubview:label];
//     [addView toImage];
    return [UIImage imageNamed:@"addPhoto"];
}

-(void)back{
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)themeDefatultConfi{
    _textView.textColor = LowTextColor;
    _textView.text = TextViewPlaceholder;
    [self configNaviRightItemWithTitle:@"发布" textColor:MiddleTextColor];
    
}
-(void)rightItemAction{
  //TODO:调用接口发布动态消息
    NSMutableArray *arr =  self.photosArray;
    [arr removeObjectAtIndex:0];
    [MBProgressHUDUtil showLoadingWithMessage:@"发布中" toView:self.view whileExcusingBlock:^(MBProgressHUD *hud) {
        [WOTHTTPNetwork sendMessageToSapceWithSpaceId:[WOTUserSingleton shareUser].userInfo.spaceId text:self.textView.text images:arr response:^(id bean, NSError *error) {
            
            if (!error) {
                [hud setLabelText:@"完成"];
                [hud setMode:MBProgressHUDModeCustomView];
                [hud setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbp_down.png"]]];
                NSLog(@"发布完成");
//                [self back];
            }
            else {
                [hud setLabelText:@"失败"];
                [hud setMode:MBProgressHUDModeCustomView];
                [hud setCustomView:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mbp_error.png"]]];
                NSLog(@"发布失败");
            }
            [hud hide:YES afterDelay:0.8f complete:^{
                [self back];
            }];
        }];
    }];
}
- (IBAction)createNewLocation:(id)sender {
}


-(void)textViewDidBeginEditing:(UITextView *)textView{
    
    [self configNaviRightItemWithTitle:@"发布" textColor:MainOrangeColor];

    if ([_textView.text isEqualToString:TextViewPlaceholder]) {
         _textView.text = @"";
    }
   
}

-(NSMutableArray *)photosArray{
    if (!_photosArray) {
        _photosArray = [[NSMutableArray alloc]init];
        
    }
    return _photosArray;
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return _photosArray.count;
}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //重用cell
    WOTImageCollectionViewCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:@"WOTImageCollectionViewCellID" forIndexPath:indexPath];
    [cell.cityImage  setImage:_photosArray[indexPath.row]];
    return cell;
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (IS_IPHONE_5) {
        return CGSizeMake((SCREEN_WIDTH-20)/3.8,(SCREEN_WIDTH-20)/3.8);
    } else {
        return CGSizeMake((SCREEN_WIDTH-20)/3.5,(SCREEN_WIDTH-20)/3.5);
    }
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(10, 10, 10, 10);//分别为上、左、下、右
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    __weak typeof(self) weakSelf = self;
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    if (indexPath.row == 0) {
//        WOTPhotosBaseUtils *photo = [[WOTPhotosBaseUtils alloc]init];
//        photo.onlyOne = NO;
//        photo.vc = self;
//        
//        [photo showSelectedPhotoSheet];
    }
    
    if (!actionSheet) {
        actionSheet = [[ZLPhotoActionSheet alloc] init];
        actionSheet.maxPreviewCount = 20;
        actionSheet.maxSelectCount = 9;
        actionSheet.sender = self;
        [actionSheet setSelectImageBlock:^(NSArray<UIImage *> *images, NSArray<PHAsset *> *assets, BOOL isOriginal){
            if (_photosArray.count<10) {
                  [weakSelf.photosArray addObjectsFromArray:images];
            } else {
                [MBProgressHUDUtil showMessage:@"最多选择9张照片" toView:weakSelf.view];
            }
            [weakSelf.collectionView reloadData];
            [weakSelf viewWillLayoutSubviews];
        }];
        
    }
    [actionSheet showPreviewAnimated:YES];
}

//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    UICollectionViewCell *cell = [collectionView cellForItemAtIndexPath:indexPath];
    
}


#pragma mark -


#pragma mark ZSImagePickerController delegate  选择多张照片代理
//
//- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker beyondMaxSelectedPhotoCount:(NSInteger)count{
//    NSLog(@"%zd",count);
//}
//
//- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker didFinishPickingMediaWithInfo:(nullable NSDictionary<NSString *,NSArray *> *)info{
//    NSLog(@"%@",info);
//}
//
//- (void)zs_imagePickerControllerDidCancel:(nullable ZSImagePickerController *)picker{
//    NSLog(@"Cancel");
//}
//
//- (void)zs_imagePickerController:(nullable ZSImagePickerController *)picker didFinishPickingImage:(nullable NSDictionary<NSString *,id> *)info{
//    NSLog(@"%@",info);
//    NSArray <PHAsset *>*assets = info[@"result"];
//    PHImageRequestOptions *options = [[PHImageRequestOptions alloc] init];
//    options.synchronous = YES;
//    for (PHAsset *asset in assets) {
//        // 是否要原图
//        CGSize size = CGSizeMake(asset.pixelWidth, asset.pixelHeight);
//        
//        [[PHImageManager defaultManager] requestImageForAsset:asset targetSize:size contentMode:PHImageContentModeDefault options:options resultHandler:^(UIImage * _Nullable result, NSDictionary * _Nullable info) {
//            NSLog(@"%@", result);
//            if (_photosArray.count<10) {
//                  [_photosArray addObject:result];
//            } else {
//                [MBProgressHUDUtil showMessage:@"最多选择9张照片" toView:self.view];
//            }
//          
//        }];
//        
//        [_collectionView reloadData];
//        [self viewWillLayoutSubviews];
//    }
//}
//

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
