//
//  YYFrameParser.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
//  模型类，用于承载显示所需要的所有数据

#import <Foundation/Foundation.h>
#import "YYFrameParserConfig.h"
#import "YYCoreTextData.h"

@interface YYFrameParser : NSObject

//+ (NSAttributedString *)attributesWithConfig:(YYFrameParserConfig *)config;

+ (YYCoreTextData *)parseContent:(NSString *)content config:(YYFrameParserConfig *)config;

+ (YYCoreTextData *)parseAttributeContent:(NSString *)content config:(YYFrameParserConfig *)config;

+ (YYCoreTextData *)parseTemplateFile:(NSString *)path config:(YYFrameParserConfig *)config;
@end
