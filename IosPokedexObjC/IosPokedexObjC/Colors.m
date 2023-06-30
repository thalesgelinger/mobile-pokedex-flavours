
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

@end
