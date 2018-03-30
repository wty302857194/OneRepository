//
//  BlockViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/7/4.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "BlockViewController.h"
#import "BlockView.h"
#import "BlockFirstViewController.h"
@interface BlockViewController ()

@end

@implementation BlockViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
  BlockView *block_view = [[[NSBundle mainBundle] loadNibNamed:@"BlockView" owner:nil options:nil] lastObject];
    block_view.sureBlock = ^{
        NSLog(@"========queren====");
        
    };

    [block_view showBlockView:^{
        LRLog(@"quren确认");
        BlockFirstViewController *sc = [[BlockFirstViewController alloc] init];
        [self.navigationController pushViewController:sc animated:YES];
        [block_view removeFromSuperview];
    } CancleBlock:^{
        NSLog(@"乔取消");
    }];
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
