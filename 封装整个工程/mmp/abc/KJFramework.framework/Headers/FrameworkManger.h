//
//  FrameworkManger.h
//  Enlightenment
//
//  Created by 杨科军 on 2018/11/28.
//  Copyright © 2018 杨科军. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface FrameworkManger : NSObject

/// 初始化方法
+ (UIViewController*)createFrameworkFileViewController:(void(^)(FrameworkManger *obj))block;

//5. 设置手势启动
+ (void)setThouchID;

@property(nonatomic,strong,readonly) FrameworkManger *(^AppName)(NSString*); // 
@property(nonatomic,strong,readonly) FrameworkManger *(^AppID)(NSString*);   //
@property(nonatomic,strong,readonly) FrameworkManger *(^AppIcon)(UIImage*);  //
@property(nonatomic,strong,readonly) FrameworkManger *(^AppMainColor)(UIColor*);// 主色调
@property(nonatomic,strong,readonly) FrameworkManger *(^AppBundlePath)(NSString*);// 资源文件路径


@end

