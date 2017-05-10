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
#import "DisplayTextView.h"
#import "DisplayTextField.h"

@interface ViewController ()
@property (weak, nonatomic) IBOutlet DisplayView *ctView;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    CGFloat width = [UIScreen mainScreen].bounds.size.width - 20 * 2;
    CGFloat height = [UIScreen mainScreen].bounds.size.height - 40 * 2;
    self.ctView.width = width;
    
    YYFrameParserConfig *config = [[YYFrameParserConfig alloc] init];
    config.width = self.ctView.width;
    
    NSString *path = [[NSBundle mainBundle] pathForResource:@"content" ofType:@"json"];
    YYCoreTextData *data = [YYFrameParser parseTemplateFile:path config:config];
    
    self.ctView.data = data;
    self.ctView.height = data.height;
    
    CGFloat scrollViewH = data.height > height ? height : data.height;
    self.scrollView.frame = CGRectMake(20, 40, width, scrollViewH);
    self.ctView.frame = CGRectMake(0, 0, self.scrollView.width, data.height);
    self.scrollView.contentSize = CGSizeMake(0, data.height);
}

- (void)parseContentByCode
{
    YYFrameParserConfig *config = [[YYFrameParserConfig alloc] init];
    config.textColor = [UIColor redColor];
    config.width = self.ctView.width;
    
    YYCoreTextData *data = [YYFrameParser parseContent:@"华为的低成本研发优势华为获得巨大成功的主要竞争优势的是十分低廉的研发费用——即低成本的智力型人力资源。西门子公司董事会2004年的一份内部汇报认为，华为的低成本优势主要来自低廉的研发成本。" config:config];
    
    self.ctView.data = data;
    self.ctView.height = data.height;
}

@end
