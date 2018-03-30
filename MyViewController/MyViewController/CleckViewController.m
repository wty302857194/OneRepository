//
//  CleckViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/4/14.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "CleckViewController.h"

@interface CleckViewController ()

@end

@implementation CleckViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
//    [formatter setDateFormat:@"HH:mm:ss"];
//    //触发通知的时间
//    NSDate *now=[formatter dateFromString:@"17:31:00"];
// 
//    notification.fireDate= now;
//    //时区
//    notification.timeZone=[NSTimeZone defaultTimeZone];
//    //通知重复提示的单位，可以是天、周、月
//
//    notification.repeatInterval=10;
//    //知内容
//    notification.alertBody=@"这是一个新的通知";
//    //通知被触发时播放的声音
//
//    notification.soundName=UILocalNotificationDefaultSoundName;
//    //执行通知注册
//    NSDictionary *dic = [NSDictionary dictionaryWithObject:@"name" forKey:@"key"];
//    notification.userInfo = dic;
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//    [self registerLocalNotification:111];
    
    if ([[UIApplication sharedApplication]currentUserNotificationSettings].types!=UIUserNotificationTypeNone) {
        [self registerLocalNotification:11];
    }else{
        [[UIApplication sharedApplication]registerUserNotificationSettings:[UIUserNotificationSettings settingsForTypes:UIUserNotificationTypeAlert|UIUserNotificationTypeBadge|UIUserNotificationTypeSound  categories:nil]];
    }
}
// 设置本地通知
- (void)registerLocalNotification:(NSInteger)alertTime {
//    UILocalNotification *notification = [[UILocalNotification alloc] init];
//    // 设置触发通知的时间
//    NSDate *fireDate = [NSDate dateWithTimeIntervalSinceNow:alertTime];
//    NSLog(@"fireDate=%@",fireDate);
    UILocalNotification *notification = [[UILocalNotification alloc] init];

    NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
    [formatter setDateFormat:@"HH:mm:ss"];
    //触发通知的时间
    NSDate *fireDate=[formatter dateFromString:@"11:53:00"];
    notification.fireDate = fireDate;
    
//     notification.fireDate = [NSDate dateWithTimeIntervalSinceNow:10];
    // 时区
    notification.timeZone = [NSTimeZone defaultTimeZone];
    // 设置重复的间隔
//    notification.repeatInterval = NSCalendarUnitMinute;//kCFCalendarUnitSecond;
    
    // 通知内容
    notification.alertBody =  @"该起床了...";
//    notification.alertAction = @"打开";
    notification.applicationIconBadgeNumber = 1;
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
    // 通知被触发时播放的声音
    notification.soundName = UILocalNotificationDefaultSoundName;
    // 通知参数
    NSDictionary *userDict = [NSDictionary dictionaryWithObject:@"开始学习iOS开发了" forKey:@"key"];
    notification.userInfo = userDict;
    
    // ios8后，需要添加这个注册，才能得到授权
//    if ([[UIApplication sharedApplication] respondsToSelector:@selector(registerUserNotificationSettings:)]) {
//        UIUserNotificationType type =  UIUserNotificationTypeAlert | UIUserNotificationTypeBadge | UIUserNotificationTypeSound;
//        UIUserNotificationSettings *settings = [UIUserNotificationSettings settingsForTypes:type
//                                                                                 categories:nil];
//        [[UIApplication sharedApplication] registerUserNotificationSettings:settings];
//        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = 10;//NSCalendarUnitDay;
//    } else {
//        // 通知重复提示的单位，可以是天、周、月
//        notification.repeatInterval = 10;//NSDayCalendarUnit;
//    }
    
    // 执行通知注册
    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
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
//    notification.alertBody=@"该起床了..."; //通知主体
//    notification.applicationIconBadgeNumber=1;//应用程序图标右上角显示的消息数
//    notification.alertAction=@"打开应用"; //待机界面的滑动动作提示
//    notification.alertLaunchImage=@"Default";//通过点击通知打开应用时的启动图片,这里使用程序启动图片
//        notification.soundName=UILocalNotificationDefaultSoundName;//收到通知时播放的声音，默认消息声音
////    notification.soundName=@"msg.caf";//通知声音（需要真机才能听到声音）
//    
//    //设置用户信息
//    notification.userInfo=@{@"id":@1,@"user":@"Kenshin Cui"};//绑定到通知上的其他附加信息
//    
//    //调用通知
//    [[UIApplication sharedApplication] scheduleLocalNotification:notification];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
