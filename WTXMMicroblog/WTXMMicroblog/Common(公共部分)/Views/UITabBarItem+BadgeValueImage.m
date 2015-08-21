//
//  UITabBarItem+BadgeValueImage.m
//  WeiBo17
//
//  Created by teacher on 15/8/20.
//  Copyright (c) 2015年 itcast. All rights reserved.
//

#import "UITabBarItem+BadgeValueImage.h"
#import <objc/runtime.h>

@implementation UITabBarItem (BadgeValueImage)



//想要实现的功能就是系统方法调用之后做我们自己的逻辑

//用自己的方法去把系统的方法去替换了,然后自己的方法调用一下原先的系统的方法,再跟上自己的逻辑

+ (void)load{
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        Class class = [self class];
        
        //获取到原来的方法与需要交互的SEL
        SEL originalSelector = @selector(setBadgeValue:);
        SEL swizzledSelector = @selector(WTXM_setBadgeValue:);
        
        //通过SEL获取到当前类身上的Method
        Method originalMethod = class_getInstanceMethod(class, originalSelector);
        Method swizzledMethod = class_getInstanceMethod(class, swizzledSelector);
        
        //先向类身上添加方法
        BOOL result = class_addMethod(class, originalSelector, method_getImplementation(swizzledMethod), method_getTypeEncoding(swizzledMethod));
        
        if (result) {
            //如果添加成功就替换方法实现
            class_replaceMethod(class, swizzledSelector, method_getImplementation(originalMethod), method_getTypeEncoding(originalMethod));
            
        }else{
            //没有添加成功,直接交换方法实现
            method_exchangeImplementations(originalMethod, swizzledMethod);
        }
    });
}


//自已的方法
- (void)WTXM_setBadgeValue:(NSString *)badgeValue{
    
    //在儿调用原有的方法的话,就必须要调用交换之后的方法,否则,会递归
//    [self setBadgeValue:badgeValue];
    
    //调用原先的
    [self WTXM_setBadgeValue:badgeValue];
    
    //如果badgeView为nil话
    if (!badgeValue) {
        return;
    }
    
    //我们直接能够拿到的就是IWTabBar
    
    UITabBarController *target = [self valueForKeyPath:@"_target"];
    //    NSLog(@"%@",target);
    
    for (UIView *tabBarChild in target.tabBar.subviews) {
        //找UITabBarButton
        if ([tabBarChild isKindOfClass:NSClassFromString(@"UITabBarButton")]) {
            for (UIView *tabBarButtonChild in tabBarChild.subviews) {
                if ([tabBarButtonChild isKindOfClass:NSClassFromString(@"_UIBadgeView")]) {
                    for (UIView *badgeViewChild in tabBarButtonChild.subviews) {
                        if ([badgeViewChild isKindOfClass:NSClassFromString(@"_UIBadgeBackground")]) {
//                            NSLog(@"终于找到你,还好没放弃");
                            unsigned int count;//获取完成之后,count的值就代码当前类身上成员变量的个数
                            
                            //获取类身上的成员变量
                            Ivar *vars = class_copyIvarList(NSClassFromString(@"_UIBadgeBackground"), &count);
                            //遍历查看
                            for (int i=0; i<count; i++) {
                                Ivar var = vars[i];
                                
                                //获取var的名字
                                NSString *name = [NSString stringWithCString:ivar_getName(var) encoding:NSUTF8StringEncoding];
                                //获取类型
//                                NSString *type = [NSString stringWithCString:ivar_getTypeEncoding(var) encoding:NSUTF8StringEncoding];
//                                
//                                NSLog(@"%@=====%@",name,type);
                                //
                                if ([name isEqualToString:@"_image"]) {
                                    //通过kvc赋值
                                    [badgeViewChild setValue:[UIImage imageNamed:self.badgeImageName] forKeyPath:name];
                                }
                            }
                            //释放内存
                            free(vars);
                        }
                    }
                }
            }
        }
    }

}
- (void)setBadgeImageName:(NSString *)badgeImageName {
    objc_setAssociatedObject(self, @"haha", badgeImageName, OBJC_ASSOCIATION_COPY_NONATOMIC);
}



- (NSString *)badgeImageName{
    return objc_getAssociatedObject(self, @"haha");
}



@end
