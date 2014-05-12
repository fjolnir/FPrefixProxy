#include "FPrefixProxy.h"
#import <objc/runtime.h>
#import <objc/message.h>

@implementation FPrefixProxy
+ (instancetype)proxyForObject:(id)aObj withPrefix:(NSString *)aPrefix
{
    FPrefixProxy * const proxy = [self alloc];
    proxy.destinationObject = aObj;
    proxy.selectorPrefix    = aPrefix;
    return proxy;
}
- (SEL)_cy_prepareSelector:(SEL)aSelector
{
    if(![NSObject instancesRespondToSelector:aSelector])
        aSelector = NSSelectorFromString([_selectorPrefix stringByAppendingString:NSStringFromSelector(aSelector)]);
    return aSelector;
}
- (void)forwardInvocation:(NSInvocation *)anInvocation
{
    [anInvocation setTarget:_destinationObject];
    [anInvocation setSelector:[self _cy_prepareSelector:anInvocation.selector]];
    [anInvocation invoke];
}
- (NSMethodSignature *)methodSignatureForSelector:(SEL)aSelector
{
    return [_destinationObject methodSignatureForSelector:[self _cy_prepareSelector:aSelector]];
}
@end
