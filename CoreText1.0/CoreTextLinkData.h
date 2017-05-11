//
//  CoreTextLinkData.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/11.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CoreTextLinkData : NSObject
@property (nonatomic, copy) NSString *title;
@property (nonatomic, copy) NSString *url;
@property (nonatomic, assign) NSRange range; 
@end
