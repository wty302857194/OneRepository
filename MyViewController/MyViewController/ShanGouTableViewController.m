//
//  ShanGouTableViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/9/23.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "ShanGouTableViewController.h"
#import "ShanGouListTableViewController.h"
@interface ShanGouTableViewController (){
    NSArray *_pic_img_arr,*_btn_arr;
    UIButton *_select_btn;
}
@property (weak, nonatomic) IBOutlet UIView *top_view;
@property (weak, nonatomic) IBOutlet UIScrollView *btn_scrollView;
//@property (weak, nonatomic) IBOutlet UIScrollView *content_scrollView;
@property (weak, nonatomic) IBOutlet UITableViewCell *content_tableViewCell;
@property (strong, nonatomic)  UIScrollView *content_scollView;
@end

@implementation ShanGouTableViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _btn_arr = [[NSArray alloc] initWithObjects:@"1",@"2",@"3",@"3",@"3", nil];
//    self.content_scrollView.contentSize = CGSizeMake(SCREEN_WIDTH*_btn_arr.count, 500-40);
    self.content_scollView.contentSize = CGSizeMake(SCREEN_WIDTH*_btn_arr.count, 500-40);
    [self topView];
}
- (UIScrollView *)content_scollView{
    if (!_content_scollView) {
        _content_scollView = [[UIScrollView alloc] initWithFrame:CGRectMake(0, 40, SCREEN_WIDTH, 500-40)];
//        _content_scollView.backgroundColor = [UIColor redColor];
        _content_scollView.delegate = self;
        _content_scollView.pagingEnabled=YES;
        _content_scollView.alwaysBounceHorizontal = NO;
        [_content_tableViewCell addSubview:_content_scollView];
    }
    return _content_scollView;
}

- (void)topView {
    for (int i=0; i<_btn_arr.count; i++) {
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.frame = CGRectMake(i*(SCREEN_WIDTH/_btn_arr.count), 0, SCREEN_WIDTH/_btn_arr.count, 40);
        btn.tag = 100+i;
        btn.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];
        if (i == 100) {
            _select_btn = btn;
            btn.backgroundColor = [UIColor redColor];
        }
        
        [btn addTarget:self action:@selector(btnTouch:) forControlEvents:UIControlEventTouchUpInside];
        [_btn_scrollView addSubview:btn];
        
        UIStoryboard *story = [UIStoryboard storyboardWithName:@"ShanGou" bundle:nil];
        ShanGouListTableViewController *SGTC = [story instantiateViewControllerWithIdentifier:@"shanGouList"];
        [self addChildViewController:SGTC];
        SGTC.view.frame = CGRectMake(i*SCREEN_WIDTH, 0, SCREEN_WIDTH, self.content_scollView.contentSize.height);
        SGTC.view.backgroundColor = [UIColor colorWithRed:arc4random_uniform(256)/255.0 green:arc4random_uniform(256)/255.0 blue:arc4random_uniform(256)/255.0 alpha:1.0];

        [self.content_scollView addSubview:SGTC.view];
        [self.content_scollView bringSubviewToFront:SGTC.view];
    }
}
- (void)btnTouch:(UIButton *)btn {
    if (btn == _select_btn) {
        return;
    }
    _select_btn.backgroundColor = [UIColor blueColor];
    btn.backgroundColor = [UIColor redColor];
    
    [self.content_scollView setContentOffset:CGPointMake((btn.tag-100)*SCREEN_WIDTH, 0) animated:YES];
    _select_btn = btn;
}
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    
    NSInteger a = scrollView.contentOffset.x/SCREEN_WIDTH;
    UIButton *btn = (UIButton *)[self.view viewWithTag:a+100];
    _select_btn.backgroundColor = [UIColor blueColor];
    btn.backgroundColor = [UIColor redColor];
    
    _select_btn = btn;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 500;
}
/*
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:<#@"reuseIdentifier"#> forIndexPath:indexPath];
    
    // Configure the cell...
    
    return cell;
}
*/

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
