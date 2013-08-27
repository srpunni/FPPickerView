//
//  TraingularView.m
//  FPPickerView
//
//  Created by XAV-MAC13 on 08/08/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import "TraingularView.h"

@implementation TraingularView
static float r,g,b,a;
static UIColor* tColor;
+(void)setColor:(UIColor*)clr
{
    tColor=clr;
}
+(UIColor*)color
{
    return tColor;
}
+(void)setArrowColorWithRed:(float)red green:(float)green blue:(float)blue andAlpha:(float)alpha
{
    r=red;
    g=green;
    b=blue;
    a=alpha;
}
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)drawRect:(CGRect)rect
{
    CGContextRef ctx = UIGraphicsGetCurrentContext();
    
    CGContextBeginPath(ctx);
    if (self.tag==222) {
        CGContextMoveToPoint   (ctx, CGRectGetMidX(rect), CGRectGetMinY(rect));  // top left
        CGContextAddLineToPoint(ctx, CGRectGetMinX(rect), CGRectGetMaxY(rect));  // mid right
        CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMaxY(rect));  // bottom left

    }
    else
    {
    CGContextMoveToPoint   (ctx, CGRectGetMinX(rect), CGRectGetMinY(rect));  // top left
    CGContextAddLineToPoint(ctx, CGRectGetMaxX(rect), CGRectGetMinY(rect));  // mid right
    CGContextAddLineToPoint(ctx, CGRectGetMidX(rect), CGRectGetMaxY(rect));  // bottom left
    CGContextClosePath(ctx);
    }
    
    CGColorRef color = [tColor CGColor];
    
    int numComponents = CGColorGetNumberOfComponents(color);
    
    if (numComponents == 4)
    {
        const CGFloat *components = CGColorGetComponents(color);
        CGFloat red = components[0];
        CGFloat green = components[1];
        CGFloat blue = components[2];
        CGFloat alpha = components[3];
        CGContextSetRGBFillColor(ctx,red, green, blue, alpha);
    }
    else
    {
         CGContextSetRGBFillColor(ctx,0, 0, 0, 1);
    }
    
    CGContextFillPath(ctx);
}

@end
