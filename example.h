#import <Foundation/Foundation.h>

@interface NSString (reverse)
- (NSString *) reverse;
@end

@interface Example: NSObject {}

+ (NSNumber *) isEven: (NSNumber *) i;

+ (NSNumber *) genEven;

+ (NSNumber *) reversible: (NSString *) s;

@end
