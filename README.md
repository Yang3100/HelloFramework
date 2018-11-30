#### 简书地址
[简书地址](https://www.jianshu.com/p/2cdaab20ea72）

## 一、新建主项目
主项目的ProjectName是HelloFramework（ SDK的主项目 ）

## 二、创建Framework
在主项目里创建Framework，暂时命名MyFramework
> Project - > Editor - > Add Larget - > Cocoa Touch Framework

![1.png](https://upload-images.jianshu.io/upload_images/1933747-afa55b321334c209.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

## 三、配置Framework信息
#### 1、Architectures 配置支持的指令集
> - Project - > Target - > MyFramework - > Build Settings
> - Architectures配置支持的指令集，增加arm64e、armv7s

如下：

![2.png](https://upload-images.jianshu.io/upload_images/1933747-e14f560a16b60590.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

备注：系统已经默认配置了 arm64、armv7

指令集|支持设备设备
:----:|:----
armv6 |iPhone、iPhone 3G、iPod 1G、iPod 2G
armv7 |iPhone 3GS、iPhone 4、iPod 3G、iPod 4G、iPod 5G、iPad、iPad 2、iPad 3、iPad Mini
armv7s|iPhone 5、iPhone 5C、iPad 4
arm64 |iPhone 5s、iPhone 6、iPhone 6P、 iPhone 6s、 iPhone 6sP、 iPhone 7、iPhone 7P、iPad Air、Retina iPad Mini
arm64e|iPhone XR、iPhone XS Max

#### 2、Build Active Architecture Only修改为NO，否则生成的静态库就只支持当前选择设备的架构。
Build Active Architecture Only 修改为 NO

#### 3、Mach-O Type 选择是Static Library(静态库)还是Dynamic Library(动态库默认)
Mach-O Type 设置为 Static Library（静态库）
> 备注：使用动态库要注意需要在 Linked Frameworks and Libraries 和 Embedded Binaries 都加入对应的动态库。

如下：

![3.png](https://upload-images.jianshu.io/upload_images/1933747-4ad5f4cf8093ae63.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 4、设置Headers Phase
> 步骤：Target - > MyFramework - > Build Phases - > Headers 

- Public：需要暴露出来的 h 文件
- Private：不想公开的 h 文件
- Project：显示你MyFramework里面的所有你创建的 h 文件

![5.png](https://upload-images.jianshu.io/upload_images/1933747-dc6b339d356b31e0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 5、设置最低兼容版本
如下：

![4.png](https://upload-images.jianshu.io/upload_images/1933747-71f961f5936991a8.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 6、新建一个FrameworkManager文件
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

#### 7、引入头文件
默认生成的.h文件中，我的是MyFramework.h，把所有需要暴露的.h文件都用#import 引入，记住一定要将所有需要暴露的.h文件都引入，也就是上面Headers-Public中加的所有.h文件，不然编译后生成的.framework在引用的时候会有警告。
如下：

![4.png](https://upload-images.jianshu.io/upload_images/1933747-66f291a2235784b2.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 8、回到主项目，引用MyFrameworkManager
```
/// 引入头文件
#import <MyFramework/MyFramework.h>

// 主项目当中
UIViewController *vc = [MyFrameworkManager creatFrameworkFileViewController];
```

#### 9、生成Framework包
打包Framework：分为真机和模拟器，这两个生成的framework是不一样的。（如果说你需要生成一个既可以真机使用又可以模拟器使用的，那就分别生成，最后在合并在一起）。按照下图将编译的 Device 选择为真机 ，然后按下 Command + B 开始编译，编译成功后右键 Products 文件夹下的 .framework 文件，点击 Show in Finder。

## 四、xib文件和图片的存放和引用
### 友情提示：资源文件都放在Bundle文件当中，如果放在Framework文件当中，后面打包上传的时候会出现`Found an unexpected Mach-O header code: 0x72613c21`

#### 创建bundle，放置资源文件（nib文件，图片）
###### 1、新建一个bundle文件，这里暂时命名为KJFramework.bundle
如下：

![6.png](https://upload-images.jianshu.io/upload_images/1933747-dfe5f56c729948af.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、显示包内容，将图片等资源放入bundle文件当中
如下：

![7.png](https://upload-images.jianshu.io/upload_images/1933747-6e2ab4a24d5f6fcf.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 第一种编译成nib文件
###### 1、将xib文件编译成nib文件

![8.png](https://upload-images.jianshu.io/upload_images/1933747-439ff321568a73d7.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 打开终端：cd 需要转换的xib目录
- 输入编译：ibtool --errors --warnings --output-format human-readable-text --compile ibtool --errors --warnings --output-format human-readable-text --compile FrameworkFileViewController.nib FrameworkFileViewController.xib

编译完成会生成如下文件：

![9.png](https://upload-images.jianshu.io/upload_images/1933747-dc709d0b3c1bf7f0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 第二种生成nib文件
###### 1、编译文件，Command + B 生成Framework文件

![5.png](https://upload-images.jianshu.io/upload_images/1933747-d33c2ce1af6843b1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

###### 2、Show in Finder Framework文件，从中找到一个FrameworkFileViewController.nib文件

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
## 五、引入第三方库
#### 1、pod时候选择Framework文件
![3.png](https://upload-images.jianshu.io/upload_images/1933747-14db5c235307ee70.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、使用Framework文件的时候，同样需要引入所需的第三方库

## 六、Framework 的导出与文档
#### 1、切换到 Release 模式
Product --> Edit Scheme --> Build Configuration

![6.png](https://upload-images.jianshu.io/upload_images/1933747-12bbe8fedb3018ca.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 2、导出 Framework
###### （1）在 Target 为 MyFramework 下，选择模拟器和Generic iOS Device各自 Command + B 一次
######（2）在工程目录 Products 下 -> 右击 Framework -> Show in Finder，会看到有两个文件夹，一个是真机包，一个是模拟器包。
- 真机包：Release-iphoneos
- 模拟机包：Release-iphonesimulator

查看包所支持框架：lipo -info 路径/MyFramework.framework/MyFramework

![1.png](https://upload-images.jianshu.io/upload_images/1933747-5d45e45bef91abe9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

> armv7 arm64 armv7s arm64e 说明是真机
> 
> i386 x86_64 说明是模拟机

###### （3）将合成的MyFramework 包替换其中的一个，然后这个 MyFramework.framework就是我们需要
合并：lipo -create 真机路径/MyFramework.framework/MyFramework 模拟器路径/MyFramework.framework/MyFramework -output 真机路径/MyFramework.framework/MyFramework

再次查看包支持框架：二者均在，说明合并成功

![2.png](https://upload-images.jianshu.io/upload_images/1933747-7d9e09bbdb4cc448.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


### 友情提示：实践证明弄模拟机的i386、x86_64没有什么用处，而且后面上传时候还会报错，让你剔除这两框架。

## 七、Bug总结
##### 1、error: Invalid bitcode signature
clang: error: linker command failed with exit code 1 (use -v to see invocation)

![1.png](https://upload-images.jianshu.io/upload_images/1933747-68808db96dd3ce3e.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：Deployment Target 版本低于Framework要求的最低版本
- 解决方案：修改 Deployment Target 版本

#### 2、Could not load NIB in bundle
![2.png](https://upload-images.jianshu.io/upload_images/1933747-b441204f130f61f5.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：加载NIB时候未找到文件
- 解决方案：
Targets -> Build Phases -> Link Binary With Libraries、Copy Bundle Resources 处都加上引入的Framework文件

![1.png](https://upload-images.jianshu.io/upload_images/1933747-38ee68624134a18a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 3、ld: symbol(s) not found for architecture x86_64
- 原因：Framework文件框架当中缺少x86_64，也就是模拟机框架
- 解决方案：本人出现原因是因为，我只合成了真机的Framework文件，所以在模拟机跑的时候报缺少框架，但是在真机上可以正常运行。
- 生成模拟机Framework文件和真机Framework文件，然后将两个文件合成。

#### 4、ld: symbol(s) not found for architecture x86_64
clang: error: linker command failed with exit code 1 (use -v to see invocation)
![2.png](https://upload-images.jianshu.io/upload_images/1933747-75da2c17d318f809.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：未引入所需的三方库
- 解决方案：pod 需要的三方库
从图可以看出缺少 MJRefresh 和 CHTCollectionViewWaterfallLayout

#### 5、All object files and libraries for bitcode must be generated from Xcode Archive or Install build for architecture armv7
工程中引入的第三方静态库真机调试没有问题，打包的时候报错
![1.png](https://upload-images.jianshu.io/upload_images/1933747-d40e8aebcb9f4fd0.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：第三方库不兼容 XCode7later 之后默认开启 BitCode
- 解决方案：
- 第一种：更新Framework文件使包含 Bitcode（armv7）。
- 第二种：选择工程，在 Build Settings 中，把 ENABLE_BITCODE 设置为NO
![2.png](https://upload-images.jianshu.io/upload_images/1933747-cbcd25debba70af1.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

#### 6、Found an unexpected Mach-O header code: 0x72613c21
打好包之后上传时候出现错误！！！

- 第一种原因：Framework是一个Static Library，我把他添加在Embedded Binaries里面了。

---
- 解决方案：
- 第一种：从 Embedded Binaries（动态库里来文件）中删除静态Framework文件（KJFramework.framework）但是你直接删除会发现下面 Linked Frameworks and Libraries（签署了框架和库）中 Framework 文件也没了。这是需要重新往 Linked Frameworks and Libraries 里添加刚刚被删除的Framework文件。

- 第二种：重新将Framework文件封装成Dynamic Library（动态库），使用动态库要注意需要在 Linked Frameworks and Libraries 和 Embedded Binaries 都加入对应的动态库。

---
- 第二种原因：把Framework文件添加到了 Copy Bundle Resources当中
- 解决方案：从 Copy Bundle Resources 中将Framework文件删除，这是你可能会出现，加载不出来你封装在Framework文件当中的资源文件，因此你需要把资源文件单独提炼出来用 Bundle 来装。

#### 7、dyld: Library not loaded: @rpath/KJFramework.framework/KJFramework
![4.png](https://upload-images.jianshu.io/upload_images/1933747-757d7a11688e876a.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：
- 解决方案：此处加上Framework文件即可
![2.png](https://upload-images.jianshu.io/upload_images/1933747-4d185e35391c37c9.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)


#### 8、"Unsupported Architectures. The executable for yht.temp_caseinsensitive_rename.app/Frameworks/VideoCore.framework contains unsupported architectures '[x86_64, i386]'."  
![55.png](https://upload-images.jianshu.io/upload_images/1933747-43fef033a32d06a3.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

- 原因：说明自建的这个SDK里面包含了x86_64、i386 架构，当然这个AppStore是不允许的
- 解决方案：剔除掉x86_64, i386这两个架构
- TARGETS -> Build Phases -> 点击加号选择 New Run Script Phase -> 然后复制粘贴下面代码
![6.png](https://upload-images.jianshu.io/upload_images/1933747-7394734e0c73585b.png?imageMogr2/auto-orient/strip%7CimageView2/2/w/1240)

```
    APP_PATH="${TARGET_BUILD_DIR}/${WRAPPER_NAME}"  
      
    # This script loops through the frameworks embedded in the application and  
    # removes unused architectures.  
    find "$APP_PATH" -name '*.framework' -type d | while read -r FRAMEWORK  
    do  
    FRAMEWORK_EXECUTABLE_NAME=$(defaults read "$FRAMEWORK/Info.plist" CFBundleExecutable)  
    FRAMEWORK_EXECUTABLE_PATH="$FRAMEWORK/$FRAMEWORK_EXECUTABLE_NAME"  
    echo "Executable is $FRAMEWORK_EXECUTABLE_PATH"  
      
    EXTRACTED_ARCHS=()  
      
    for ARCH in $ARCHS  
    do  
    echo "Extracting $ARCH from $FRAMEWORK_EXECUTABLE_NAME"  
    lipo -extract "$ARCH" "$FRAMEWORK_EXECUTABLE_PATH" -o "$FRAMEWORK_EXECUTABLE_PATH-$ARCH"  
    EXTRACTED_ARCHS+=("$FRAMEWORK_EXECUTABLE_PATH-$ARCH")  
    done  
      
    echo "Merging extracted architectures: ${ARCHS}"  
    lipo -o "$FRAMEWORK_EXECUTABLE_PATH-merged" -create "${EXTRACTED_ARCHS[@]}"  
    rm "${EXTRACTED_ARCHS[@]}"  
      
    echo "Replacing original executable with thinned version"  
    rm "$FRAMEWORK_EXECUTABLE_PATH"  
    mv "$FRAMEWORK_EXECUTABLE_PATH-merged" "$FRAMEWORK_EXECUTABLE_PATH"  
      
    done  
```