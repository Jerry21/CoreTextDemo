//
//  YYFrameParserConfig.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
//  

#import "YYFrameParserConfig.h"

@implementation YYFrameParserConfig
- (instancetype)init
{
    self = [super init];
    if (self) {
        _width = 200;
        _fontSize = 16;
        _lineSpace = 8;
        _textColor = YYRGB(108,108,108);
    }
    return self;
}
@end
