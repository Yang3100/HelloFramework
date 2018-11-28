//
//  MyFrameworkManager.m
//  MyFramework
//
//  Created by 杨科军 on 2018/11/27.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "MyFrameworkManager.h"
#import "FrameworkFileViewController.h"

@implementation MyFrameworkManager

+ (UIViewController*)creatFrameworkFileViewController{
    FrameworkFileViewController *vc = [[FrameworkFileViewController alloc] initWithNibName:GetNibName(@"FrameworkFileViewController") bundle:[NSBundle mainBundle]];
    
    NSLog(@"subviews:%@",vc.view.subviews);
    return vc;
}

@end


