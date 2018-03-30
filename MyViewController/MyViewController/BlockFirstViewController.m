//
//  BlockFirstViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/10/20.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "BlockFirstViewController.h"
#import "BlockSecondViewController.h"
@interface BlockFirstViewController ()

@end

@implementation BlockFirstViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
}
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    BlockSecondViewController *sc = [[BlockSecondViewController alloc] init];
    sc.huiDiaoBlock = ^{
        LRLog(@"======回调-=====");
    };
    [self.navigationController pushViewController:sc animated:YES];
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
