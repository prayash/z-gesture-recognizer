#import "ViewController.h"
#import "ZGestureRecognizer.h"
#import "FindMinMaxThread.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self.view addGestureRecognizer:[[ZGestureRecognizer alloc] initWithTarget:self action:@selector(handleGesture:)]];

    NSMutableArray *numbers = [NSMutableArray array];
    for (int i = 0; i < 100000; i++) {
        [numbers addObject:[NSNumber numberWithInt:arc4random()]];
    }

    NSMutableSet *threads = [NSMutableSet set];
    NSUInteger numberCount = numbers.count;
    NSUInteger threadCount = 4;

    for (NSUInteger i = 0; i < threadCount; i++) {
        NSUInteger offset = (numberCount / threadCount) * i;
        NSUInteger count = MIN(numberCount - offset, numberCount / threadCount);
        NSRange range = NSMakeRange(offset, count);
        NSArray *subset = [numbers subarrayWithRange:range];
        FindMinMaxThread *thread = [[FindMinMaxThread alloc] initWithNumbers:subset];

        [threads addObject:thread];
        [thread start];
    }
}

- (void)handleGesture:(ZGestureRecognizer *)recognizer {
    NSLog(@"Z!");
}


@end
