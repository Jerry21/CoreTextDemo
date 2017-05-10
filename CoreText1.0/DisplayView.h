//
//  DisplayView.h
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/6.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YYCoreTextData.h"

extern NSString *const YYDisplayerViewPressedNotificatioin;

@interface DisplayView : UIView
@property (nonatomic, strong) YYCoreTextData *data; 
@end

