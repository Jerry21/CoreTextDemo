//
//  DisplayTextField.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "DisplayTextField.h"
#import <CoreText/CoreText.h>

@implementation DisplayTextField

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor yellowColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
//        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    [super drawRect:rect];
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(content, CGAffineTransformIdentity);
    CGContextTranslateCTM(content, 0, self.bounds.size.height);
    CGContextScaleCTM(content, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, content);
    }
    
    CFRelease(content);
}

@end
