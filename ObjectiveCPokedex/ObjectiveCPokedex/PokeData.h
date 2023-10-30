//
//  PokeData.h
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 30/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokeData : NSObject

@property (strong, nonatomic) NSString *name;
@property (nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *imgUrl;

@end

NS_ASSUME_NONNULL_END
