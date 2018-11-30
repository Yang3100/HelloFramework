//
//  AppDelegate.m
//  abc
//
//  Created by 杨科军 on 2018/11/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import "AppDelegate.h"
#import <KJFramework/KJFramework.h>

#define UIColorFromHEXA(hex,a) [UIColor colorWithRed:((hex&0xFF0000)>>16)/255.0f green:((hex&0xFF00)>>8)/255.0f blue:(hex&0xFF)/255.0f alpha:a]

@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc]initWithFrame:[[UIScreen mainScreen] bounds]];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    /// 在Appdelegate里面，设置全局的Tabbar样式
    [[UITabBar appearance] setTranslucent:NO];
    
    UIViewController *vc = [FrameworkManger createFrameworkFileViewController:^(FrameworkManger *obj) {
        obj.AppName(@"启蒙儿童画").AppID(@"1445008425").AppIcon([UIImage imageNamed:@"LOGOstore_1024pt"]).AppMainColor(UIColorFromHEXA(0x91D1E9,1.0)).AppBundlePath(@"Resource.bundle");
    }];
    
    [FrameworkManger setThouchID];
    
    self.window.rootViewController = vc;
    
    return YES;
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // 解锁屏幕即调用
    // 指纹解锁
    [FrameworkManger setThouchID];
}

@end
