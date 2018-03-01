//
//  SKMapViewController.m
//  WOTWorkSpace
//
//  Created by wangxiaodong on 2018/3/1.
//  Copyright © 2018年 北京物联港科技发展有限公司. All rights reserved.
//

#import "SKMapViewController.h"
#import "Masonry.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapLocationKit/AMapLocationKit.h>
#import "GPSNaviViewController.h"
#import <AMapSearchKit/AMapSearchAPI.h>
#import "MANaviRoute.h"
#import "CommonUtility.h"
#import "WOTLocationManager.h"
#import "WOTSingtleton.h"

static const NSString *RoutePlanningViewControllerStartTitle       = @"起点";
static const NSString *RoutePlanningViewControllerDestinationTitle = @"终点";
static const NSInteger RoutePlanningPaddingEdge                    = 20;

@interface SKMapViewController ()<MAMapViewDelegate, AMapLocationManagerDelegate,AMapSearchDelegate>
@property(nonatomic,strong)UIButton *pathButton;
@property(nonatomic,strong)UIButton *locationButton;
@property(nonatomic,strong) AMapLocationManager *locationManager;
@property(nonatomic,strong) MAPointAnnotation *pointAnnotaiton;
@property(nonatomic,strong)MAMapView *mapView;

@property(nonatomic,assign)BOOL isPath;

/* 用于显示当前路线方案. */
@property (nonatomic) MANaviRoute * naviRoute;
/* 起始点经纬度. */
@property (nonatomic) CLLocationCoordinate2D startCoordinate;
/* 终点经纬度. */
@property (nonatomic) CLLocationCoordinate2D destinationCoordinate;
@property (nonatomic, strong) MAPointAnnotation *startAnnotation;
@property (nonatomic, strong) MAPointAnnotation *destinationAnnotation;
@property (nonatomic, strong) AMapSearchAPI *search;
/* 路线方案个数. */
@property (nonatomic) NSInteger totalCourse;
@property (nonatomic, strong) AMapRoute *route;
/* 当前路线方案索引值. */
@property (nonatomic) NSInteger currentCourse;
@property (nonatomic, assign)CGFloat lat;
@property (nonatomic, assign)CGFloat lng;

@end

@implementation SKMapViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = self.spaceModel.spaceName;
    [self.view addSubview:self.mapView];
    [self.view addSubview:self.pathButton];
    [self.view addSubview:self.locationButton];
    [self layoutSubviews];
    //@116.322930,@39.937534
    self.lat = [WOTSingtleton shared].userLat;
    self.lng = [WOTSingtleton shared].userLng;
    self.isPath = NO;
    self.locationManager = [[AMapLocationManager alloc] init];
    self.locationManager.delegate = self;
    [self setDataSpacelocationWithPointLng:self.spaceModel.lng pointLat:self.spaceModel.lat];
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    [self.navigationController.navigationBar setHidden:NO];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)layoutSubviews
{
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(self.view);
    }];
    
    [self.locationButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.view).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-20);
        make.width.mas_offset(70);
        make.height.mas_offset(32);
    }];
    
    [self.pathButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.right.equalTo(self.locationButton.mas_left).with.offset(-10);
        make.bottom.equalTo(self.view).with.offset(-20);
        make.width.mas_offset(70);
        make.height.mas_offset(32);
    }];
}

-(void)setDataSpacelocationWithPointLng:(NSNumber *)pointLng  pointLat:(NSNumber *)pointLat
{
    
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([pointLat floatValue], [pointLng floatValue]);
    [self.mapView setCenterCoordinate:pointAnnotation.coordinate animated:NO];//在地图上设置定位点
    pointAnnotation.title = self.spaceModel.spaceName;
    pointAnnotation.subtitle = self.spaceModel.spaceSite;
    
    [self.mapView addAnnotation:pointAnnotation];
    
    [_mapView setZoomLevel:12 animated:YES];//设置缩放比例
}

-(void)mapView:(MAMapView *)mapView didAddAnnotationViews:(NSArray *)views{
    if ([views[0] isKindOfClass:MAPinAnnotationView.class]){
        MAPinAnnotationView *mapView = (MAPinAnnotationView*)views[0];
        [self.mapView selectAnnotation:mapView.annotation animated:YES];
    }
}

#pragma mark - 路线
-(void)pathButtonMethod
{
    UIAlertController *alertController = [[UIAlertController alloc] init];
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    
    UIAlertAction *walkPathAction = [UIAlertAction actionWithTitle:@"步行" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pathType = PATH_TYPE_WALK;
        [self PathMethod];
    }];
    
    UIAlertAction *cyclingPathAction = [UIAlertAction actionWithTitle:@"骑行" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pathType = PATH_TYPE_CYCLING;
        [self PathMethod];
    }];
    
    UIAlertAction *drivePathAction = [UIAlertAction actionWithTitle:@"驾车" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pathType = PATH_TYPE_DRIVE;
        [self PathMethod];
    }];
    
    UIAlertAction *busPathAction = [UIAlertAction actionWithTitle:@"公交" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        self.pathType = PATH_TYPE_BUS;
        [self PathMethod];
    }];
    
    [alertController addAction:busPathAction];
    [alertController addAction:drivePathAction];
    [alertController addAction:cyclingPathAction];
    [alertController addAction:walkPathAction];
    [alertController addAction:cancelAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark - 路线
-(void)PathMethod
{
    [self clear];
    self.isPath = YES;
    self.startCoordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
    self.destinationCoordinate  = CLLocationCoordinate2DMake([self.spaceModel.lat floatValue], [self.spaceModel.lng floatValue]);
    if (self.search == nil) {
        self.search = [[AMapSearchAPI alloc] init];
        self.search.delegate = self;
    }
    [self addDefaultAnnotations];
    
    [self searchRoutePlanningWalk];
}

#pragma mark - 定位
- (void)startSerialLocation
{
    //开始定位
    [self.locationManager startUpdatingLocation];
}

- (void)stopSerialLocation
{
    //停止定位
    [self.locationManager stopUpdatingLocation];
}

- (void)amapLocationManager:(AMapLocationManager *)manager didFailWithError:(NSError *)error
{
    NSLog(@"%s, amapLocationManager = %@, error = %@", __func__, [manager class], error);
}


- (void)amapLocationManager:(AMapLocationManager *)manager didUpdateLocation:(CLLocation *)location reGeocode:(AMapLocationReGeocode *)reGeocode
{
    NSLog(@"location:{lat:%f; lon:%f; accuracy:%f; reGeocode:%@}", location.coordinate.latitude, location.coordinate.longitude, location.horizontalAccuracy, reGeocode.formattedAddress);
    self.lat = location.coordinate.latitude;
    self.lng = location.coordinate.longitude;
    //获取到定位信息，更新annotation
    if (self.pointAnnotaiton == nil)
    {
        self.pointAnnotaiton = [[MAPointAnnotation alloc] init];
        [self.pointAnnotaiton setCoordinate:location.coordinate];
        [self.mapView setCenterCoordinate:self.pointAnnotaiton.coordinate animated:NO];
        self.pointAnnotaiton.title = @"当前位置";
        [self.mapView addAnnotation:self.pointAnnotaiton];
    }
    
    [self.pointAnnotaiton setCoordinate:location.coordinate];
    
    [self.mapView setCenterCoordinate:location.coordinate];
}


#pragma mark - MAMapViewDelegate 设置标记样式
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        
        
        if (self.isPath) {
            static NSString *routePlanningCellIdentifier = @"RoutePlanningCellIdentifier";
            
            MAAnnotationView *poiAnnotationView = (MAAnnotationView*)[self.mapView dequeueReusableAnnotationViewWithIdentifier:routePlanningCellIdentifier];
            if (poiAnnotationView == nil)
            {
                poiAnnotationView = [[MAAnnotationView alloc] initWithAnnotation:annotation
                                                                 reuseIdentifier:routePlanningCellIdentifier];
            }
            
            poiAnnotationView.canShowCallout = YES;
            poiAnnotationView.image = nil;
            
            if ([annotation isKindOfClass:[MANaviAnnotation class]])
            {
                switch (((MANaviAnnotation*)annotation).type)
                {
                    case MANaviAnnotationTypeRiding:
                        poiAnnotationView.image = [UIImage imageNamed:@"ride"];
                        break;
                        
                    case MANaviAnnotationTypeBus:
                        poiAnnotationView.image = [UIImage imageNamed:@"bus"];
                        break;
                        
                    case MANaviAnnotationTypeDrive:
                        poiAnnotationView.image = [UIImage imageNamed:@"car"];
                        break;
                        
                    case MANaviAnnotationTypeWalking:
                        poiAnnotationView.image = [UIImage imageNamed:@"man"];
                        break;
                        
                    default:
                        break;
                }
            }
            else
            {
                /* 起点. */
                if ([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerStartTitle])
                {
                    poiAnnotationView.image = [UIImage imageNamed:@"startPoint"];
                }
                /* 终点. */
                else if([[annotation title] isEqualToString:(NSString*)RoutePlanningViewControllerDestinationTitle])
                {
                    poiAnnotationView.image = [UIImage imageNamed:@"endPoint"];
                }
                
            }
            
            return poiAnnotationView;
        }else
        {
            static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
            MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
            if (annotationView == nil)
            {
                annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
            }
            annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
            annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
            annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
            annotationView.pinColor = MAPinAnnotationColorPurple;
            annotationView.image = [UIImage imageNamed:@"restaurant"];
            UIButton *rightBtn = [UIButton buttonWithType:UIButtonTypeSystem];
            [rightBtn addTarget:self action:@selector(rightButton:) forControlEvents:UIControlEventTouchDown];
            [rightBtn setTitle:@"导航" forState:UIControlStateNormal];
            [rightBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
            rightBtn.frame = CGRectMake(0, 0, 50, 50);
            rightBtn.backgroundColor = [UIColor orangeColor];
            NSLog(@"位置：%@",annotation.title);
            if (![annotation.title isEqualToString:@"当前位置"]) {
                annotationView.rightCalloutAccessoryView = rightBtn;
            }
            
            return annotationView;
        }
        
    }
    
    return nil;
}

#pragma mark - 导航方法
-(void)rightButton:(UIButton *)button
{
    GPSNaviViewController *naviView = [[GPSNaviViewController alloc] init];
    naviView.startPoint = [AMapNaviPoint locationWithLatitude:self.lat longitude:self.lng];
    naviView.endPoint = [AMapNaviPoint locationWithLatitude:[self.spaceModel.lat floatValue] longitude:[self.spaceModel.lng floatValue]];
    [self.navigationController pushViewController:naviView animated:YES];
}

//****************************下面是路线规划的方法start****************************
#pragma mark - do search
- (void)searchRoutePlanningWalk
{
    self.startAnnotation.coordinate = self.startCoordinate;
    self.destinationAnnotation.coordinate = self.destinationCoordinate;
    if (self.pathType == PATH_TYPE_WALK) {
        AMapWalkingRouteSearchRequest *navi = [[AMapWalkingRouteSearchRequest alloc] init];
        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];
        
        [self.search AMapWalkingRouteSearch:navi];
    }
    
    if (self.pathType == PATH_TYPE_CYCLING) {
        AMapRidingRouteSearchRequest *navi = [[AMapRidingRouteSearchRequest alloc] init];
        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];
        
        [self.search AMapRidingRouteSearch:navi];
    }
    
    if (self.pathType == PATH_TYPE_DRIVE) {
        AMapDrivingRouteSearchRequest *navi = [[AMapDrivingRouteSearchRequest alloc] init];
        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];
        
        [self.search AMapDrivingRouteSearch:navi];
    }
    
    if (self.pathType == PATH_TYPE_BUS) {
        AMapTransitRouteSearchRequest *navi = [[AMapTransitRouteSearchRequest alloc] init];
        navi.requireExtension = YES;
        navi.city             = @"beijing";
        /* 出发点. */
        navi.origin = [AMapGeoPoint locationWithLatitude:self.startCoordinate.latitude
                                               longitude:self.startCoordinate.longitude];
        /* 目的地. */
        navi.destination = [AMapGeoPoint locationWithLatitude:self.destinationCoordinate.latitude
                                                    longitude:self.destinationCoordinate.longitude];
        
        [self.search AMapTransitRouteSearch:navi];
    }
}

- (void)updateTotal
{
    if (self.pathType == PATH_TYPE_BUS) {
        self.totalCourse = self.route.transits.count;
        
    }else
    {
        self.totalCourse = self.route.paths.count;
    }
    
}


/* 展示当前路线方案. */
- (void)presentCurrentCourse
{
    
    if (self.pathType == PATH_TYPE_WALK) {
        MANaviAnnotationType type = MANaviAnnotationTypeWalking;
        self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    }
    if (self.pathType == PATH_TYPE_CYCLING) {
        MANaviAnnotationType type = MANaviAnnotationTypeRiding;
        self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    }
    if (self.pathType == PATH_TYPE_DRIVE) {
        MANaviAnnotationType type = MANaviAnnotationTypeDrive;
        self.naviRoute = [MANaviRoute naviRouteForPath:self.route.paths[self.currentCourse] withNaviType:type showTraffic:YES startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    }
    if (self.pathType == PATH_TYPE_BUS) {
        self.naviRoute = [MANaviRoute naviRouteForTransit:self.route.transits[self.currentCourse] startPoint:[AMapGeoPoint locationWithLatitude:self.startAnnotation.coordinate.latitude longitude:self.startAnnotation.coordinate.longitude] endPoint:[AMapGeoPoint locationWithLatitude:self.destinationAnnotation.coordinate.latitude longitude:self.destinationAnnotation.coordinate.longitude]];
    }
    
    
    [self.naviRoute addToMapView:self.mapView];
    
    /* 缩放地图使其适应polylines的展示. */
    [self.mapView setVisibleMapRect:[CommonUtility mapRectForOverlays:self.naviRoute.routePolylines]
                        edgePadding:UIEdgeInsetsMake(RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge, RoutePlanningPaddingEdge)
                           animated:YES];
}

/* 清空地图上已有的路线. */
- (void)clear
{
    [self.naviRoute removeFromMapView];
}

#pragma mark - MAMapViewDelegate

- (MAOverlayRenderer *)mapView:(MAMapView *)mapView rendererForOverlay:(id<MAOverlay>)overlay
{
    if ([overlay isKindOfClass:[LineDashPolyline class]])
    {
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:((LineDashPolyline *)overlay).polyline];
        polylineRenderer.lineWidth   = 8;
        polylineRenderer.lineDashType = kMALineDashTypeSquare;
        polylineRenderer.strokeColor = [UIColor redColor];
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MANaviPolyline class]])
    {
        MANaviPolyline *naviPolyline = (MANaviPolyline *)overlay;
        MAPolylineRenderer *polylineRenderer = [[MAPolylineRenderer alloc] initWithPolyline:naviPolyline.polyline];
        
        polylineRenderer.lineWidth = 8;
        
        if (naviPolyline.type == MANaviAnnotationTypeWalking)
        {
            polylineRenderer.strokeColor = self.naviRoute.walkingColor;
        }
        else if (naviPolyline.type == MANaviAnnotationTypeRailway)
        {
            polylineRenderer.strokeColor = self.naviRoute.railwayColor;
        }
        else
        {
            polylineRenderer.strokeColor = self.naviRoute.routeColor;
        }
        
        return polylineRenderer;
    }
    if ([overlay isKindOfClass:[MAMultiPolyline class]])
    {
        MAMultiColoredPolylineRenderer * polylineRenderer = [[MAMultiColoredPolylineRenderer alloc] initWithMultiPolyline:overlay];
        
        polylineRenderer.lineWidth = 10;
        polylineRenderer.strokeColors = [self.naviRoute.multiPolylineColors copy];
        polylineRenderer.gradient = YES;
        
        return polylineRenderer;
    }
    
    return nil;
}



/* 路径规划搜索回调. */
- (void)onRouteSearchDone:(AMapRouteSearchBaseRequest *)request response:(AMapRouteSearchResponse *)response
{
    if (response.route == nil)
    {
        return;
    }
    
    self.route = response.route;
    [self updateTotal];
    self.currentCourse = 0;
    
    if (response.count > 0)
    {
        [self presentCurrentCourse];
    }
}



- (void)addDefaultAnnotations
{
    MAPointAnnotation *startAnnotation = [[MAPointAnnotation alloc] init];
    startAnnotation.coordinate = self.startCoordinate;
    startAnnotation.title      = (NSString*)RoutePlanningViewControllerStartTitle;
    startAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.startCoordinate.latitude, self.startCoordinate.longitude];
    self.startAnnotation = startAnnotation;
    
    MAPointAnnotation *destinationAnnotation = [[MAPointAnnotation alloc] init];
    destinationAnnotation.coordinate = self.destinationCoordinate;
    destinationAnnotation.title      = (NSString*)RoutePlanningViewControllerDestinationTitle;
    destinationAnnotation.subtitle   = [NSString stringWithFormat:@"{%f, %f}", self.destinationCoordinate.latitude, self.destinationCoordinate.longitude];
    self.destinationAnnotation = destinationAnnotation;
    
    [self.mapView addAnnotation:startAnnotation];
    [self.mapView addAnnotation:destinationAnnotation];
}

//****************************下面是路线规划的方法end****************************


////加载自己的位置
//-(void)loadLocation
//{
//    [[WOTLocationManager shareLocation] getLocationWithBlock:^(CGFloat lat, CGFloat lon,NSString* cityName) {
//        self.lat = lat;
//        self.lng = lon;
//        self.startCoordinate = CLLocationCoordinate2DMake(self.lat, self.lng);
//    }];
//}
-(MAMapView *)mapView
{
    if (_mapView == nil) {
        [AMapServices sharedServices].enableHTTPS = YES;
        _mapView = [[MAMapView alloc] init];
        _mapView.delegate = self;
    }
    return _mapView;
}

-(UIButton *)pathButton
{
    if (_pathButton == nil) {
        _pathButton = [[UIButton alloc] init];
        [_pathButton setBackgroundImage:[UIImage imageNamed:@"pathButton"] forState:UIControlStateNormal];
        [_pathButton addTarget:self action:@selector(pathButtonMethod) forControlEvents:UIControlEventTouchDown];
    }
    return _pathButton;
}

-(UIButton *)locationButton
{
    if (_locationButton == nil) {
        _locationButton = [[UIButton alloc] init];
        [_locationButton setBackgroundImage:[UIImage imageNamed:@"locationButton"] forState:UIControlStateNormal];
        [_locationButton addTarget:self action:@selector(startSerialLocation) forControlEvents:UIControlEventTouchDown];
    }
    return _locationButton;
    
}


@end
