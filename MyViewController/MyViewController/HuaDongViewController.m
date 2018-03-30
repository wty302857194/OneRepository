//
//  HuaDongViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/7/12.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "HuaDongViewController.h"
#import "CFDeleteTableViewCell.h"
@interface HuaDongViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UITableView *tab_view;
@property (nonatomic, strong) NSMutableArray *titles;
@end

@implementation HuaDongViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.titles = [@[@"0000000000000000000000000", @"111111111111",@"2222222222",@"3333333333",@"4444444444",@"5555555555",@"6666666666",@"7777777777",@"8888888888",@"9999999999"] mutableCopy];
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.titles.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString *cellId = @"deleteCell";
    CFDeleteTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellId];
    if (!cell) {
        cell = [[NSBundle mainBundle] loadNibNamed:@"CFDeleteTableViewCell" owner:self options:nil].lastObject;
    }
    cell.titleLabel.text = self.titles[indexPath.row];
    __weak typeof (self) weakSelf = self;
    __weak typeof (cell) weakCell = cell;
    cell.mySwipeBlock = ^{
        for(CFDeleteTableViewCell *tmpCell in tableView.visibleCells){
            // 将其他正在打开的cell关闭
            if (![weakCell isEqual:tmpCell]) {
                [tmpCell closeMenu];
            }
        }
    };
    cell.myDeleteBlock =^{
        if (self.titles.count) {
            [weakSelf.titles removeObjectAtIndex:indexPath.row];
            
            NSLog(@"%ld", indexPath.row);
            if (indexPath.row == weakSelf.titles.count) {
                // 删除的是最后一个直接刷新
                [weakSelf.tab_view reloadData];
            }else{
                // 删除其他的cell，带动画
                [weakSelf.tab_view deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationRight];
                
                [weakSelf.tab_view reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationTop];
            }
        }
    };
    
    return cell;
}


// 隐藏状态栏
- (BOOL)prefersStatusBarHidden{
    
    // [[UIApplication sharedApplication] setStatusBarHidden:YES];// iOS9已经弃用
    return YES;
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
