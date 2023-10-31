//
//  PokeDetails.h
//  ObjectiveCPokedex
//
//  Created by Thales Gelinger on 30/10/23.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface PokeDetails : NSObject

@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSNumber *number;
@property (strong, nonatomic) NSString *imgUrl;
@property (strong, nonatomic) NSNumber *weight;
@property (strong, nonatomic) NSNumber *height;
@property (strong, nonatomic) NSMutableArray *abilities;
@property (strong, nonatomic) NSMutableArray *types;
@property (strong, nonatomic) NSDictionary *stats;

@end

NS_ASSUME_NONNULL_END
