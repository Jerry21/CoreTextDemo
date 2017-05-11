//
//  ClickTextLinkUtil.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/11.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "ClickTextLinkUtil.h"
#import "CoreTextLinkData.h"
#import "YYCoreTextData.h"

@implementation ClickTextLinkUtil

+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(YYCoreTextData *)data
{
    CTFrameRef textFrame = data.ctFrame;
    CFArrayRef lines = CTFrameGetLines(textFrame);
    if (!lines) return nil;
    CFIndex count = CFArrayGetCount(lines);
    CoreTextLinkData *foundLink = nil;
    
    // 获得每一行的origin坐标
    CGPoint origins[count];
    CTFrameGetLineOrigins(textFrame, CFRangeMake(0, 0), origins);
    
    // 翻转坐标系
    CGAffineTransform transfrom = CGAffineTransformMakeTranslation(0, view.bounds.size.height);
    transfrom = CGAffineTransformScale(transfrom, 1, -1);
    
    for (NSInteger i = 0; i < count; i ++)
    {
        CGPoint linePoint = origins[i];
        CTLineRef line = CFArrayGetValueAtIndex(lines, i);
        CGRect flippedRect = [self getLineBounds:line point:linePoint];
        CGRect rect = CGRectApplyAffineTransform(flippedRect, transfrom);
        
        if (CGRectContainsPoint(rect, point))
        {
            // 将点击的坐标转换成小对于当前行的坐标
            CGPoint relativePoint = CGPointMake(point.x - CGRectGetMinX(rect), point.y - CGRectGetMinY(rect));
            
            // 获得当前点击坐标对应的字符串偏移
            CFIndex idx = CTLineGetStringIndexForPosition(line, relativePoint);
            
            // 判断这个偏移是否在我们的链接列表
            foundLink = [self lineAtIndex:idx linkArray:data.linkArray];
            return foundLink;
        }
    }
    return nil;
}

+ (CGRect)getLineBounds:(CTLineRef)line point:(CGPoint)point
{
    CGFloat ascent = 0;
    CGFloat descent = 0;
    CGFloat leading = 0;
    CGFloat width = (CGFloat)CTLineGetTypographicBounds(line, &ascent, &descent, &leading);
    CGFloat height = ascent + descent;
    return CGRectMake(point.x, point.y - descent, width, height);
}

+ (CoreTextLinkData *)lineAtIndex:(CFIndex)i linkArray:(NSArray *)linkArray
{
    CoreTextLinkData *link = nil;
    for (CoreTextLinkData *data in linkArray)
    {
        if (NSLocationInRange(i, data.range))
        {
            link = data;
            break;
        }
    }
    return link;
}
@end
