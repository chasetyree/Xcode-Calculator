//
//  CalculatorBrain.h
//  Calculator
//
//  Created by Taylor Chase Tyree on 1/16/15.
//  Copyright (c) 2015 edu.mines.csci448.ttyree. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

- (void)pushOperand:(double)operand;
- (double)performOperation:(NSString *)operation;

@end
