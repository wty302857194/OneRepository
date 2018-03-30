//
//  CeShiViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/6/1.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "CeShiViewController.h"

@interface CeShiViewController ()

@end

@implementation CeShiViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor clearColor];
    
    
    
    UIImageView *img= [[UIImageView alloc]init];
    img.center = self.view.center;
    img.image = [UIImage imageNamed:@"merchant_bg"];
    [self.view addSubview:img];
    [img mas_makeConstraints:^(MASConstraintMaker *make) {

        make.left.mas_equalTo(10);
        make.right.mas_equalTo(-10);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.equalTo(img.mas_width).multipliedBy(127/98.f);
    }];
    
//    UIButton *cancel_btn = [UIButton buttonWithType:UIButtonTypeCustom];
//    [cancel_btn addTarget:self action:@selector(cancelBtn:) forControlEvents:UIControlEventTouchUpInside];
//    [img addSubview:cancel_btn];
//    [cancel_btn mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.top.mas_equalTo(0);
//        make.right.mas_equalTo(0);
//        make.width.mas_equalTo(150);
//        make.height.mas_equalTo(cancel_btn.mas_width);
//    }];
//
//    UILabel *title_lab = [[UILabel alloc] init];
    
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
{
    [self dismissViewControllerAnimated:YES completion:nil];
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
