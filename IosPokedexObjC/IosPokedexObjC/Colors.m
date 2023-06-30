
#import "Colors.h"

@interface Colors ()

+ (UIColor *)fromHex:(NSString *)value;

@end

@implementation Colors

+ (UIColor *)fromHex:(NSString *)value {

  NSString *cleanedString = [value stringByReplacingOccurrencesOfString:@"#"
                                                             withString:@""];
  NSScanner *scanner = [NSScanner scannerWithString:cleanedString];
  unsigned int hex;
  if (![scanner scanHexInt:&hex]) {
    return nil;
  }
  CGFloat red = (CGFloat)((hex & 0xFF0000) >> 16) / 255.0;
  CGFloat green = (CGFloat)((hex & 0x00FF00) >> 8) / 255.0;
  CGFloat blue = (CGFloat)(hex & 0x0000FF) / 255.0;
  return [UIColor colorWithRed:red green:green blue:blue alpha:1.0];
}

+ (UIColor *)primary {
  return [self fromHex:@"#dc0a2d"];
}

+ (NSDictionary *)pokeType {
  return @{
    @"bug" : [self fromHex:@"#A7B723"],
    @"dark" : [self fromHex:@"#75574C"],
    @"dragon" : [self fromHex:@"#7037FF"],
    @"electric" : [self fromHex:@"#F9CF30"],
    @"fairy" : [self fromHex:@"#E69EAC"],
    @"fighting" : [self fromHex:@"#C12239"],
    @"fire" : [self fromHex:@"#F57D31"],
    @"flying" : [self fromHex:@"#A891EC"],
    @"ghost" : [self fromHex:@"#70559B"],
    @"normal" : [self fromHex:@"#AAA67F"],
    @"grass" : [self fromHex:@"#74CB48"],
    @"ground" : [self fromHex:@"#DEC16B"],
    @"ice" : [self fromHex:@"#9AD6DF"],
    @"poison" : [self fromHex:@"#A43E9E"],
    @"psychic" : [self fromHex:@"#FB5584"],
    @"rock" : [self fromHex:@"#B69E31"],
    @"steel" : [self fromHex:@"#B7B9D0"],
    @"water" : [self fromHex:@"#6493EB"],
  };
}

+ (NSDictionary *)grayscale {
  return @{
    @"dark" : [self fromHex:@"#212121"],
    @"medium" : [self fromHex:@"#666666"],
    @"light" : [self fromHex:@"#E0E0E0"],
    @"background" : [self fromHex:@"#EFEFEF"],
    @"white" : [self fromHex:@"#FFFFFF"],
  };
}

@end
