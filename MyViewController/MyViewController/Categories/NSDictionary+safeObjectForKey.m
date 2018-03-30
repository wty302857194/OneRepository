//
//  NSDictionary+safeObjectForKey.m
//  cjh
//
//  Created by user_lzz on 15/10/28.
//  Copyright © 2015年 njcjh. All rights reserved.
//

#import "NSDictionary+safeObjectForKey.h"

#define checkNull(__X__)        (__X__) == [NSNull null] || (__X__) == nil ? @"" : [NSString stringWithFormat:@"%@", (__X__)]

#define boolNull(__Y__)         (__Y__) == [NSNull null] || (__Y__) == nil ? @"0" : [NSString stringWithFormat:@"%@", (__Y__)]

@implementation NSDictionary (safeObjectForKey)

- (id)safeObjectForKey:(id)key
{
    return checkNull([self objectForKey:key]);
}

- (BOOL)safeBoolForKey:(id)key
{
    return [boolNull([self objectForKey:key]) boolValue];
}

- (NSDictionary *)getNewDictionary {
    NSArray *arr = [self allKeys];
    NSMutableDictionary *mutable_dic = [[NSMutableDictionary alloc] initWithCapacity:0];
    for (id str in arr) {
        id vule = [self safeObjectForKey:str];
        [mutable_dic setObject:vule forKey:str];
    }
    return mutable_dic;
}
@end
