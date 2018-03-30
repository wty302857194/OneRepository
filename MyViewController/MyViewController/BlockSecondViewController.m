//
//  BlockSecondViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/10/20.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "BlockSecondViewController.h"

@interface BlockSecondViewController ()

@end

@implementation BlockSecondViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
-(void)viewDidDisappear:(BOOL)animated {
    [super viewDidDisappear:animated];
    if (self.huiDiaoBlock) {
        self.huiDiaoBlock();
    }
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
