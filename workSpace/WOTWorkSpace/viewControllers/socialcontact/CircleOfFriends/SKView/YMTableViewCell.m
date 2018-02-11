//
//  YMTableViewCell.m
//  WFCoretext
//
//  Created by 阿虎 on 14/10/28.
//  Copyright (c) 2014年 tigerwf. All rights reserved.
// 2 3 2 2 2 3 1 3 2 1

#import "YMTableViewCell.h"
#import "WFReplyBody.h"
#import "ContantHead.h"
#import "YMTapGestureRecongnizer.h"
#import "WFHudView.h"
#import "UIImageView+WebCache.h"
#import "UIColor+ColorChange.h"

#define kImageTag 9999


@implementation YMTableViewCell
{
    UIButton *foldBtn;
    YMTextData *tempDate;
    
    BOOL isOpen;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        self.backgroundColor = [UIColor clearColor];
        //头像
        _userHeaderImage = [[UIImageView alloc] initWithFrame:CGRectMake(12, 5, 42, 42)];
        _userHeaderImage.backgroundColor = [UIColor clearColor];
//        CALayer *layer = [_userHeaderImage layer];
//        [layer setMasksToBounds:YES];
//        [layer setCornerRadius:10.0];
//        [layer setBorderWidth:1];
//        [layer setBorderColor:[[UIColor clearColor] CGColor]];
        [self.contentView addSubview:_userHeaderImage];
        
        //用户名
        _userNameLbl = [[UILabel alloc] initWithFrame:CGRectMake(_userHeaderImage.frame.origin.x+_userHeaderImage.frame.size.width+10, 5, screenWidth - 120, TableHeader/2)];
        _userNameLbl.textAlignment = NSTextAlignmentLeft;
        _userNameLbl.font = [UIFont systemFontOfSize:15.0];
        _userNameLbl.textColor = [UIColor colorWithHexString:@"666666"];
        [self.contentView addSubview:_userNameLbl];
        
        
        
        _userIntroLbl = [[UILabel alloc] initWithFrame:CGRectMake(20 + TableHeader + 20, 5 + TableHeader/2 , screenWidth - 120, TableHeader/2)];
        _userIntroLbl.numberOfLines = 1;
        _userIntroLbl.font = [UIFont systemFontOfSize:14.0];
        _userIntroLbl.textColor = [UIColor grayColor];
        [self.contentView addSubview:_userIntroLbl];
        
        
        
        _imageArray = [[NSMutableArray alloc] init];
        _ymTextArray = [[NSMutableArray alloc] init];
        _ymShuoshuoArray = [[NSMutableArray alloc] init];
        _ymFavourArray = [[NSMutableArray alloc] init];
        
        foldBtn = [UIButton buttonWithType:0];
        [foldBtn setTitle:@"展开" forState:0];
        foldBtn.backgroundColor = [UIColor clearColor];
        foldBtn.titleLabel.font = [UIFont systemFontOfSize:15.0];
        [foldBtn setTitleColor:[UIColor grayColor] forState:0];
        [foldBtn addTarget:self action:@selector(foldText) forControlEvents:UIControlEventTouchUpInside];
        [self.contentView addSubview:foldBtn];
        
        _openCommentBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        [_openCommentBtn setTitle:@"共0条评论>"  forState:UIControlStateNormal];
        _openCommentBtn.contentHorizontalAlignment = UIControlContentHorizontalAlignmentLeft;
        _openCommentBtn.titleLabel.font = [UIFont systemFontOfSize:12.0];
        [foldBtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        [_openCommentBtn setTitleColor:[UIColor blackColor]forState:UIControlStateNormal];
        [_openCommentBtn addTarget:self action:@selector(openCommentBtnMethod) forControlEvents:UIControlEventTouchDown];
        [self.contentView addSubview:_openCommentBtn];
        
        _replyImageView = [[UIImageView alloc] init];
        
        _replyImageView.backgroundColor = [UIColor colorWithRed:242/255.0 green:242/255.0 blue:242/255.0 alpha:1.0];
        [self.contentView addSubview:_replyImageView];
        
        _replyBtn = [YMButton buttonWithType:0];
        [_replyBtn setImage:[UIImage imageNamed:@"fw_r2_c2.png"] forState:0];
        [self.contentView addSubview:_replyBtn];
        
        _favourImage = [[UIImageView alloc] initWithFrame:CGRectZero];
        _favourImage.image = [UIImage imageNamed:@"zan.png"];
        [self.contentView addSubview:_favourImage];
        
        _addTimeLabel = [[UILabel alloc] init];
        //_addTimeLabel.text = @"2017-12-07";
        _addTimeLabel.textColor = [UIColor colorWithHexString:@"999999"];
        [_addTimeLabel setFont:[UIFont systemFontOfSize:12]];
        [self.contentView addSubview:_addTimeLabel];
        
    }
    return self;
}

- (void)foldText{
    
    if (tempDate.foldOrNot == YES) {
        tempDate.foldOrNot = NO;
        [foldBtn setTitle:@"收起" forState:0];
    }else{
        tempDate.foldOrNot = YES;
        [foldBtn setTitle:@"展开" forState:0];
    }
    
    [_delegate changeFoldState:tempDate onCellRow:self.stamp];
    
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


- (void)setYMViewWith:(YMTextData *)ymData{
  
    tempDate = ymData;
#pragma mark -  //头像 昵称 简介
    //_userHeaderImage.image = [UIImage imageNamed:tempDate.messageBody.posterImgstr];
    [_userHeaderImage sd_setImageWithURL:[tempDate.messageBody.posterImgstr ToResourcesUrl] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
    _userNameLbl.text = tempDate.messageBody.posterName;
    _userIntroLbl.text = tempDate.messageBody.posterIntro;
    _addTimeLabel.text = [self cutOutString:tempDate.messageBody.friendTime];
    //移除说说view 避免滚动时内容重叠
    for ( int i = 0; i < _ymShuoshuoArray.count; i ++) {
        WFTextView * imageV = (WFTextView *)[_ymShuoshuoArray objectAtIndex:i];
        if (imageV.superview) {
            [imageV removeFromSuperview];
        }
    }
    [_ymShuoshuoArray removeAllObjects];
  
#pragma mark - // /////////添加说说view

    WFTextView *textView = [[WFTextView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x, 5 + self.userNameLbl.frame.origin.y+self.userNameLbl.frame.size.height, screenWidth - self.userNameLbl.frame.origin.x-15, 0)];
    textView.delegate = self;
    textView.attributedData = ymData.attributedDataShuoshuo;
    //textView.textColor = [UIColor redColor];
    textView.isFold = ymData.foldOrNot;
    textView.isDraw = YES;
    [textView setOldString:ymData.showShuoShuo andNewString:ymData.completionShuoshuo];
    [self.contentView addSubview:textView];
    
    BOOL foldOrnot = ymData.foldOrNot;
    float hhhh = foldOrnot?ymData.shuoshuoHeight:ymData.unFoldShuoHeight;
    
    textView.frame = CGRectMake(self.userNameLbl.frame.origin.x, 5 + self.userNameLbl.frame.origin.y+self.userNameLbl.frame.size.height,screenWidth - self.userNameLbl.frame.origin.x-15, hhhh);
    
    [_ymShuoshuoArray addObject:textView];
    
    //按钮
    foldBtn.frame = CGRectMake(self.userNameLbl.frame.origin.x,  self.userNameLbl.frame.origin.y+self.userNameLbl.frame.size.height + hhhh + 10 , 50, 20 );
    
    if (ymData.islessLimit) {//小于最小限制 隐藏折叠展开按钮
        
        foldBtn.hidden = YES;
    }else{
        foldBtn.hidden = NO;
    }
    
    
    if (tempDate.foldOrNot) {
        
        [foldBtn setTitle:@"展开" forState:0];
    }else{
        
        [foldBtn setTitle:@"收起" forState:0];
    }
#pragma mark - /////// //图片部分
    for (int i = 0; i < [_imageArray count]; i++) {
        //修改成为加载网络图片
        UIImageView * imageV = (UIImageView *)[_imageArray objectAtIndex:i];
        if (imageV.superview) {
            [imageV removeFromSuperview];
            
        }
    }
    
    [_imageArray removeAllObjects];
    
    for (int  i = 0; i < [ymData.showImageArray count]; i++) {
        int num;
        if ((i+1)%3==0 && (i+1) != 0) {
            num = 2;
        }else
        {
            
            num =(i+1)%3-1;
        }
       // UIImageView *image = [[UIImageView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x*(i%3 + 1) + 10*(i%3), 10 * ((i/3) + 1) + (i/3) *  ShowNewImage_H + hhhh + kDistance + (ymData.islessLimit?0:30), ShowNewImage_H, ShowNewImage_H)];
        
        UIImageView *image ;
        if (i==0 || i == 1 || i == 2) {
            image = [[UIImageView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x+ 5*num+ShowNewImage_H*num, 5 * ((i/3) + 1) + (i/3) *  ShowNewImage_H + hhhh + kDistance + (ymData.islessLimit?0:30)+5, ShowNewImage_H, ShowNewImage_H)];
        }else
        {
            image = [[UIImageView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x+ 5*num+ShowNewImage_H*num, 5 * ((i/3) + 1) + (i/3) *  ShowNewImage_H + hhhh + kDistance + (ymData.islessLimit?0:30)+5, ShowNewImage_H, ShowNewImage_H)];
        }
        
        image.userInteractionEnabled = YES;
        
        YMTapGestureRecongnizer *tap = [[YMTapGestureRecongnizer alloc] initWithTarget:self action:@selector(tapImageView:)];
        [image addGestureRecognizer:tap];
        tap.appendArray = ymData.showImageArray;
        image.backgroundColor = [UIColor clearColor];
        image.tag = kImageTag + i;
        image.image = [UIImage imageNamed:[NSString stringWithFormat:@"%@",[ymData.showImageArray objectAtIndex:i]]];
        NSString *imageStr = [NSString stringWithFormat:@"%@",[ymData.showImageArray objectAtIndex:i]];
        [image sd_setImageWithURL:[NSURL URLWithString:imageStr] placeholderImage:[UIImage imageNamed:@"placeholderImage"]];
        [self.contentView addSubview:image];
        [_imageArray addObject:image];
        
    }
    
#pragma mark - /////点赞部分
    //移除点赞view 避免滚动时内容重叠
    for ( int i = 0; i < _ymFavourArray.count; i ++) {
        WFTextView * imageV = (WFTextView *)[_ymFavourArray objectAtIndex:i];
        if (imageV.superview) {
            [imageV removeFromSuperview];
            
        }
    }
    
    [_ymFavourArray removeAllObjects];

    
    float origin_Y = 10;
    NSUInteger scale_Y = ymData.showImageArray.count - 1;
    float balanceHeight = 0; //纯粹为了解决没图片高度的问题
    if (ymData.showImageArray.count == 0) {
        scale_Y = 0;
        balanceHeight = - ShowNewImage_H - kDistance ;
    }
    
    float backView_Y = 0;
    float backView_H = 0;
    
    
    
    WFTextView *favourView = [[WFTextView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x + 30, TableHeader + 10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance, screenWidth - 2 * offSet_X - 30, 0)];
    favourView.delegate = self;
    favourView.attributedData = ymData.attributedDataFavour;
    favourView.isDraw = YES;
    favourView.isFold = NO;
    favourView.canClickAll = NO;
    favourView.textColor = [UIColor redColor];
    [favourView setOldString:ymData.showFavour andNewString:ymData.completionFavour];
    favourView.frame = CGRectMake(self.userNameLbl.frame.origin.x + 30,TableHeader + 10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance, screenWidth - offSet_X * 2 - 30, ymData.favourHeight);
    [self.contentView addSubview:favourView];
    backView_H += ((ymData.favourHeight == 0)?(-kReply_FavourDistance):ymData.favourHeight);
    [_ymFavourArray addObject:favourView];

//点赞图片的位置
   // _favourImage.frame = CGRectMake(offSet_X + 8, favourView.frame.origin.y, (ymData.favourHeight == 0)?0:20,(ymData.favourHeight == 0)?0:20);
    
    
#pragma mark - ///// //最下方回复部分
    for (int i = 0; i < [_ymTextArray count]; i++) {
        
        WFTextView * ymTextView = (WFTextView *)[_ymTextArray objectAtIndex:i];
        if (ymTextView.superview) {
            [ymTextView removeFromSuperview];
            //  NSLog(@"here");
            
        }
        
    }
    
    [_ymTextArray removeAllObjects];
    NSInteger showNum;
    if (!ymData.messageBody.isUnfold) {
        if (ymData.replyDataSource.count > 2) {
            showNum = 2;
            [_openCommentBtn setHidden:NO];
            [_openCommentBtn setTitle:[NSString stringWithFormat:@"共%ld条评论>",ymData.replyDataSource.count] forState:UIControlStateNormal];
        }else
        {
            [_openCommentBtn setHidden:YES];
            showNum = ymData.replyDataSource.count;
        }
        
    } else {
        [_openCommentBtn setHidden:YES];
        showNum = ymData.replyDataSource.count;
    }
    
    
    for (int i = 0; i < showNum; i ++ ) {
        
        WFTextView *_ilcoreText = [[WFTextView alloc] initWithFrame:CGRectMake(self.userNameLbl.frame.origin.x,TableHeader + 10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance + ymData.favourHeight + (ymData.favourHeight == 0?0:kReply_FavourDistance), screenWidth - offSet_X * 2, 0)];
        
        if (i == 0) {
            backView_Y = TableHeader + 10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30);
        }
        
        _ilcoreText.delegate = self;
        _ilcoreText.replyIndex = i;
        _ilcoreText.isFold = NO;
        if (ymData.attributedDataReply.count >0) {
            _ilcoreText.attributedData = [ymData.attributedDataReply objectAtIndex:i];
        }
        
        WFReplyBody *body ;
        if (ymData.replyDataSource.count > 0) {
            body = (WFReplyBody *)[ymData.replyDataSource objectAtIndex:i];
        }
        
        NSString *matchString;
        
        if ([body.repliedUser isEqualToString:@""]) {
            matchString = [NSString stringWithFormat:@"%@:%@",body.replyUser,body.replyInfo];
        }else{
            matchString = [NSString stringWithFormat:@"%@回复%@:%@",body.replyUser,body.repliedUser,body.replyInfo];
        }
        
        if (ymData.completionReplySource.count >0) {
            [_ilcoreText setOldString:matchString andNewString:[ymData.completionReplySource objectAtIndex:i]];
        }
        
        
        _ilcoreText.frame = CGRectMake(self.userNameLbl.frame.origin.x, 5+10+10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance + ymData.favourHeight + (ymData.favourHeight == 0?0:kReply_FavourDistance), screenWidth - offSet_X * 2, [_ilcoreText getTextHeight]);
        [self.contentView addSubview:_ilcoreText];
        origin_Y += [_ilcoreText getTextHeight] + 5 ;
        
        backView_H += _ilcoreText.frame.size.height;
        
        [_ymTextArray addObject:_ilcoreText];
    }
    
    if (!ymData.messageBody.isUnfold) {
        backView_H += (showNum - 1)*5;
    } else {
        backView_H += (ymData.replyDataSource.count - 1)*5;
    }
    
    if (ymData.replyDataSource.count == 0) {//没回复的时候
        _addTimeLabel.frame = CGRectMake(self.userNameLbl.frame.origin.x, 10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance - 24, 100, 20);
        
        _replyImageView.frame = CGRectMake(self.userNameLbl.frame.origin.x, backView_Y - 10 + balanceHeight + 5 + kReplyBtnDistance, 0, 0);
        
        _replyBtn.frame = CGRectMake(screenWidth - offSet_X - 40 + 6,10 + ShowNewImage_H + (ShowNewImage_H + 10)*(scale_Y/3) + origin_Y + hhhh + kDistance + (ymData.islessLimit?0:30) + balanceHeight + kReplyBtnDistance - 24, 40, 18);
       
        _openCommentBtn.frame = CGRectMake(offSet_X, 0, 200, 18);
    }else{
        
        _replyImageView.frame = CGRectMake(self.userNameLbl.frame.origin.x, backView_Y - 10 + balanceHeight + 5 , screenWidth - self.userNameLbl.frame.origin.x -10, backView_H + 20 - 8);//微调
        
        _replyBtn.frame = CGRectMake(screenWidth - offSet_X - 40 + 6, _replyImageView.frame.origin.y - 24, 40, 18);
        NSLog(@"测试高度：%f",_replyImageView.frame.origin.y+backView_H+24);
        _addTimeLabel.frame = CGRectMake(self.userNameLbl.frame.origin.x,_replyImageView.frame.origin.y - 24, 100, 18);
        _openCommentBtn.frame = CGRectMake(self.userNameLbl.frame.origin.x,_replyImageView.frame.origin.y+backView_H+18, 200, 20);
        //tempDate.foldOrNot?0:20
    }
    
    
}

#pragma mark - ilcoreTextDelegate
- (void)clickMyself:(NSString *)clickString{
    
    //延迟调用下  可去掉 下同
    dispatch_time_t popTime = dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.2 * NSEC_PER_SEC));
    dispatch_after(popTime, dispatch_get_main_queue(), ^(void){
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:clickString message:nil delegate:nil cancelButtonTitle:@"好的" otherButtonTitles:nil, nil];
        [alert show];
        
        
    });
    
    
}


- (void)longClickWFCoretext:(NSString *)clickString replyIndex:(NSInteger)index{
  
    if (index == -1) {
        UIPasteboard *pboard = [UIPasteboard generalPasteboard];
        pboard.string = clickString;
    }else{
        [_delegate longClickRichText:_stamp replyIndex:index];
    }
    
}


- (void)clickWFCoretext:(NSString *)clickString replyIndex:(NSInteger)index{
    
    if ([clickString isEqualToString:@""] && index != -1) {
       //reply
        //NSLog(@"reply");
        [_delegate clickRichText:_stamp replyIndex:index];
    }else{
        if ([clickString isEqualToString:@""]) {
            //
        }else{
            [WFHudView showMsg:clickString inView:nil];
        }
    }
    
}

#pragma mark - 点击action
- (void)tapImageView:(YMTapGestureRecongnizer *)tapGes{
    [_delegate showImageViewWithImageViews:tapGes.appendArray byClickWhich:tapGes.view.tag];
}

#pragma mark - 打开评论按钮
-(void)openCommentBtnMethod
{
    NSLog(@"打开评论");
    //[_delegate changeFoldState:tempDate onCellRow:self.stamp];
    if ([_delegate respondsToSelector:@selector(showCommentWith:onCellRow:)]) {
        [_delegate showCommentWith:tempDate onCellRow:self.stamp];
    }
    
}


#pragma mark - 截取字符串--保留年、月、日
-(NSString *)cutOutString:(NSString *)timeString
{
    NSString *str = [timeString substringToIndex:11];
    NSLog(@"截取的值为：%@",str);
    return str;
}

@end
