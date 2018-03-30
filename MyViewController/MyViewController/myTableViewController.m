//
//  myTableViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/4/14.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "myTableViewController.h"
#import "MyView.h"
#import "CleckViewController.h"
#import "FirstViewController.h"
#import "HYMDatePicker.h"
#import "JXAlertview.h"
#import "RedPacketView.h"
#import "CeShiViewController.h"
#import "AnimationViewController.h"
#import "TopQianTaoTableViewController.h"
#import "myTableViewControllerCell.h"
#import "UserViewController.h"
#import "BlockViewController.h"
#import "HuaDongViewController.h"
#import "CalendarViewController.h"
#import "ShanGouTableViewController.h"
@interface myTableViewController ()<UITableViewDelegate,UITableViewDataSource,HYMDatePickerDelegate,CustomAlertDelegete,RedPacketViewDelegate>{
    MyView *view;
    NSArray *my_arr;
    RedPacketView *_redPacket_view;
    UIView *vi,*back_view;
    UILabel *lab;
    BOOL isSet;
}

@property (strong, nonatomic) HYMDatePicker *datePicker;
@end

@implementation myTableViewController
- (IBAction)valueChange:(UITextField *)sender {
    NSString *subString = sender.text;
    NSString *lang = sender.textInputMode.primaryLanguage;
    if ([lang isEqualToString:@"zh-Hans"]) {
        UITextRange *range = [sender markedTextRange];
        if (!range&&subString.length>5) {
            sender.text = [subString substringToIndex:5];
        }
    }else if(subString.length>5) {
        sender.text = [subString substringToIndex:5];
    }
}
- (UIStatusBarStyle)preferredStatusBarStyle{
    
    return isSet?UIStatusBarStyleDefault:UIStatusBarStyleLightContent;
    
}

// 隐藏状态栏
//- (BOOL)prefersStatusBarHidden{
//    
//    // [[UIApplication sharedApplication] setStatusBarHidden:YES];// iOS9已经弃用
//    return YES;
//}
- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    self.navigationController.navigationBar.hidden = NO;
    [vi removeFromSuperview];
    vi = nil;
    isSet = YES;
    [self preferredStatusBarStyle];
}
-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    self.navigationController.navigationBar.hidden = YES;

    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.automaticallyAdjustsScrollViewInsets = NO;
    isSet = NO;
    [self preferredStatusBarStyle];
//    [self setNeedsStatusBarAppearanceUpdate];
    
    vi = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 64)];
    vi.backgroundColor = [UIColor clearColor];
    [[UIApplication sharedApplication].keyWindow addSubview:vi];
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [backBtn setFrame:CGRectMake(0, 20, 44, 44)];
    [backBtn addTarget:self action:@selector(backBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [backBtn setImage:[UIImage imageNamed:@"default_back_3"] forState:UIControlStateNormal];
    backBtn.imageEdgeInsets = UIEdgeInsetsMake(12, 10, 12, 14);
    [vi addSubview:backBtn];
    
    lab = [[UILabel alloc] init];
    lab.frame = CGRectMake(0, 0, 120, 44 );
    lab.textAlignment = NSTextAlignmentCenter;
    lab.center = CGPointMake(vi.center.x, vi.center.y+12);
    [lab setFont:[UIFont systemFontOfSize:17]];
    lab.text = @"确认订单";
    lab.textColor = [UIColor whiteColor];
    [vi addSubview:lab];
}
- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    CGFloat offSet = scrollView.contentOffset.y;
    if (offSet >0) {
        CGFloat alpha = 1 - ((64 - offSet) / 64);
        vi.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:alpha];
        if (offSet>=20) {
            lab.textColor = [UIColor blackColor];
            isSet = NO;
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleDefault];
            
        }else{
            lab.textColor = [UIColor whiteColor];
            [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];  
            isSet = YES;
        }
        
        [self preferredStatusBarStyle];
    }else {
        vi.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0];
        CGRect frame= view.frame;
        view.y = 0;
        frame.size.height=-offSet+161;
        view.frame=frame;
    }
}
- (void)setAnimationForVi {
    
}
- (void)viewDidLoad {
    [super viewDidLoad];
    
    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
    
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
    my_arr = @[@"推送",@"键盘通知",@"时间选择器",@"帅比",@"……",@"模态动画",@"核心动画",@"跳转嵌套",@"user跳转嵌套",@"block练习",@"拖动btn",@"CELL滑动删除",@"仿365",@"日历提醒",@"充值吧",@"myColection",@"闪购"];
    view = [[[NSBundle mainBundle] loadNibNamed:@"MyView" owner:nil options:nil] lastObject];
    view.image_view.contentMode = UIViewContentModeScaleAspectFill;
    _tabView.tableHeaderView = view;
    NSString *path = [[NSBundle mainBundle] pathForResource:@"merchant_bg@2x" ofType:@"png"];
    NSLog(@"======path=====%@",path);
    str = @"2";

    
    
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.

}

#pragma mark listViewdataSource method and delegate method
- (NSInteger)tableView:(UITableView *)table numberOfRowsInSection:(NSInteger)section{
    return my_arr.count+1;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == my_arr.count) {
        static NSString *cellId = @"myTableViewCell";
        myTableViewControllerCell* cell = [tableView dequeueReusableCellWithIdentifier:cellId];
        if (!cell) {
//            cell = [[myTableViewControllerCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellId];
            cell = [[[NSBundle mainBundle] loadNibNamed:@"myTableViewCell" owner:nil options:nil] lastObject];
        }
        cell.text_view.placeholder = @"bangbnagbang";
        cell.text_view.placeholderColor= [UIColor redColor];
        cell.myLab.text = @"wbbwbwbwbbwbbwbbwbw";
        return cell;
    }else {
        static NSString *cellid=@"listviewid";
        UITableViewCell* cell=[tableView dequeueReusableCellWithIdentifier:cellid];
        if(cell==nil){
            cell=[[UITableViewCell alloc]initWithStyle:UITableViewCellStyleValue1
                                       reuseIdentifier:cellid];
        }
        //文本标签
        cell.textLabel.text = my_arr[indexPath.row];
        return cell;
    }
    return nil;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    if (indexPath.row == my_arr.count) {
        return 100;
    }
    return 44;
}
//当选择下拉列表中的一行时，设置文本框中的值，隐藏下拉列表
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"select");
        switch (indexPath.row) {
            case 0:{
                CleckViewController *cleck= [[CleckViewController alloc] init];
                [self.navigationController pushViewController:cleck animated:YES];
            }
                break;
            case 1:{
                FirstViewController *cleck= [[FirstViewController alloc] init];
                [self.navigationController pushViewController:cleck animated:YES];
            }
                break;
            case 2:{
                
                JXAlertview *alert = [[JXAlertview alloc] initWithFrame:CGRectMake(10, (self.view.frame.size.height-260)/2, self.view.frame.size.width-20, 260)];
                //alert.image = [UIImage imageNamed:@"dikuang"];
                alert.delegate = self;
                [alert initwithtitle:@"请选择日期" andmessage:@"" andcancelbtn:@"取消" andotherbtn:@"确定"];
                //我把Dpicker添加到一个弹出框上展现出来 当然大家还是可以以任何其他动画形式展现
                [alert showview];

            }
                break;
            case 3:{
                _redPacket_view = [[[NSBundle mainBundle] loadNibNamed:@"RedPacketView" owner:nil options:nil] lastObject];
                _redPacket_view.delegate = self;
                _redPacket_view.frame = CGRectMake(0, 150, SCREEN_WIDTH, SCREENH_HEIGHT);
                NSMutableAttributedString *str1=[[NSMutableAttributedString alloc]initWithString:@"20元礼券"];
                [str1 addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:22] range:NSMakeRange(0,2)];
                _redPacket_view.money_liquan.attributedText=str1;
                [[UIApplication sharedApplication].keyWindow addSubview:_redPacket_view];
                [UIView animateWithDuration:2.0 // 动画时长
                                      delay:0.0 // 动画延迟
                     usingSpringWithDamping:0.5 // 类似弹簧振动效果 0~1
                      initialSpringVelocity:11.0 // 初始速度
                                    options:UIViewAnimationOptionCurveEaseInOut // 动画过渡效果
                                 animations:^{
                                     // code...
                                     CGPoint point = _redPacket_view.center;
                                     point.y -= 150;
                                     [_redPacket_view setCenter:point];
                                 } completion:^(BOOL finished) {
                                     // 动画完成后执行
                                     // code...
                                     [_redPacket_view setAlpha:1];
                                 }];
            }
                break;
            case 4:{
                [self showOkayCancelAlert];
            }
                break;
            case 5:{
                CeShiViewController *ceshi = [[CeShiViewController alloc] init];
                ceshi.modalPresentationStyle = UIModalPresentationCustom;
                ceshi.modalTransitionStyle = UIModalTransitionStyleCoverVertical;
                [self presentViewController:ceshi animated:YES completion:nil];
                
//                UIView *vi = [[UIView alloc] initWithFrame:self.view.bounds];
//                vi.backgroundColor = [UIColor blackColor];
//                vi.alpha = 0.5;
//                [self.view addSubview:vi];
            }
                break;
            case 6:{
                AnimationViewController *ceshi = [[AnimationViewController alloc] init];
                [self presentViewController:ceshi animated:YES completion:nil];
                
            }
                break;
            case 7:{
//                UIStoryboard *story = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
//                TopQianTaoTableViewController *qiantao = [story instantiateViewControllerWithIdentifier:@"qiantao"];
                [self performSegueWithIdentifier:@"qiantao" sender:self];
//                [self.navigationController pushViewController:qiantao animated:YES];
            }
                break;
            case 8:{
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"user" bundle:nil];
                UserViewController *qiantao = [story instantiateViewControllerWithIdentifier:@"user"];
                [self.navigationController pushViewController:qiantao animated:YES];
            }
                break;
            case 9:{
                
                BlockViewController *qiantao = [[BlockViewController alloc] init];
                [self.navigationController pushViewController:qiantao animated:YES];
            }
                break;
            case 10:{
                //TuoDongViewController
                [self performSegueWithIdentifier:@"TuoDongViewController" sender:self];
            }
                break;
            case 11:{
                //TuoDongViewController
                HuaDongViewController *ceshi = [[HuaDongViewController alloc] init];
                [self presentViewController:ceshi animated:YES completion:nil];
            }
                break;
            case 12:{
                //TuoDongViewController
                [self performSegueWithIdentifier:@"365ViewController" sender:self];
            }
                break;
            case 13:{
                CalendarViewController *ceshi = [[CalendarViewController alloc] init];
                [self.navigationController pushViewController:ceshi animated:YES];

            }
                break;
            case 14:{
                CalendarViewController *ceshi = [[CalendarViewController alloc] init];
                [self.navigationController pushViewController:ceshi animated:YES];
                
            }
                break;
            case 15:{
                
                [self performSegueWithIdentifier:@"MyColectionViewController" sender:self];
            }
                break;
            case 16:{
                
                UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShanGou" bundle:nil];
                ShanGouTableViewController *qiantao = [story instantiateViewControllerWithIdentifier:@"shanGou"];
                [self.navigationController pushViewController:qiantao animated:YES];
            }
                break;
            default:{
                [self performSegueWithIdentifier:@"MyColectionViewController" sender:self];
            }
                break;
        }
    

}
- (void)showOkayCancelAlert {
//    NSString *title = NSLocalizedString(@"A Short Title Is Best", nil);
//    NSString *message = NSLocalizedString(@"A message should be a short, complete sentence.", nil);
    NSString *cancelButtonTitle = NSLocalizedString(@"返回", nil);
    NSString *otherButtonTitle = NSLocalizedString(@"确定", nil);
    
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"" message:@"测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~测试。测试。测试~" preferredStyle:UIAlertControllerStyleAlert];
    
    // Create the actions.
    UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:cancelButtonTitle style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's cancel action occured.");
    }];
    
    UIAlertAction *otherAction = [UIAlertAction actionWithTitle:otherButtonTitle style:UIAlertActionStyleDestructive handler:^(UIAlertAction *action) {
        NSLog(@"The \"Okay/Cancel\" alert's other action occured.");
    }];
    //修改按钮
    //    if ([cancelAction valueForKey:@"titleTextColor"]) {
    [cancelAction setValue:[UIColor blackColor] forKey:@"titleTextColor"];
    //    }
    // Add the actions.
    [alertController addAction:cancelAction];
    [alertController addAction:otherAction];
    
    [self presentViewController:alertController animated:YES completion:nil];
}
-(void)btnindex:(int)index :(int)tag withSureDate:(NSString *)date
{
    if (index == 2) {
        
        UITableViewCell *cell =  [_tabView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:2 inSection:0]];
        
        if (date&&date.length>0) {
            cell.detailTextLabel.text = date;
        }
    }
}
- (void)redPacketViewDetal:(NSInteger)btnTag {
    if (btnTag == 1) {
        NSLog(@"取消按钮");
        [_redPacket_view removeFromSuperview];
        _redPacket_view = nil;
    }else {
        NSLog(@"分享按钮");
    }
}

@end
