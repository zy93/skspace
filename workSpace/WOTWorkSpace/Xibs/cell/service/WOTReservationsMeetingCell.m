//
//  WOTReservationsMeetingCell.m
//  WOTWorkSpace
//
//  Created by 张雨 on 2017/7/10.
//  Copyright © 2017年 北京物联港科技发展有限公司. All rights reserved.
//

#import "WOTReservationsMeetingCell.h"
#import "WOTReservationsMeetingVC.h"
#import "WOTMeetingReservationsModel.h"
#import "WOTSiteReservationsModel.h"

@implementation WOTReservationsMeetingCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
    self.clipsToBounds = YES;
    [self.meetingImgBGView setBackgroundColor:COLOR(40, 43, 50, 0.6)];
    self.selectTimeScroll.mDelegate = self;
    self.selectIndicationView.layer.borderColor = UIColor_gray_d6.CGColor;
    self.selectIndicationView.layer.borderWidth = 1.f;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}


- (IBAction)clickSubmit:(id)sender {
    if ([_delegate respondsToSelector:@selector(submitReservationsCell:)]) {
        [_delegate submitReservationsCell:self];
    }
}


#pragma mark - WOTScrollView Delegate
-(void)selectButton:(WOTScrollButton *)button
{
    if ([_delegate respondsToSelector:@selector(selectTimeWithCell:Time:)]) {
        [_delegate selectTimeWithCell:self Time:button.time];
    }
    [self setNeedsLayout];
}



-(void)setMeetingModel:(WOTMeetingListModel *)meetingModel
{
   // NSLog(@"测试：%@",meetingModel);
    _meetingModel = meetingModel;
    [self.meetingNameLab setText:_meetingModel.conferenceName];
    [self.meetingInfoLab setText:_meetingModel.conferenceDescribe];
    [self.meetingImg sd_setImageWithURL:[_meetingModel.conferencePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
    [self.meetingPriceLab setText:[NSString stringWithFormat:@"%.2f元/小时",[_meetingModel.conferencePrice floatValue]]];
    //[self.meetingOpenTime setText:_meetingModel.openTime];
    [self.meetingOpenTimeLab setText:[NSString stringWithFormat:@"会议室开放时间：%@",_meetingModel.openTime]];
    [self.selectTimeScroll setupView];
    [self.selectTimeScroll setOpenTime:_meetingModel.openTime];
    [self loadMeetingReservationsInfo];
}

-(void)setSiteModel:(WOTSiteModel *)siteModel
{
    _siteModel = siteModel;
    //NSLog(@"测试：%@",siteModel);
    [self.meetingNameLab setText:_siteModel.siteName];
    [self.meetingInfoLab setText:_siteModel.siteDescribe];
    [self.meetingImg sd_setImageWithURL:[_siteModel.sitePicture ToUrl] placeholderImage:[UIImage imageNamed:@"bookStation"]];
    [self.meetingPriceLab setText:[NSString stringWithFormat:@"%.2f元/小时",[_siteModel.sitePrice floatValue]]];
    //[self.meetingOpenTime setText:_siteModel.openTime];
    [self.meetingOpenTimeLab setText:[NSString stringWithFormat:@"场地开放时间：%@",_siteModel.openTime]];
    [self.selectTimeScroll setupView];
    [self.selectTimeScroll setOpenTime:_siteModel.openTime];
    [self loadSiteReservationsInfo];
}

#pragma mark - view layout
-(void)setupView {
    [self.selectTimeScroll setupView];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    WOTReservationsMeetingVC *vc = (WOTReservationsMeetingVC *)[self GetSubordinateControllerForSelf];
    self.allTime = vc.endTime - vc.beginTime;
    NSString *str =[NSString stringWithFormat:@"共%.1f小时",self.allTime];
    self.TimeStatisticLab.text = str;
    self.timeStatisticsLab.text = [NSString stringWithFormat:@"%@-%@",[NSString floatTimeConvertStringTime:vc.beginTime],[NSString floatTimeConvertStringTime:vc.endTime]];
}

-(void)loadMeetingReservationsInfo
{
    //    @"2017/07/13 00:00:00"
    [WOTHTTPNetwork getMeetingReservationsTimeWithSpaceId:_meetingModel.spaceId conferenceId:_meetingModel.conferenceId startTime:_inquireTime response:^(id bean, NSError *error) {
        
        WOTMeetingReservationsModel_msg *mod =(WOTMeetingReservationsModel_msg *) bean;
        NSMutableArray *reserList = [NSMutableArray new];
        for (WOTMeetingReservationsModel * model in  mod.msg) {
            NSArray *arr = [NSString getReservationsTimesWithStartTime:model.startTime endTime:model.endTime];
            [reserList addObject:arr];
        }
        dispatch_async(dispatch_get_main_queue(), ^{
            [self.selectTimeScroll setInvalidBtnTimeList:reserList];
        });
    }];
}


-(void)loadSiteReservationsInfo
{
    
    [WOTHTTPNetwork getSiteReservationsTimeWithSpaceId:_siteModel.spaceId siteId:_siteModel.siteId startTime:_inquireTime response:^(id bean, NSError *error) {
        WOTSiteReservationsModel_Msg *mod = bean;
        NSMutableArray *reserList = [NSMutableArray new];
        for (WOTSiteReservationsModel * model in  mod.msg) {
            NSArray *arr = [NSString getReservationsTimesWithStartTime:model.startTime endTime:model.endTime];
            [reserList addObject:arr];
        }
        if ([_siteModel.siteName isEqualToString:@"大厅"]) {
            NSLog(@"-------");
        }
        dispatch_async(dispatch_get_main_queue(), ^{
           // NSLog(@"测试：%@",reserList);
            [self.selectTimeScroll setInvalidBtnTimeList:reserList];
        });
    }];
}

#pragma mark - touches

-(void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesBegan:touches withEvent:event];
}

-(void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesEnded:touches withEvent:event];
}

-(void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [[self nextResponder] touchesCancelled:touches withEvent:event];
}

@end
