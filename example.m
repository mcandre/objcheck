#import "example.h"
#import "ObjCheck.h"
#import <Foundation/Foundation.h>

@implementation NSString (reverse)

// From Mac Developer Tips
// http://macdevelopertips.com/objective-c/objective-c-categories.html
- (NSString *) reverse {
  NSString *result;

  NSUInteger len = [self length];

  result = [NSMutableString stringWithCapacity: len];

  while (len > 0) {
    result = [result stringByAppendingString: [NSString stringWithFormat: @"%c", [self characterAtIndex: --len]]];
  }

  return result;
}

@end

@implementation Example

+ (NSNumber *) isEven: (NSNumber *) i {
  BOOL b = [i intValue] % 2 == 0;

  return [NSNumber numberWithBool: b];
}

+ (NSNumber *) genEven {
  int i = [(NSNumber*)[ObjCheck genNum] intValue];

  if(i % 2 != 0) {
    i++;
  }

  return [NSNumber numberWithInt: i];
}

+ (NSNumber *) reversible: (NSString *) s {
  BOOL b = [s isEqualToString: [[s reverse] reverse]];

  return [NSNumber numberWithBool: b];
}

@end

int main() {
  NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];

  NSMutableArray* gs = [NSMutableArray array];
  [gs addObject: ^() { return [ObjCheck genNum]; }];
  
  // Are all integers even?
  [ObjCheck forAll: [Example class] withProperty: @selector(isEven:) withGenerators: gs];
  
  NSMutableArray* gs2 = [NSMutableArray array];
  [gs2 addObject: ^() { return [Example genEven]; }];
  
  // Are all even integers even?
  [ObjCheck forAll: [Example class] withProperty: @selector(isEven:) withGenerators: gs2];

  NSMutableArray* gs3 = [NSMutableArray array];
  [gs3 addObject: ^() { return [ObjCheck genString]; }];

  // Are all strings reversible?
  [ObjCheck forAll: [Example class] withProperty: @selector(reversible:) withGenerators: gs3];

  [pool drain];

  return 0;
}
