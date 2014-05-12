#import <Foundation/Foundation.h>

@interface FPrefixProxy : NSProxy
@property(retain) NSString *selectorPrefix;
@property(retain) id destinationObject;
@end
