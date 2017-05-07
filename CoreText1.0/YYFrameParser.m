//
//  YYFrameParser.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
//  

#import "YYFrameParser.h"

@implementation YYFrameParser

// 要设置的属性
+ (NSDictionary *)attrbutesWithConfig:(YYFrameParserConfig *)config
{
    CGFloat fontSize = config.fontSize;
    CTFontRef fonfRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
    
    CGFloat lineSpace = config.lineSpace;
    const CFIndex kNumberOfSettings = 3;
    CTParagraphStyleSetting theSettings[kNumberOfSettings] = {
        {kCTParagraphStyleSpecifierLineSpacingAdjustment,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMaximumLineSpacing,sizeof(CGFloat),&lineSpace},
        {kCTParagraphStyleSpecifierMinimumLineSpacing,sizeof(CGFloat),&lineSpace}
    };
    
    CTParagraphStyleRef theParagraphRef = CTParagraphStyleCreate(theSettings, kNumberOfSettings);
    
    UIColor *textColor = config.textColor;
    NSMutableDictionary *dict = [NSMutableDictionary dictionary];
    dict[NSForegroundColorAttributeName] = (__bridge id _Nullable)(textColor.CGColor);
    dict[NSFontAttributeName] = (__bridge id _Nullable)fonfRef;
    dict[NSParagraphStyleAttributeName] = (__bridge id _Nullable)theParagraphRef;
    
    CFRelease(theParagraphRef);
    CFRelease(fonfRef);
    return dict;
}

+ (CTFrameRef)createFrameWithFramesetter:(CTFramesetterRef)framesetter config:(YYFrameParserConfig *)config height:(CGFloat)height
{
    CGMutablePathRef path = CGPathCreateMutable();
    CGPathAddRect(path, NULL, CGRectMake(0, 0, config.width, height));
    
    CTFrameRef frame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, 0), path, NULL);
    CFRelease(path);
    return frame;
}


+ (YYCoreTextData *)parseContent:(NSString *)contetn config:(YYFrameParserConfig *)config
{
    NSDictionary *attrs = [self attrbutesWithConfig:config];
    NSAttributedString *contetnString = [[NSAttributedString alloc] initWithString:contetn attributes:attrs];
    
    // 创建 CTFramesetterRef 实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)contetnString);
    
    // 创建要绘制的区域高度 restrict ：约束，限定
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 创建 CTFrameRef 实例
    CTFrameRef frame = [self createFrameWithFramesetter:framesetter config:config height:textHeight];
    
    // 将生成好的 CTFrameRef 实例和计算好的高度保存到YYCoreTextData实例中，返回实例
    YYCoreTextData *data = [[YYCoreTextData alloc] init];
    data.ctFrame = frame;
    data.height = textHeight;
    
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}

@end
