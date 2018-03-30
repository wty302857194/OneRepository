//
//  SearchResultConductTwoTableViewCell.h
//  CJHLogistics
//
//  Created by wbb on 2017/11/20.
//  Copyright © 2017年 cjh. All rights reserved.
//

#import <UIKit/UIKit.h>
@class ListModel;
typedef void(^ReloadTwoCellHeightBlock)(void);
@interface SearchResultConductTwoTableViewCell : UITableViewCell
@property (nonatomic, strong) NSArray *dataSourceArr;
@property (nonatomic, strong)  ListModel *listModel;
@property (nonatomic, assign) NSInteger cellHeight;
@property (nonatomic, copy) ReloadTwoCellHeightBlock reloadTwoCellHeightBlock;
@end
