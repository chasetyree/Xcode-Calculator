//
//  AxesDrawer.h
//  Calculator
//
//  Created by Taylor Chase Tyree on 2/13/15.
//  Copyright (c) 2015 edu.mines.csci448.ttyree. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AxesDrawer : NSObject

+ (void)drawAxesInRect:(CGRect)bounds
         originAtPoint:(CGPoint)axisOrigin
                 scale:(CGFloat)pointsPerUnit;

@end
