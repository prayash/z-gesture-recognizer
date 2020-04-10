//
//  ZGestureRecognizer.m
//  z-gesture-recognizer
//
//  Created by Prayash Thapa on 1/22/20.
//  Copyright © 2020 Viget. All rights reserved.
//

#import "ZGestureRecognizer.h"
#import <UIKit/UIGestureRecognizerSubclass.h>

@interface ZGestureRecognizer ()

@property (nonatomic)NSUInteger strokePrecision;

/// The stroke is comprised of 3 different sections, so we'll use this int to keep track of it
@property (nonatomic)NSUInteger strokePart;

@property (nonatomic)CGPoint firstTap;

@end

@implementation ZGestureRecognizer

- (id)initWithTarget:(id)target action:(SEL)action {
    if ((self = [super initWithTarget:target action:action])) {

    }

    return self;
}

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [super touchesBegan:touches withEvent:event];
    self.strokePrecision = 10.0;

    if (touches.count > 1) {
        self.state = UIGestureRecognizerStateFailed;
        return;
    }

    self.firstTap = [touches.anyObject locationInView:  self.view.superview];
}

-(void)touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesMoved:touches withEvent:event];
    if ((self.state == UIGestureRecognizerStateFailed) || (self.state == UIGestureRecognizerStateRecognized)) {
        return;
    }

    UIView *superView = [self.view superview];
    CGPoint currentPoint = [touches.anyObject locationInView:superView];
    CGPoint previousPoint = [touches.anyObject previousLocationInView:superView];

    if ((self.strokePart == 0) && ((currentPoint.x - self.firstTap.x) > 20.00) && (currentPoint.x > previousPoint.x) && ((currentPoint.y - self.firstTap.y) <= self.strokePrecision)) {
        NSLog(@"Stroke part 1 complete");
        self.strokePart = 1;
    } else if ((self.strokePart == 1) && (currentPoint.x < previousPoint.x) && (currentPoint.y > previousPoint.y)) {
        NSLog(@"Stroke part 2 complete");
        self.strokePart = 2;
    } else if ((self.strokePart == 2) && (currentPoint.x > previousPoint.x) && ((currentPoint.y - previousPoint.y) <= self.strokePrecision)) {
        self.strokePart = 3;
        self.state = UIGestureRecognizerStateRecognized;
        NSLog(@"Gesture Recognized!");
    }
}

-(void)touchesEnded:(NSSet *)touches withEvent:(UIEvent *)event {
    [super touchesEnded:touches withEvent:event];
    [self reset];
}

-(void)touchesCancelled:(NSSet *)touches withEvent:(UIEvent *)event {
    self.state = UIGestureRecognizerStateCancelled;
    [self reset];
}

- (void)reset {
    [super reset];

    // Reset the stroke to 0
    self.strokePart = 0;
}

@end
