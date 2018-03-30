//
//  CalendarViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/7/21.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "CalendarViewController.h"
#import <EventKit/EventKit.h>
@interface CalendarViewController ()
@property (nonatomic , retain) EKEventStore *store;
@end

@implementation CalendarViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [_img_view addSubview:[self effectViewWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, SCREENH_HEIGHT)]];
    EKEventStore *eventStore = [[EKEventStore alloc] init];
    self.store = eventStore;
    
}
- (UIVisualEffectView *)effectViewWithFrame:(CGRect)frame//毛玻璃效果
{
    UIBlurEffect *effect = [UIBlurEffect effectWithStyle:UIBlurEffectStyleLight];
    UIVisualEffectView *effectView = [[UIVisualEffectView alloc] initWithEffect:effect];
    effectView.frame = frame;
    return effectView;
}
- (IBAction)btnPress:(UIButton *)sender {
    if (!sender.isSelected) {
        [self saveEvent:nil];
        
    }else {
        NSMutableDictionary *dic = [self readOrderCodeArray];
        
        [self deleteEvent:[self.store eventWithIdentifier:dic[@"自己定义的一个key（大多是这个商品的id）"]]];
    }
    sender.selected = !sender.selected;
}
- (void)saveEvent:(id)sender {
    
    
    
    //事件市场
    
    //6.0及以上通过下面方式写入事件
        // the selector is available, so we must be on iOS 6 or newer
        [self.store requestAccessToEntityType:EKEntityTypeEvent completion:^(BOOL granted, NSError *error) {
            dispatch_async(dispatch_get_main_queue(), ^{
                if (error)
                {
                    //错误细心
                    // display error message here
                }
                else if (!granted)
                {
                    //被用户拒绝，不允许访问日历
                    // display access denied error message here
                    [self tanKuang:@"系统提醒功能未开启，无法成功提醒到你，去开启吧~"];
                }
                else
                {
                    // access granted
                    // ***** do the important stuff here *****
                    
                    //事件保存到日历
                    
                    
                    //创建事件
                    EKEvent *event  = [EKEvent eventWithEventStore:self.store];
                    
                    event.title     = @"哈哈哈，我是日历事件啊";
                    event.location = @"我在杭州西湖区留和路";
                    
                    NSDateFormatter *tempFormatter = [[NSDateFormatter alloc]init];
                    [tempFormatter setDateFormat:@"dd.MM.yyyy HH:mm"];
                    
                    event.startDate = [NSDate dateWithTimeIntervalSinceNow:60];//开始提醒的时间
                    event.endDate   = [NSDate dateWithTimeIntervalSinceNow:120];//The end date for the event
                    
//                    event.allDay = YES;
                    //添加提醒
//                    [event addAlarm:[EKAlarm alarmWithRelativeOffset:60.0f * -15.0f]];//提前15分钟开始提醒
                    [event setCalendar:[self.store defaultCalendarForNewEvents]];
                    NSError *err;
                    [self.store saveEvent:event span:EKSpanThisEvent error:&err];
                    /*************************重点**************************/
                    //  注意这里很蛋疼的一个问题日历事件只有在save以后才会随机生成一个eventIdentifier，用来标记这个事件（重点是随机的，也就是说当你在删除的时候只能在你创建事件后把eventIdentifier存储起来，通过它来找到这个事件从而来删除它）（我这里是通过数据库来存储的也可以通过服务端来存储）
                    NSLog(@"eventIdentifier======%@",event.eventIdentifier);
                    NSMutableDictionary *dic = [[NSMutableDictionary alloc] initWithCapacity:0];
                    [dic setValue:event.eventIdentifier?:@"" forKey:@"自己定义的一个key（大多是这个商品的id）"];
                    [self saveOrderCodeArray:dic];
                    
                    UIAlertView *alert = [[UIAlertView alloc]
                                          initWithTitle:@"Event Created"
                                          message:@"Yay!?"
                                          delegate:nil
                                          cancelButtonTitle:@"Okay"
                                          otherButtonTitles:nil];
                    [alert show];
                    NSLog(@"保存成功");
                }
            });
        }];
    
}
-(BOOL)deleteEvent:(EKEvent *)event
{
    NSError *err;
    BOOL isSuccess = NO;
    [event setCalendar:[self.store defaultCalendarForNewEvents]];
    [self.store removeEvent:event span:EKSpanThisEvent commit:YES error:&err];
    if (err == nil) {
        isSuccess = YES;
    }
    return isSuccess;
}

//存储ordercode
- (void)saveOrderCodeArray:(NSMutableDictionary *)saveDataDic
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"orderCode.plist"];
    // 2.组装存储数据
    BOOL writeSuccess = [saveDataDic writeToFile:filepath atomically:YES];
    if (writeSuccess) {
        NSLog(@"tabbarDele write success");
    }else {
        NSLog(@"tabbarDele write fail");
    }
}
- (NSMutableDictionary *)readOrderCodeArray
{
    // 1.获得沙盒(document)路径 －－ 宏定义了 DocumentsPath
    NSString *filepath = [[NSHomeDirectory() stringByAppendingPathComponent:@"Documents"] stringByAppendingPathComponent:@"orderCode.plist"];
    if (!filepath) {
        return nil;
    }
    // 2.读取数据
    NSMutableDictionary *sourceDataDic = [[NSMutableDictionary alloc] initWithContentsOfFile:filepath];
    return sourceDataDic?:[[NSMutableDictionary alloc] initWithCapacity:0];
}
- (void)tanKuang:(NSString *)str {
    // v1.7 弹窗
    if (str.length>0) {
        NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
        NSString *cancelButtonTitle = NSLocalizedString(@"取消", nil);
        
        UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:str preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
            NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
            [self openSettingsURLString];
        }];
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [self.navigationController popViewControllerAnimated:YES];
        }];
        //修改按钮
        if ([cancelAction valueForKey:@"_titleTextColor"]) {
            [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
        }
        //        [cancelAction setValue:[UIColor blackColor] forKey:@"_titleTextColor"];
        [alertController addAction:otherAction];
        [alertController addAction:cancelAction];
        [self presentViewController:alertController animated:YES completion:nil];
    }
    //*************************end*******************************
}
- (void)openSettingsURLString
{
    NSURL *url = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
    if([[UIApplication sharedApplication] canOpenURL:url]) {
        [[UIApplication sharedApplication] openURL:url];
    }
}
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
