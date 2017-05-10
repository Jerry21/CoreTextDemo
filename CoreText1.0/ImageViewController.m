//
//  ImageViewController.m
//  CoreText1.0
//
//  Created by yejunyou on 2017/5/10.
//  Copyright © 2017年 yejunyou. All rights reserved.
//

#import "ImageViewController.h"

@interface ImageViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;
@end

@implementation ImageViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = self.image;
}


- (IBAction)Back:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}


@end
