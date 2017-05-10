//
//  DisplayView.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/6.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "DisplayView.h"
#import <CoreText/CoreText.h>

@implementation DisplayView

- (void)awakeFromNib
{
    [super awakeFromNib];
//    self.backgroundColor = [UIColor yellowColor];
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor yellowColor];
    }
    return self;
}

- (void)drawRect:(CGRect)rect {
    
    /*
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
     
     */
    
    [super drawRect:rect];
    CGContextRef content = UIGraphicsGetCurrentContext();
    CGContextSetTextMatrix(content, CGAffineTransformIdentity);
    CGContextTranslateCTM(content, 0, self.bounds.size.height);
    CGContextScaleCTM(content, 1.0, -1.0);
    
    if (self.data) {
        CTFrameDraw(self.data.ctFrame, content);
    }
}


@end
