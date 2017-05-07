//
//  ViewController.m
//  CoreText1.0
//
//  Created by 叶俊有 on 2017/5/6.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "ViewController.h"
#import "DisplayView.h"
#import "YYFrameParser.h"
#import "YYCoreTextData.h"
#import "YYFrameParserConfig.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DisplayView *ctView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    YYFrameParserConfig *config = [[YYFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.ctView.width;
    
    YYCoreTextData *data = [YYFrameParser parseContent:@"华为的低成本研发优势华为获得巨大成功的主要竞争优势的是十分低廉的研发费用——即低成本的智力型人力资源。西门子公司董事会2004年的一份内部汇报认为，华为的低成本优势主要来自低廉的研发成本。" config:config];
    
    self.ctView.data = data;
    self.ctView.height = data.height;
    
}


@end
