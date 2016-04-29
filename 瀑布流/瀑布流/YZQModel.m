//
//  YZQModel.m
//  瀑布流
//
//  Created by YZQ_Nine on 16/3/1.
//  Copyright © 2016年 YZQ_Nine. All rights reserved.
//

#import "YZQModel.h"

@implementation YZQModel
- (void)setValue:(id)value forUndefinedKey:(NSString *)key{
    NSLog(@"找不到键值对%@,%@",value,key);
}
@end
