//
//  FrameworkFileViewController.m
//  MyFramework
//
//  Created by 杨科军 on 2018/11/27.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "FrameworkFileViewController.h"

@interface FrameworkFileViewController ()

@property (unsafe_unretained, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FrameworkFileViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.imageView.image = [UIImage imageNamed:GetBundleImage(@"tiaotiaosu")];
}

- (IBAction)changeImage:(UIButton *)sender {
    if (_imageView.highlighted) {
        self.imageView.image = [UIImage imageNamed:GetBundleImage(@"jienigui")];
    }else{
        self.imageView.highlightedImage = [UIImage imageNamed:GetBundleImage(@"kabisou")];
    }
    self.imageView.highlighted = !self.imageView.highlighted;
}

- (IBAction)dismiss:(UIButton *)sender {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
