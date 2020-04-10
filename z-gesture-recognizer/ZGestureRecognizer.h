//
//  ZGestureRecognizer.h
//  z-gesture-recognizer
//
//  Created by Prayash Thapa on 1/22/20.
//  Copyright © 2020 Viget. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ZGestureRecognizer : UIGestureRecognizer

- (id)initWithTarget:(nullable id)target action:(nullable SEL)action;

@end

NS_ASSUME_NONNULL_END
