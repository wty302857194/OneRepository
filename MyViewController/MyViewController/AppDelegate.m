//
//  AppDelegate.m
//  MyViewController
//
//  Created by 杨飞 on 16/4/8.
//  Copyright (c) 2016年 cjh. All rights reserved.
//

#import "AppDelegate.h"
#import <Bugtags/Bugtags.h>
#import "UMessage.h"
@interface AppDelegate ()

@end

@implementation AppDelegate

- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary<NSKeyValueChangeKey,id> *)change context:(void *)context {
    [UIApplication sharedApplication].applicationIconBadgeNumber = [change[@"new"] integerValue];
}
- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    [Bugtags startWithAppKey:@"b9a7ddee7339191ecf6b01cf93d5a191" invocationEvent:BTGInvocationEventBubble];
    [Bugly startWithAppId:@"8e61e88a29"];
    self.window.backgroundColor = [UIColor whiteColor];
    application.applicationIconBadgeNumber = 0;
    
    
    
    [UMessage startWithAppkey:@"your appkey" launchOptions:launchOptions httpsenable:YES ];
    // Override point for customization after application launch.
//    _window=[[UIWindow alloc]initWithFrame:[UIScreen mainScreen].bounds];
//    
//    _window.backgroundColor =[UIColor colorWithRed:249/255.0 green:249/255.0 blue:249/255.0 alpha:1];
//    
//    //设置全局导航条风格和颜色
//    [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:23/255.0 green:180/255.0 blue:237/255.0 alpha:1]];
//    [[UINavigationBar appearance] setBarStyle:UIBarStyleBlack];
//    
//    ViewController *mainController=[[ViewController alloc]init];
//    _window.rootViewController=mainController;
//    
//    [_window makeKeyAndVisible];
    
    //如果已经获得发送通知的授权则创建本地通知，否则请求授权(注意：如果不请求授权在设置中是没有对应的通知设置项的，也就是说如果从来没有发送过请求，即使通过设置也打不开消息允许设置)
//    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
//        [self addLocalNotification];
//    }else{
//        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
//    }
    /**
     *  iOS8以后需要注册,才能将未读的数在图标右上角显示
     */
//    float kDeviceVersion = [[[UIDevice currentDevice] systemVersion] floatValue];
//    if (kDeviceVersion >= 8.0) {
//        // 使用本地通知 (本例中只是badge，但是还有alert和sound都属于通知类型,其实如果只进行未读数在appIcon显示,只需要badge就可, 这里全写上为了方便以后的使用)
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge | UIUserNotificationTypeSound | UIUserNotificationTypeAlert categories:nil];
//        // 进行注册
//        [application registerUserNotificationSettings:settings];
//    }
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    return YES;
}
-(void)application:(UIApplication *)application didReceiveLocalNotification:(UILocalNotification *)notification
{
    NSLog(@"noti===================:%@",notification);
    
    // 这里真实需要处理交互的地方
    // 获取通知所带的数据
//    NSString *notMess = [notification.userInfo objectForKey:@"key"];
//    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"本地通知(前台)"
//                                                    message:notMess
//                                                   delegate:nil
//                                          cancelButtonTitle:@"OK"
//                                          otherButtonTitles:nil];
//    [alert show];
//    
    float version = [[[UIDevice currentDevice] systemVersion] floatValue];
    
    if (version >= 8.0) {
        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeBadge categories:nil];
        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
    }
    // 更新显示的徽章个数
    NSInteger badge = application.applicationIconBadgeNumber;
    badge--;
    badge = badge >= 0 ? badge : 0;
    application.applicationIconBadgeNumber = badge;

    // 在不需要再推送时，可以取消推送
//    [HomeViewController cancelLocalNotificationWithKey:@"key"];
    
    if ([[notification.userInfo objectForKey:@"key"] isEqualToString:@"开始学习iOS开发了"]) {
        //判断应用程序当前的运行状态，如果是激活状态，则进行提醒，否则不提醒  (当用户打开程序时候收到远程通知后执行  )
        if (application.applicationState != UIApplicationStateActive) {
            UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"test" message:notification.alertBody delegate:nil cancelButtonTitle:@"关闭" otherButtonTitles:notification.alertAction, nil];
            [alert show];
        }
    }
}
//+ (void)cancelLocalNotificationWithKey:(NSString *)key {
//    // 获取所有本地通知数组
//    NSArray *localNotifications = [UIApplication sharedApplication].scheduledLocalNotifications;
//    
//    for (UILocalNotification *notification in localNotifications) {
//        NSDictionary *userInfo = notification.userInfo;
//        if (userInfo) {
//            // 根据设置通知参数时指定的key来获取通知参数
//            NSString *info = userInfo[key];
//            
//            // 如果找到需要取消的通知，则取消
//            if (info != nil) {
//                [[UIApplication sharedApplication] cancelLocalNotification:notification];
//                break;  
//            }  
//        }  
//    }  
//}
//#pragma mark 调用过用户注册通知方法之后执行（也就是调用完registerUserNotificationSettings:方法之后执行）
//-(void)application:(UIApplication *)application didRegisterUserNotificationSettings:(UIUserNotificationSettings *)notificationSettings{
//    if (notificationSettings.types!=UIUserNotificationTypeNone) {
////        [self addLocalNotification];
//    }
//}

#pragma mark 进入前台后设置消息信息
-(void)applicationWillEnterForeground:(UIApplication *)application{
//    [[UIApplication sharedApplication]setApplicationIconBadgeNumber:0];//进入前台取消应用消息图标
}

//#pragma mark - 私有方法
//#pragma mark 添加本地通知
//-(void)addLocalNotification{
//    
//    //定义本地通知对象
//    UILocalNotification *notification=[[UILocalNotification alloc]init];
//    //设置调用时间
//    notification.fireDate=[NSDate dateWithTimeIntervalSinceNow:10.0];//通知触发的时间，10s以后
//    notification.repeatInterval=2;//通知重复次数
//    //notification.repeatCalendar=[NSCalendar currentCalendar];//当前日历，使用前最好设置时区等信息以便能够自动同步时间k
//    
//    //设置通知属性
//    notification.alertBody=@"最近添加了诸多有趣的特性，是否立即体验？"; //通知主体
//    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
////    notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
//    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
//    
//    //设置用户信息
//    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
//    
//    //调用通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}

#pragma mark 移除本地通知，在不需要此通知时记得移除
-(void)removeNotification{
    [[UIApplication sharedApplication] cancelAllLocalNotifications];
}
- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

//- (void)applicationWillEnterForeground:(UIApplication *)application {
//    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
//}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
