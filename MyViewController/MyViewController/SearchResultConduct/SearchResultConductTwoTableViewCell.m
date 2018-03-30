//
//  SearchResultConductTwoTableViewCell.m
//  CJHLogistics
//
//  Created by wbb on 2017/11/20.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import "SearchResultConductTwoTableViewCell.h"
#import "SearchResultModel.h"

@interface SearchResultConductTwoTableViewCell ()<UITableViewDataSource,UITableViewDelegate>

@property (nonatomic,strong) UITableView *tableView;
@end

@implementation SearchResultConductTwoTableViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        self.tableView.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        self.selectionStyle = UITableViewCellSelectionStyleNone;
        
    }
    return self;
}
- (void)setListModel:(ListModel *)listModel {
    _listModel = listModel;
    
//    [self getCellHeight];
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
    GoodsListModel *model = _listModel.goodsList[indexPath.section];
    NSLog(@"bottom-=-=-=%ld",(long)model.cellHeight);
    return model.cellHeight;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    GoodsListModel *model = _listModel.goodsList[section];
    if (model.isFlex == NO) {
        return 0;
    }
    return model.orderList.count;
}
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    NSLog(@"bottom-=-=-=%ld",(long)_listModel.goodsList.count);

    return _listModel.goodsList.count;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *identifier = @"identifier";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:identifier];
    }
    GoodsListModel *model = _listModel.goodsList[indexPath.section];
    OrderListModel *orderMode = model.orderList[indexPath.row];
    cell.textLabel.text = orderMode.name;
    
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
    GoodsListModel *model = _listModel.goodsList[section];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREEN_WIDTH, 40)];
    view.backgroundColor = [UIColor blueColor];
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
    GoodsListModel *model = _listModel.goodsList[section];
    model.isFlex = !model.isFlex;
//    [self getListModelCellHeight];
//    [self.tableView reloadData];
    
    if (self.reloadTwoCellHeightBlock) {
        self.reloadTwoCellHeightBlock();
    }
}
- (nullable UIView *)tableView:(UITableView *)tableView viewForFooterInSection:(NSInteger)section
{
    return nil;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
}

//- (void)getCellHeight {
//    NSInteger height = 0;
//    for (GoodsListModel *goodsModel in _listModel.goodsList) {
//        height = (goodsModel.isFlex?goodsModel.orderList.count:0)*(goodsModel.isFlex?goodsModel.cellHeight:0) + height;
//    }
//    _listModel.cellHeight = _listModel.goodsList.count*40 + height;
//}

@end
