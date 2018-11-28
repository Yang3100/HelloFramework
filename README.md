#### 简书地址
[简书地址](https://www.jianshu.com/p/2cdaab20ea72）

## 一、新建主项目
主项目的ProjectName是HelloFramework（也就是我们要使用SDK的主项目）

## 二、创建Framework
在主项目里创建Framework，暂时命名MyFramework
> Project - > Editor - > Add Larget - > Cocoa Touch Framework

![1.png](https://upload-images.jianshu.io/upload_images/1933747-afa55b321334c209.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 三、配置Framework信息
#### 1、Architectures 配置支持的指令集
> - Project - > Target - > MyFramework - > Build Settings
> - Architectures配置支持的指令集，增加一个armv7s

如下：
![2.png](https://upload-images.jianshu.io/upload_images/1933747-e14f560a16b60590.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

备注：系统已经默认配置了 arm64、armv7、arm64e

指令集|支持设备设备
:----:|:----
armv6 |iPhone、iPhone 3G、iPod 1G、iPod 2G
armv7 |iPhone 3GS、iPhone 4、iPod 3G、iPod 4G、iPod 5G、iPad、iPad 2、iPad 3、iPad Mini
armv7s|iPhone 5、iPhone 5C、iPad 4
arm64 |iPhone 5s、iPhone 6、iPhone 6P、 iPhone 6s、 iPhone 6sP、 iPhone 7、iPhone 7P、iPad Air、Retina iPad Mini
arm64e|iPhone XR、iPhone XS Max

#### 2、Build Active Architecture Only修改为NO，否则生成的静态库就只支持当前选择设备的架构。
Build Active Architecture Only修改为NO

#### 3、Mach-O Type 选择是Static Library(静态库)还是Dynamic Library(动态库默认)
> 备注：使用动态库要注意:需要在Linked Frameworks and Libraries和Embedded Binaries都加入对应的动态库.

如下：
![3.png](https://upload-images.jianshu.io/upload_images/1933747-4ad5f4cf8093ae63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 5、选中Target，选择Build Phases - Headers，可以看出有三个选项，分别是Public、Private、Project，把需要公开给别人的 .h 文件拖到 Public 中，把不想公开的，即为隐藏的 .h 文件拖到Project中。
Project里面会显示你MyFramework里面的所有你创建的h文件
将你要暴露出去的h文件，拖拽到上面的public当中如下：
![5.png](https://upload-images.jianshu.io/upload_images/1933747-dc6b339d356b31e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 6、设置最低兼容版本
如下：
![4.png](https://upload-images.jianshu.io/upload_images/1933747-71f961f5936991a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 7、新建一个FrameworkManager文件
在FrameworkManager类里实现了一个方法

```
//.h文件声明
#import <Foundation/Foundation.h>

@interface MyFrameworkManager : NSObject

+ (UIViewController*)creatFrameworkFileViewController;

@end
```

```
//.m文件实现
#import "MyFrameworkManager.h"
#import "FrameworkFileViewController.h"

@implementation MyFrameworkManager

+ (UIViewController*)creatFrameworkFileViewController{
    FrameworkFileViewController *vc = [[FrameworkFileViewController alloc] initWithNibName:GetNibName(@"FrameworkFileViewController") bundle:[NSBundle mainBundle]];
    
    NSLog(@"subviews:%@",vc.view.subviews);
    return vc;
}
@end
```

#### 8、引入头文件
默认生成的.h文件中，我的是MyFramework.h，把所有需要暴露的.h文件都用#import 引入，记住一定要将所有需要暴露的.h文件都引入，也就是上面Headers-Public中加的所有.h文件，不然编译后生成的.framework在引用的时候会有警告。
如下：
![4.png](https://upload-images.jianshu.io/upload_images/1933747-66f291a2235784b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 9、回到主项目，引用MyFrameworkManager
```
/// 引入头文件
#import <MyFramework/MyFramework.h>

// 主项目当中
UIViewController *vc = [MyFrameworkManager creatFrameworkFileViewController];
```

#### 10、生成Framework包
打包framework：分为真机和模拟器，这两个生成的framework是不一样的。这里只进行生成真机framework，个人感觉生成模拟器的.framework并没什么卵用。（如果说你需要生成一个既可以真机使用又可以模拟器使用的，那就分别生成，最后在合并在一起）。按照下图将编译的 Device 选择为真机 ，然后按下 Command + B 开始编译，编译成功后右键 Products 文件夹下的 .framework 文件，点击 Show in Finder。

> 重点：我这时我编译会报错，把Build Active Architecture Only修改为YES，编译就会成功，这时再切换为NO编译，还是会成功。经过总结Build Active Architecture Only为YES或者NO，导出framework后都正常使用，亲测！

## 四、xib文件和图片的存放和引用
#### 创建bundle，放置资源文件（nib文件，图片）
###### 1、新建一个bundle文件，这里暂时命名为KJFramework.bundle
如下：
![6.png](https://upload-images.jianshu.io/upload_images/1933747-dfe5f56c729948af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、显示包内容，将图片等资源放入bundle文件当中
如下：
![7.png](https://upload-images.jianshu.io/upload_images/1933747-6e2ab4a24d5f6fcf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 第一种编译成nib文件
###### 1、将xib文件编译成nib文件，放入bundle当中
![8.png](https://upload-images.jianshu.io/upload_images/1933747-439ff321568a73d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 打开终端：cd 需要转换的xib目录
- 输入编译：ibtool --errors --warnings --output-format human-readable-text --compile ibtool --errors --warnings --output-format human-readable-text --compile FrameworkFileViewController.nib FrameworkFileViewController.xib

编译完成会生成如下文件：
![9.png](https://upload-images.jianshu.io/upload_images/1933747-dc709d0b3c1bf7f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 第二种生成nib文件
###### 1、编译文件，Command + B 生成Framework文件
![5.png](https://upload-images.jianshu.io/upload_images/1933747-d33c2ce1af6843b1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 2、Show in Finder Framework文件，从中找到一个FrameworkFileViewController.nib文件，将该文件放置Bundle文件当中

> 备注：一旦xib文件发生变化，就需要重新编译nib文件，然后替换

#### 3、读取bundle资源包中的图片
把Bundle文件导入到我们的framework中，我们用到图片的时候，就取Bundle中的图片来用。

```
//FrameworkFileViewController.m文件实现
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
```

## 五、Framework 的导出与文档
#### 1、切换到 Release 模式
Product -> Edit Scheme -> Build Configuration
![6.png](https://upload-images.jianshu.io/upload_images/1933747-12bbe8fedb3018ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、导出 Framework
###### （1）在 Target 为 MyFramework 下，选择模拟器和Generic iOS Device各自 Command + B 一次
######（2）在工程目录 Products 下 -> 右击 Framework -> Show in Finder，会看到有两个文件夹，一个是真机包，一个是模拟器包。
真机包：Release-iphoneos
模拟机包：Release-iphonesimulator

查看包所支持框架：lipo -info 路径/MyFramework.framework/MyFramework
![1.png](https://upload-images.jianshu.io/upload_images/1933747-5d45e45bef91abe9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> armv7 arm64 armv7s 说明是真机，i386 x86_64 说明是模拟机

###### （3）将合成的MyFramework 包替换其中的一个，然后这个 MyFramework.framework就是我们需要
合并：lipo -create 真机路径/MyFramework.framework/MyFramework 模拟器路径/MyFramework.framework/MyFramework -output 真机路径/MyFramework.framework/MyFramework

再次查看包支持框架：二者均在，说明合并成功
![2.png](https://upload-images.jianshu.io/upload_images/1933747-7d9e09bbdb4cc448.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


## 六、Bug总结
##### 1、error: Invalid bitcode signature
clang: error: linker command failed with exit code 1 (use -v to see invocation)
![1.png](https://upload-images.jianshu.io/upload_images/1933747-68808db96dd3ce3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 原因：Deployment Target 版本低于Framework要求的最低版本
- 解决方案：修改Deployment Target 版本

#### 2、Could not load NIB in bundle
![2.png](https://upload-images.jianshu.io/upload_images/1933747-b441204f130f61f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
- 原因：加载nib时候未找到文件
- 解决方案：
Targets -> Build Phases -> Compile Sources、Link Binary With Libraries、Copy Bundle Resources 三处都加上引入的Framework文件
![3.png](https://upload-images.jianshu.io/upload_images/1933747-36e0fff1c5cc1683.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)
#### 3、ld: symbol(s) not found for architecture x86_64
- 原因：Framework文件框架当中缺少arm64
- 解决方案：现在合成Framework文件时，arm64已经系统默认。本人出现原因是因为，我只合成了真机的Framework文件，所以在模拟机跑的时候报缺少框架，但是在真机上可以正常运行。
- 生成模拟机Framework文件，然后将两个文件合成。