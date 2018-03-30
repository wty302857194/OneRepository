//
//  SearchResultConductTableViewCell.m
//  CJHLogistics
//
//  Created by wbb on 2017/11/16.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "SearchResultConductTableViewCell.h"
#import "SearchResultConductTwoTableViewCell.h"
#import "SearchResultModel.h"

@interface SearchResultConductTableViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SearchResultConductTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
-(void)setSearchModel:(SearchResultModel *)searchModel {
    _searchModel = searchModel;
    
    [self getCellHeight];
    [self.tableView reloadData];
}
- (UITableView *)tableView {
    if (!_tableView) {
        _tableView = [[UITableView alloc] initWithFrame:self.contentView.bounds style:UITableViewStyleGrouped];
        _tableView.scrollEnabled = NO;
        _tableView.delegate = self;
        _tableView.dataSource = self;
        [self.contentView addSubview:_tableView];
        
        [_tableView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.bottom.left.right.mas_equalTo(0);
        }];
    }
    return _tableView;
}
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    ListModel *model = _searchModel.list[indexPath.section];
    NSLog(@"middle-=-=-=%ld",(long)model.cellHeight);
    return model.cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    ListModel *model = _searchModel.list[section];
    return model.isFlex?1:0;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    
    return _searchModel.list.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier2";
    SearchResultConductTwoTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[SearchResultConductTwoTableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    ListModel *listModel = _searchModel.list[indexPath.section];
    cell.listModel = listModel;
    
    NSInteger height = 0;
    for (GoodsListModel *goodsModel in listModel.goodsList) {
        height = (goodsModel.isFlex?goodsModel.orderList.count:0)*(goodsModel.isFlex?goodsModel.cellHeight:0) + height;
    }
    listModel.cellHeight = listModel.goodsList.count*40 + height;
    
    cell.reloadTwoCellHeightBlock = ^() {
        //这里只是刷新行的话 会有一个动画的问题,(下面一行的区头动画显示有问题不知道怎么回事)
        [tableView reloadData];
    };
    return cell;
}
- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}
- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section
{
    return 0;
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    ListModel *model = _searchModel.list[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor orangeColor];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    button.frame = view.bounds;
    [button addTarget:self action:@selector(doFlex:) forControlEvents:UIControlEventTouchUpInside];
    button.tag = section + 100;
    [button setTitle:model.name forState:UIControlStateNormal];
    [view addSubview:button];
    return view;
}
- (void)doFlex:(UIButton *)btn {
    
    NSInteger section = btn.tag - 100;
    ListModel *model = _searchModel.list[section];
    model.isFlex = !model.isFlex;
    if (self.reloadCellHeightBlock) {
        self.reloadCellHeightBlock();
    }
    
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}
- (void)getCellHeight {
    NSInteger listHeight = 0;
    for (ListModel *listModel in _searchModel.list) {
        NSInteger height = 0;
        for (GoodsListModel *goodsModel in listModel.goodsList) {
            height = (goodsModel.isFlex?goodsModel.orderList.count:0)*(goodsModel.isFlex?goodsModel.cellHeight:0) + height;
        }
        listModel.cellHeight = listModel.goodsList.count*40 + height;

        listHeight = (listModel.isFlex?listModel.goodsList.count:0)*(listModel.isFlex?listModel.cellHeight:0) + listHeight;
    }
    _searchModel.cellHeight = _searchModel.list.count*40 + listHeight;
}
@end

