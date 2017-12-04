//
//  WOTEnterpriseTypeVC.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/9.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTEnterpriseTypeVC.h"
#import "WOTEnterpriseTypeCell.h"
#import "WOTEnterpriseHeaderView.h"
@interface WOTEnterpriseTypeVC ()<UICollectionViewDelegate,UICollectionViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;
@property(nonatomic,strong)NSArray *sectionName;
@property(nonatomic,strong)NSArray *typeimage;
@property(nonatomic,strong)NSMutableArray *selectedArray;

@property(nonatomic,strong)NSArray *typeName;
@end

@implementation WOTEnterpriseTypeVC

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = White;
    self.selectedArray = [NSMutableArray array];
    [self configNav];
    [self congitCollectionView];
    [self makeCollectionDataSource];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillLayoutSubviews{

}
-(void)configNav{
    self.navigationItem.title = @"创建企业";
    [self configNaviRightItemWithTitle:@"保存" textColor:[UIColor redColor]];
}

-(void)makeCollectionDataSource{
    
    _sectionName = @[@"互联网",@"智能硬件",@"文娱传媒",@"金融",@"商务／企业服务",@"生活／个人服务",@"其他"];
    
    NSArray *array1 = @[@"数据服务",@"物联网",@"OTO",@"APP",@"信息平台／网站",@"电商",@"软件技术"];
    NSArray *array2 = @[@"硬科技",@"电子产品",@"AR/VR",@"机器人",@"智能家居",@"无人机"];
    NSArray *array3 = @[@"影视",@"音乐",@"杂志",@"体育",@"新媒体",@"广告",@"设计／艺术"];
    NSArray *array4 = @[@"信贷",@"支付",@"征信",@"P2P",@"股票",@"基金会",@"投资管理",@"保险"];
    NSArray *array5 = @[@"人力资源",@"法律／政策",@"宣传／公关",@"财务",@"信息中介／交易撮合",@"咨询／策划"];
    NSArray *array6= @[@"美食",@"出行",@"住宿",@"美妆",@"娱乐／游泳",@"医疗",@"健身",@"教育"];
    NSArray *array7= @[@"联合办公",@"NGO",@"制造业",@"原材料",@"其他"];
    
    NSArray *arr1 = @[@"shujufuwu",@"wulianwang",@"o2o",@"APP",@"xinxipingtai",@"dianshang",@"ruanjianjishu"];
    NSArray *arr2 = @[@"yingkeji",@"dianzichanpin",@"AR",@"jiqiren",@"zhinengjiaju",@"wurenji"];
    NSArray *arr3 = @[@"yingshi",@"yinyue",@"zazhi",@"tiyu",@"xinmeiti",@"guanggao",@"sheji"];
    NSArray *arr4 = @[@"xindai",@"zhifu",@"zhengxin",@"p2p",@"gupiao",@"jijinhui",@"touziguanli",@"baoxian"];
    NSArray *arr5 = @[@"renli",@"falu",@"gongguan",@"caiwu",@"xinxizhongjie",@"zixun"];
    NSArray *arr6= @[@"meishi",@"chuxing",@"zhusu",@"meizhuang",@"youyong",@"yiliao",@"jianshen",@"jiaoyu"];
    NSArray *arr7= @[@"lianhebangong",@"ngo",@"zhizaoye",@"yuancailiao",@"qita"];
    
    
    _typeName = @[array1,array2,array3,array4,array5,array6,array7];
    _typeimage = @[arr1,arr2,arr3,arr4,arr5,arr6,arr7];
    [self.collectionView reloadData];
    
}

-(void)congitCollectionView{
    self.collectionView.allowsMultipleSelection = YES;
    UICollectionViewFlowLayout *layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(80, 80);
    layout.minimumLineSpacing = 10.0;
    layout.minimumInteritemSpacing = 0.0;
    layout.sectionInset = UIEdgeInsetsMake(10, 10, 10, 10);
    layout.headerReferenceSize = CGSizeMake(self.view.frame.size.width, 50);
    [_collectionView setCollectionViewLayout:layout];
    [_collectionView registerNib:[UINib nibWithNibName:@"WOTEnterpriseHeaderView" bundle:nil] forSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WOTEnterpriseHeaderViewID"];
}

#pragma mark -CollectionView datasource
//section
- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
                           
{
    return _sectionName.count;
}
//item个数
- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    NSArray *dd = (NSArray *)_typeName[section];
    return dd.count;

}

// The cell that is returned must be retrieved from a call to -dequeueReusableCellWithReuseIdentifier:forIndexPath:
- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    
    NSString *identifier=[NSString stringWithFormat:@"%ld%ld",(long)indexPath.section,(long)indexPath.row];
    
    [_collectionView registerNib:[UINib nibWithNibName:@"WOTEnterpriseTypeCell" bundle:nil] forCellWithReuseIdentifier:identifier];
    
    
    WOTEnterpriseTypeCell *cell = [_collectionView dequeueReusableCellWithReuseIdentifier:identifier forIndexPath:indexPath];
 
  
    NSArray *dd = (NSArray *)_typeName[indexPath.section];
    NSArray *ss = (NSArray *)_typeimage[indexPath.section];
    cell.typeName.text = (NSString *)dd[indexPath.row];
    cell.typeImage.image = [UIImage imageNamed:ss[indexPath.row]];
    
    
    if ([self.selectedArray containsObject:indexPath]) {
      cell.selectedImage.image = [UIImage imageNamed:@"typeselected"];
        
    }else
    {
       cell.selectedImage.image = [UIImage imageNamed:@""];
    }
 
    
    return cell;
}

- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath{
 
        WOTEnterpriseHeaderView *header = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionHeader withReuseIdentifier:@"WOTEnterpriseHeaderViewID" forIndexPath:indexPath];
    header.headerTitle.text = _sectionName[indexPath.section];
    
    return header;
    
    
}

//定义每个UICollectionViewCell 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake((self.collectionView.frame.size.width-30)/3, (self.collectionView.frame.size.width-30)/3);
}
//定义每个Section 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0,5,0,0);//分别为上、左、下、右
}

//选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (self.selectedArray.count<=4) {
        if ([self.selectedArray containsObject:indexPath]) {
            [self.selectedArray removeObject:indexPath];
        }else
        {
            [self.selectedArray addObject:indexPath];
        }
    } else {
        [MBProgressHUDUtil showMessage:@"最多可以选择4项" toView:self.view];
    }
   
    [self.collectionView reloadItemsAtIndexPaths:@[indexPath]];
    
}
//取消选择了某个cell
- (void)collectionView:(UICollectionView *)collectionView didDeselectItemAtIndexPath:(NSIndexPath *)indexPath
{
    WOTEnterpriseTypeCell *cell =  (WOTEnterpriseTypeCell *) [collectionView cellForItemAtIndexPath:indexPath];
    cell.selectedImage.image = [UIImage imageNamed:@""];
}

-(void)rightItemAction{
    //TODO:保存选择的企业类型；
   NSString *string = @"";
    for (NSIndexPath *indexpath in _selectedArray) {
        string = [NSString stringWithFormat:@"%@%@,",string,_typeName[indexpath.section][indexpath.row]];
        
    }
 
    if (_gobackBlock) {
        self.gobackBlock(string);
    }
//    NSLog(@"---选择企业---%@",string);
    [self.navigationController popViewControllerAnimated:YES];
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
