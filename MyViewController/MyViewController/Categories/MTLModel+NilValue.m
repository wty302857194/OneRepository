//
//  MTLModel+NilValue.m
//  cjh
//
//  Created by user_lzz on 15/10/28.
//  Copyright © 2015年 njcjh. All rights reserved.
//

#import "MTLModel+NilValue.h"

@implementation MTLModel (NilValue)

- (void)setNilValueForKey:(NSString *)key
{
    [self setValue:@0 forKey:key];
}

@end
