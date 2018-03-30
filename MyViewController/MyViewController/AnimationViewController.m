//
//  AnimationViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/6/3.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "AnimationViewController.h"

@interface AnimationViewController (){
    CALayer *m_layer;
}

@end

@implementation AnimationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    m_layer = [CALayer layer];
    
    m_layer.frame = CGRectMake(110, 150, 100, 100);
    
    //m_layer.position
    
    m_layer.cornerRadius = 50;
    
    m_layer.masksToBounds = YES;
    
    m_layer.backgroundColor = [UIColor redColor].CGColor;
    
    [self.view.layer addSublayer:m_layer];
    //创建一个按钮：用来开始动画效果
    
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    
    [button setBackgroundColor:[UIColor redColor]];
    
    button.frame = CGRectMake(10, 20, 300, 44);
    
    [button setTitle:@"开始动画" forState:0];
    
    [button addTarget:self action:@selector(beginAnimation) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:button];
}
-(void)beginAnimation{
    //    //事务 CATransaction 显式和隐式
    //    [CATransaction begin];
    //
    //     //默认的时间大概是0.25秒
    //
    //    [CATransaction setAnimationDuration:3.0];
    //    m_layer.opacity = 0;
    //
    //    [CATransaction begin];
    //    [CATransaction setAnimationDuration:3.0];
    //    m_layer.frame =CGRectMake(200, 300, 100, 100);
    //
    //    [CATransaction commit];
    //
    //    [CATransaction commit];
    
    [self beginBasicAni];
    //    [self beginKeyframeAni];
    //    [self beginTransition];
}
-(void)beginBasicAni{
    
    //动画效果改变一下m_layer的位置
    //animationWithKeyPath: 告诉posAni这个动画对象我要改变什么属性
    CABasicAnimation *posAni = [CABasicAnimation animationWithKeyPath:@"position"];
    //设置动画的持续时间
    [posAni setDuration:2.0];
    //通过动画效果恢复到原来的状态
    //posAni.autoreverses = YES;
    
    //kCAFillModeRemoved 这个默认值，也就是说动画开始前和结束后对这个layer没有影响，layer会恢复到之前的状态
    
    //kCAFillModeForwards 当前动画结束后，layer会保持最后的状态
    //fillMode作用：决定当前对象过了非活动时间段的行为
    //这个属性在removedOnCompletion = NO的时候才有效
    
    posAni.fillMode = kCAFillModeForwards;
    
    posAni.removedOnCompletion = NO;
    
    
    //设置动画的开始位置
    
    //fromValue, toValue, byValue 这三个属性，不能同时有两个以上为非空！
    
    posAni.fromValue = [NSValue valueWithCGPoint:m_layer.position];
    
    //动画到达的位置
    CGPoint topoint = m_layer.position;
    
    topoint.y += 150;
    
    
    posAni.toValue = [NSValue valueWithCGPoint:topoint];
    
    
    //图层添加动画
    
    
    //[m_layer addAnimation:posAni forKey:nil];
    
    //旋转的动画效果
    CABasicAnimation *rotaAni =[CABasicAnimation animationWithKeyPath:@"transform.rotation"];
    
    rotaAni.duration = 2.0;
    
    rotaAni.byValue = [NSNumber numberWithFloat:M_PI/2];
    
    //[m_layer addAnimation:rotaAni forKey:nil];
    
    //缩放的动画效果
    
    CABasicAnimation *scalAni = [CABasicAnimation animationWithKeyPath:@"transform.scale"];
    scalAni.duration = 2.0;
    scalAni.fillMode = kCAFillModeForwards;
    scalAni.removedOnCompletion = NO;
    scalAni.toValue = [NSNumber numberWithFloat:0.5];
    
    [m_layer addAnimation:scalAni forKey:nil];
    //创建动画组
    CAAnimationGroup *group = [CAAnimationGroup animation];
    //把创建的几个动画放进组里面
    group.animations = [NSArray arrayWithObjects:posAni,rotaAni,scalAni, nil];
    
    group.duration = 2.0;
    
    
//    [m_layer addAnimation:group forKey:nil];
    
    
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
