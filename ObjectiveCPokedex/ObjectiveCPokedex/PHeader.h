#import <UIKit/UIKit.h>

@interface PHeader : UIView

-(void) didChangeText: (void (^)(NSString *text)) callback;

@end
