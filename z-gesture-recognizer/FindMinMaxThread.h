#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface FindMinMaxThread : NSThread
@property (nonatomic) NSUInteger min;
@property (nonatomic) NSUInteger max;
- (instancetype)initWithNumbers:(NSArray *) numbers;
@end

NS_ASSUME_NONNULL_END
