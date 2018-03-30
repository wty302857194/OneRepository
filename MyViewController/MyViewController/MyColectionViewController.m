//
//  MyColectionViewController.m
//  MyViewController
//
//  Created by 杨飞 on 16/8/23.
//  Copyright © 2016年 cjh. All rights reserved.
//

#import "MyColectionViewController.h"
#import "MyCollectionViewCell.h"
#import "SearchTableViewController.h"
#import "XWDrawerAnimator.h"
#import "UIViewController+XWTransition.h"

@interface MyColectionViewController ()<UICollectionViewDelegate,UICollectionViewDataSource,UISearchResultsUpdating, UISearchBarDelegate,UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic) IBOutlet UICollectionView *collectionView;

@end

@implementation MyColectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self.collectionView registerClass:[MyCollectionViewCell class] forCellWithReuseIdentifier:@"myCollectionCell"];
    
}
//返回分区个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView{
    return 1;
}
//返回每个分区的item个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 12;
}
//返回每个item
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    MyCollectionViewCell * cell  = (MyCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"myCollectionCell" forIndexPath:indexPath];
    cell.backgroundColor = [UIColor colorWithRed:arc4random()%255/255.0 green:arc4random()%255/255.0 blue:arc4random()%255/255.0 alpha:1];
    cell.img_view.image = [UIImage imageNamed:@"CF_ICON"];
    cell.content_lab.text = [NSString stringWithFormat:@"wbb%ld",(long)indexPath.row];
    return cell;
}
- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return  UIEdgeInsetsMake(10, 10, 10, 10);
}
//返回cell的宽和高
-(CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewFlowLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath{

    
    return CGSizeMake((SCREEN_WIDTH-40) / 3, (SCREEN_WIDTH-40) / 3);
}
//每行cell之间的间隔
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section{
    return 10;
}
// 列宽是系统自己计算的
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section{
    return 0;
}
- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        SearchTableViewController *searchTVC = [[SearchTableViewController alloc] init];
//        UITableViewController *searchTVC = [[UITableViewController alloc] init];
//        searchTVC.tableView.delegate = self;
//        searchTVC.tableView.dataSource = self;
        searchTVC.view.frame =  CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
        
        
        UISearchController *searchVC = [[UISearchController alloc] initWithSearchResultsController:searchTVC];
        searchVC.searchBar.backgroundColor = [UIColor grayColor];
        searchVC.searchBar.barStyle = UIBarStyleDefault;
        searchVC.searchResultsUpdater = self;
        searchVC.searchBar.placeholder = @"搜索品牌";
        searchVC.searchBar.frame = CGRectMake(0, 0,KSCREEN_WIDTH,  64);
        [searchVC.searchBar sizeToFit];
        searchVC.hidesNavigationBarDuringPresentation = YES;
        self.definesPresentationContext = YES;
        [self.navigationController pushViewController:searchVC animated:YES];
        
    }else if (indexPath.row == 1){
//        NSArray *arr=@[@"1",@"2",@"3"];
//        NSString *str = arr[4];
//        NSLog(@"====%@",str);
        [self BaseServicesTransition];
    }
}

#pragma mark - 弹出基础服务弹框
- (void)BaseServicesTransition {
    
    XWDrawerAnimatorDirection direction = XWDrawerAnimatorDirectionBottom;
    CGFloat distance = 450; //基础服务窗口高度
    XWDrawerAnimator *animator = [XWDrawerAnimator xw_animatorWithDirection:direction moveDistance:distance];
    animator.toDuration = 0.5;
    animator.backDuration = 0.5;
    animator.flipEnable = YES;
    
    //点击当前界面返回
    SearchTableViewController *baseServicesVc = [[SearchTableViewController alloc] init];
    [self xw_presentViewController:baseServicesVc withAnimator:animator];
    __weak typeof(self)weakSelf = self;
    [animator xw_enableEdgeGestureAndBackTapWithConfig:^{
        [weakSelf selfAlterViewback];
    }];
}
#pragma 退出分享界面
- (void)selfAlterViewback{
    
    [self dismissViewControllerAnimated:YES completion:nil];
}
- (UICollectionReusableView *)collectionView:(UICollectionView *)collectionView viewForSupplementaryElementOfKind:(NSString *)kind atIndexPath:(NSIndexPath *)indexPath
{
//    if (kind == UICollectionElementKindSectionHeader)
//    {
//        CollectionFooterView *reusableView = [collectionView dequeueReusableSupplementaryViewOfKind:UICollectionElementKindSectionFooter withReuseIdentifier:@"CollectionFooterView" forIndexPath:indexPath];
//        
//        reusableView.name_lab.text=group_name;
//        
//        return reusableView;
//    }
    return nil;
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
