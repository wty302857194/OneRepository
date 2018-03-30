//
//  SearchResultModel.h
//  MyTestVC
//
//  Created by wbb on 2017/11/16.
//  Copyright © 2017年 wbb. All rights reserved.
//

#import <Foundation/Foundation.h>
@class GoodsListModel,ListModel,OrderListModel;
@interface SearchResultModel : NSObject
@property (nonatomic, copy) NSString *phoneNum;
@property (nonatomic, strong) NSArray *list;
@property (nonatomic, assign) BOOL isFlex;
@property (nonatomic, assign) NSInteger cellHeight;
@end

@interface ListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *goodsList;
@property (nonatomic, assign) BOOL isFlex;
@property (nonatomic, assign) NSInteger cellHeight;
@end

@interface GoodsListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, strong) NSArray *orderList;
@property (nonatomic, assign) BOOL isFlex;
@property (nonatomic, assign) NSInteger cellHeight;
@end

@interface OrderListModel : NSObject
@property (nonatomic, copy) NSString *name;
@property (nonatomic, copy) NSString *num;//

@end
