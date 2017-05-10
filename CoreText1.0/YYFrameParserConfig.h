//
//  YYFrameParserConfig.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
// 用于显示的类，仅仅负责显示，不负责内容

#import <UIKit/UIKit.h>

@interface YYFrameParserConfig : NSObject

@property (nonatomic, assign) CGFloat width;
@property (nonatomic, assign) CGFloat fontSize;
@property (nonatomic, assign) CGFloat lineSpace;
@property (nonatomic, strong) UIColor *textColor; 

@end
