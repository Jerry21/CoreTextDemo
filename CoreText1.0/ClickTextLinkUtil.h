//
//  ClickTextLinkUtil.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/11.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@class CoreTextLinkData;
@class YYCoreTextData;

@interface ClickTextLinkUtil : NSObject
+ (CoreTextLinkData *)touchLinkInView:(UIView *)view atPoint:(CGPoint)point data:(YYCoreTextData *)data;
@end
