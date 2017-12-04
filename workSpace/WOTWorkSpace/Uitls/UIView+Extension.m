//
//  UIView+Extension.m
//  WOTWorkSpace
//
//  Created by 张姝枫 on 2017/7/1.
//  Copyright © 2017年 张姝枫. All rights reserved.
//

#import "UIView+Extension.h"

@implementation UIView(Extension)


// Retrieve and set the origin
- (CGPoint) origin
{
    return self.frame.origin;
}

- (void) setOrigin: (CGPoint) aPoint
{
    CGRect newframe = self.frame;
    newframe.origin = aPoint;
    self.frame = newframe;
}


// Retrieve and set the size
- (CGSize) size
{
    return self.frame.size;
}

- (void) setSize: (CGSize) aSize
{
    CGRect newframe = self.frame;
    newframe.size = aSize;
    self.frame = newframe;
}

// Query other frame locations
- (CGPoint) bottomRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) bottomLeft
{
    CGFloat x = self.frame.origin.x;
    CGFloat y = self.frame.origin.y + self.frame.size.height;
    return CGPointMake(x, y);
}

- (CGPoint) topRight
{
    CGFloat x = self.frame.origin.x + self.frame.size.width;
    CGFloat y = self.frame.origin.y;
    return CGPointMake(x, y);
}


// Retrieve and set height, width, top, bottom, left, right
- (CGFloat) height
{
    return self.frame.size.height;
}

- (void) setHeight: (CGFloat) newheight
{
    CGRect newframe = self.frame;
    newframe.size.height = newheight;
    self.frame = newframe;
}

- (CGFloat) width
{
    return self.frame.size.width;
}

- (void) setWidth: (CGFloat) newwidth
{
    CGRect newframe = self.frame;
    newframe.size.width = newwidth;
    self.frame = newframe;
}

- (CGFloat) top
{
    return self.frame.origin.y;
}

- (void) setTop: (CGFloat) newtop
{
    CGRect newframe = self.frame;
    newframe.origin.y = newtop;
    self.frame = newframe;
}

- (CGFloat) left
{
    return self.frame.origin.x;
}

- (void) setLeft: (CGFloat) newleft
{
    CGRect newframe = self.frame;
    newframe.origin.x = newleft;
    self.frame = newframe;
}

- (CGFloat) bottom
{
    return self.frame.origin.y + self.frame.size.height;
}

- (void) setBottom: (CGFloat) newbottom
{
    CGRect newframe = self.frame;
    newframe.origin.y = newbottom - self.frame.size.height;
    self.frame = newframe;
}

- (CGFloat) right
{
    return self.frame.origin.x + self.frame.size.width;
}

- (void) setRight: (CGFloat) newright
{
    CGFloat delta = newright - (self.frame.origin.x + self.frame.size.width);
    CGRect newframe = self.frame;
    newframe.origin.x += delta ;
    self.frame = newframe;
}


-(void)setDefaultRadiuWithCorners:(UIRectCorner)corners{
    [self setRadiuWithCorners:corners radiu:5];
}

-(void)setRadiuWithCorners:(UIRectCorner)corners radiu:(CGFloat)radiu{
    CAShapeLayer *shapeLayer = [CAShapeLayer layer];
    shapeLayer.frame = self.bounds;
    shapeLayer.path = [UIBezierPath bezierPathWithRoundedRect:self.bounds byRoundingCorners:corners cornerRadii:CGSizeMake(radiu, radiu)].CGPath;
    self.layer.mask = shapeLayer;
    
}

-(void)setCorenerRadius:(CGFloat)radiu borderColor:(UIColor *)borderColor{
   
    self.layer.cornerRadius = radiu;
    self.layer.masksToBounds = YES;
    self.layer.borderColor = borderColor.CGColor;
    self.layer.borderWidth = 1;
}

//
//-(UIImage *)toImage{
//    UIGraphicsBeginImageContext(CGSizeMake(self.bounds.size.width, self.bounds.size.height));
//    CGContextRef currentContex = UIGraphicsGetCurrentContext();
//    [self.layer renderInContext:currentContex];
//    UIImage *result = UIGraphicsGetImageFromCurrentImageContext();
//    UIGraphicsEndImageContext();
//    [self cutImage:result size:self.bounds.size];
//    return result;
//    
//}



//裁剪图片
/**
 *
 *
 */
- (UIImage *)cutImage:(UIImage*)originImage size:(CGSize)viewsize
{
    CGSize newImageSize;
    CGImageRef imageRef = nil;
    
    CGSize imageViewSize = viewsize;
    CGSize originImageSize = originImage.size;
    
    if ((originImageSize.width / originImageSize.height) < (imageViewSize.width / imageViewSize.height))
    {
        // imageView的宽高比 > image的宽高比
        newImageSize.width = originImageSize.width;
        newImageSize.height = imageViewSize.height * (originImageSize.width / imageViewSize.width);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(0, fabs(originImageSize.height - newImageSize.height) / 2, newImageSize.width, newImageSize.height));
    }
    else
    {
        // image的宽高比 > imageView的宽高比   ： 也就是说原始图片比较狭长
        newImageSize.height = originImageSize.height;
        newImageSize.width = imageViewSize.width * (originImageSize.height / imageViewSize.height);
        
        imageRef = CGImageCreateWithImageInRect([originImage CGImage], CGRectMake(fabs(originImageSize.width - newImageSize.width) / 2, 0, newImageSize.width, newImageSize.height));
    }
    
    return [UIImage imageWithCGImage:imageRef];
}

- (UIViewController *)GetSubordinateControllerForSelf
{
    UIResponder *next = [self nextResponder];
    while (next != Nil)
    {
        if ([next isKindOfClass:[UIViewController class]])
        {
            return (UIViewController *)next;
        }
        next = [next nextResponder];
    }
    return nil;
}

//设置view的阴影

-(void)setShadow:(UIColor *)shadowColor{
    self.layer.shadowColor = shadowColor.CGColor;
    self.layer.shadowRadius = 4.f;
    self.layer.shadowOpacity = 0.2f;
    self.layer.shadowOffset = CGSizeMake(1, 1);
    self.layer.cornerRadius = 4.f;
}
@end
