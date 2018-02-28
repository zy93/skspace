//
//  SKSapceLocationView.m
//  MapDemo
//
//  Created by wangxiaodong on 2018/2/11.
//  Copyright © 2018年 wangxiaodong. All rights reserved.
//

#import "SKSapceLocationView.h"
#import "Masonry.h"
#import <MAMapKit/MAMapKit.h>
#import <AMapFoundationKit/AMapFoundationKit.h>

@interface  SKSapceLocationView ()<MAMapViewDelegate>

@property(nonatomic,strong)MAMapView *mapView;
@end

@implementation SKSapceLocationView

-(instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        //[self addSubview:self.mapView];
       // [self setUpMapView];
    }
    return self;
}

-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        [self addSubview:self.mapView];
        [self setUpLayout];
    }
    return self;
}


-(void)setDataSpacelocationWithPointLng:(NSNumber *)pointLng  pointLat:(NSNumber *)pointLat
{
    MAPointAnnotation *pointAnnotation = [[MAPointAnnotation alloc] init];
    
    pointAnnotation.coordinate = CLLocationCoordinate2DMake([pointLat floatValue], [pointLng floatValue]);
    [self.mapView setCenterCoordinate:pointAnnotation.coordinate animated:YES];
    [self.mapView addAnnotation:pointAnnotation];
    [_mapView setZoomLevel:12 animated:YES];
}

-(void)setUpLayout
{
    //[super layoutSubviews];
    [self.mapView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.equalTo(self).with.offset(0);
        make.bottom.right.equalTo(self).with.offset(0);
    }];
}

#pragma mark - MAMapViewDelegate
- (MAAnnotationView *)mapView:(MAMapView *)mapView viewForAnnotation:(id <MAAnnotation>)annotation
{
    if ([annotation isKindOfClass:[MAPointAnnotation class]])
    {
        static NSString *pointReuseIndentifier = @"pointReuseIndentifier";
        MAPinAnnotationView*annotationView = (MAPinAnnotationView*)[mapView dequeueReusableAnnotationViewWithIdentifier:pointReuseIndentifier];
        if (annotationView == nil)
        {
            annotationView = [[MAPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:pointReuseIndentifier];
        }
        annotationView.canShowCallout= YES;       //设置气泡可以弹出，默认为NO
        annotationView.animatesDrop = YES;        //设置标注动画显示，默认为NO
        //annotationView.draggable = YES;        //设置标注可以拖动，默认为NO
        annotationView.pinColor = MAPinAnnotationColorPurple;
        annotationView.image = [UIImage imageNamed:@"restaurant"];
        
        return annotationView;
    }
    return nil;
}

-(MAMapView *)mapView
{
    if (_mapView == nil) {
        [AMapServices sharedServices].enableHTTPS = YES;
        _mapView = [[MAMapView alloc] init];
        
        _mapView.delegate = self;
    }
    return _mapView;
}

@end
