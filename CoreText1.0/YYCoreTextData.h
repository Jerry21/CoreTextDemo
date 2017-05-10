//
//  YYCoreTextData.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/7.
//  Copyright © 2017年 yejunyou. All rights reserved.
//  排版类，实现文字内容的排版

#import <UIKit/UIKit.h>
#import "CoreTextImageData.h"

@interface YYCoreTextData : NSObject
@property (nonatomic, assign) CTFrameRef ctFrame;
@property (nonatomic, assign) CGFloat height;
@property (nonatomic, strong) NSArray *imageArray; 
@end
