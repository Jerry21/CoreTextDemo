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
+ (NSDictionary *)attributesWithConfig:(YYFrameParserConfig *)config
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
    NSDictionary *attrs = [self attributesWithConfig:config];
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
/// 以下是解析模板文件的多种实现方法,其中config都已经在file中配置好了
// way 1 :对外接口
+ (YYCoreTextData *)parseTemplateFile:(NSString *)path config:(YYFrameParserConfig *)config
{
    NSAttributedString *content = [self loadTemplateFile:path config:config];
    return [self parseAttributedContent:content config:config];
}

// way 2
+ (NSAttributedString *)loadTemplateFile:(NSString *)path config:(YYFrameParserConfig *)config
{
    NSData *data = [NSData dataWithContentsOfFile:path];
    NSMutableAttributedString * reuslt = [[NSMutableAttributedString alloc] init];
    if (data) {
        NSArray *array = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingAllowFragments error:nil];
        
        if ([array isKindOfClass:[NSArray class]]) {
            for (NSDictionary *dict in array) {
                NSString *type = dict[@"type"];
                if ([type isEqualToString:@"txt"]) {
                    NSAttributedString *as = [self parseAttributedContentFromNSDictionary:dict
                                                                                   config:config];
                    [reuslt appendAttributedString:as];
                }
            }
        }
    }
    return reuslt;
}

// way 3
+ (NSAttributedString *)parseAttributedContentFromNSDictionary:(NSDictionary *)dict
                                                        config:(YYFrameParserConfig *)config
{
    NSMutableDictionary *attrs = [self attributesWithConfig:config];
    
    // set color
    UIColor *color = [self colorFromTemplate:dict[@"color"]];
    if (color) {
        attrs[NSForegroundColorAttributeName] = (__bridge id _Nullable)(color.CGColor);
    }
    
    // set font size
    CGFloat fontSize = [dict[@"size"] floatValue];
    if (fontSize > 0) {
        CTFontRef fontRef = CTFontCreateWithName((CFStringRef)@"ArialMT", fontSize, NULL);
        attrs[NSFontAttributeName] = (__bridge id _Nullable)fontRef;
        CFRelease(fontRef);
    }
    
    NSString *content = dict[@"content"];
    return [[NSAttributedString alloc] initWithString:content attributes:attrs];
}


// way 4
+ (UIColor *)colorFromTemplate:(NSString *)name
{
    if ([name isEqualToString:@"blue"]) {
        return [UIColor blueColor];
    }else if ([name isEqualToString:@"red"]){
        return [UIColor redColor];
    }else if ([name isEqualToString:@"green"]){
        return [UIColor greenColor];
    }else if ([name isEqualToString:@"black"]){
        return [UIColor blackColor];
    }else if ([name isEqualToString:@"yellow"]){
        return [UIColor yellowColor];
    }
    return nil;
}


// way 5
+ (YYCoreTextData *)parseAttributedContent:(NSAttributedString *)content config:(YYFrameParserConfig *)config
{
    // 获得 CTFramesetterRef 实例
    CTFramesetterRef framesetter = CTFramesetterCreateWithAttributedString((CFAttributedStringRef)content);
    
    // 设置高度
    CGSize restrictSize = CGSizeMake(config.width, CGFLOAT_MAX);
    CGSize coreTextSize = CTFramesetterSuggestFrameSizeWithConstraints(framesetter, CFRangeMake(0, 0), nil, restrictSize, nil);
    CGFloat textHeight = coreTextSize.height;
    
    // 生成 CTFrameRef 实例
    CTFrameRef frame = [self createFrameWithFramesetter:(framesetter) config:config height:textHeight];
    
    // 保存数据到YYData中
    YYCoreTextData *data = [[YYCoreTextData alloc] init];
    data.height = textHeight;
    data.ctFrame = frame;
    
    // 释放
    CFRelease(frame);
    CFRelease(framesetter);
    return data;
}


@end
