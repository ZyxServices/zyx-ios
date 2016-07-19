//
//  Helper_UserDefault.h
//  cdleishisdk
//
//  Created by mrdai on 13-10-15.
//  Copyright (c) 2013年 cdleichi. All rights reserved.
//

/**
 *  用户默认配置
 */
#import <Foundation/Foundation.h>

@interface Helper_UserDefault : NSObject

+(void)setObject:(id)_object forKey:(NSString *)_key;
+(id)objectForKey:(NSString *)_key;
+(void)removeObjectForKey:(NSString *)_key;

@end
