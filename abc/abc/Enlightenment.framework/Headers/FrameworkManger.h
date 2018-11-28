//
//  FrameworkManger.h
//  Enlightenment
//
//  Created by 杨科军 on 2018/11/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrameworkManger : NSObject

//1. 判断是否第一次登录
+ (void)fristLoad;
//2. 传递App名字
+ (void)getAppName:(NSString*)name;
//3. 传递Appid
+ (void)getAppID:(NSString*)appID;
//4. 传递AppIcon
+ (void)getAppIcon:(UIImage*)image;
//5. 设置手势启动
+ (void)setThouchID;
//6. 获取底层控制器
+ (UIViewController*)creatFrameworkFileViewController;

@end

