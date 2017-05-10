//
//  CoreTextImageData.h
//  CoreText1.0
//
//  Created by yejunyou on 2017/5/10.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextImageData : NSObject

@property (nonatomic, copy) NSString *name; 

@property (nonatomic, assign) NSInteger position;

// 此坐标是 CoreText 的坐标，而不是UIkit的坐标
@property (nonatomic, assign) CGRect imagePosition;
@end
