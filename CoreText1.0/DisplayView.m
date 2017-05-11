//
//  DisplayView.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/6.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>
#import "CoreTextLinkData.h"
#import "ClickTextLinkUtil.h"

NSString *const YYDisplayerViewPressedNotificatioin = @"YYDisplayerViewPressedNotificatioin";

@interface DisplayView()<UIGestureRecognizerDelegate>

@end

@implementation DisplayView

- (instancetype)init
{
    return [self initWithFrame:CGRectZero];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setupEvent];
    }
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    self = [super initWithCoder:coder];
    if (self) {
        [self setupEvent];
    }
    return self;
}

- (void)setupEvent
{
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapClick:)];
    tap.delegate = self;
    [self addGestureRecognizer:tap];
    self.userInteractionEnabled = YES;
}

- (void)tapClick:(UITapGestureRecognizer *)tap
{
    CGPoint point = [tap locationInView:self];
    for (CoreTextImageData *imageData in self.data.imageArray)
    {
        // 翻转坐标系
        CGRect imageRect = imageData.imagePosition;
        CGPoint imagePosition = imageRect.origin;
        imagePosition.y = self.bounds.size.height - imageRect.origin.y - imageRect.size.height;
        CGRect rect = CGRectMake(imagePosition.x, imagePosition.y, imageRect.size.width, imageRect.size.height);
        
        // 检测点击位置 point 是否在 rect 之内
        if (CGRectContainsPoint(rect, point))
        {
            // 点击后的处理逻辑
            NSDictionary *userInfo = @{@"imageData": imageData};
            [[NSNotificationCenter defaultCenter] postNotificationName:YYDisplayerViewPressedNotificatioin object:self userInfo:userInfo];
            break;
        }
    }
    
    CoreTextLinkData *linkData = [ClickTextLinkUtil touchLinkInView:self atPoint:point data:self.data];
    if (linkData) {
        NSLog(@"%@",linkData.url);
        return;
    }
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
    
    for (CoreTextImageData *imageData in self.data.imageArray) {
        UIImage *image = [UIImage imageNamed:imageData.name];
        if (image) {
            CGContextDrawImage(content, imageData.imagePosition, image.CGImage);
            NSLog(@"imagePosition:%@-----name:%@",NSStringFromCGRect(imageData.imagePosition),imageData.name);
        }
    }
}

- (void)simpleImplementation
{
     // 1.获得图形上下文
     CGContextRef context = UIGraphicsGetCurrentContext();
     
     // 2.翻转坐标系
     CGContextSetTextMatrix(context, CGAffineTransformIdentity); // Matrix 模型；矩阵
     CGContextTranslateCTM(context, 0, self.bounds.size.height);
     CGContextScaleCTM(context, 1.0, -1.0);
     
     
     // 3.创建绘制区域
     CGMutablePathRef path = CGPathCreateMutable();
     //    CGPathAddRect(path, NULL, self.bounds);
     
     CGPathAddEllipseInRect(path, NULL, self.bounds);
     
     
     // 4.添加内容
     //    NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"叶子扬州"];
     
     NSAttributedString *attrString = [[NSAttributedString alloc] initWithString:@"一个70岁的商业思想家，10多位40岁出头的战略企业家，几千位30-40岁出头的中高层管理者，率领着10多万20-30岁的以中高级青年知识分子为主体的知识型劳动大军，孤独行走在全球五大洲的每个角落。华为，一个以“狼性文化”著称的全球通信设备制造企业，它的成功绝非偶然。-东方幽灵的“上甘岭”"];
     CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)attrString);
     CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, attrString.length), path, NULL);
     
     // 5.绘制
     CTFrameDraw(frame, context);
}

@end
