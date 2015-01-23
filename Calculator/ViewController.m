//
//  ViewController.m
//  Calculator
//
//  Created by Taylor Chase Tyree on 1/15/15.
//  Copyright (c) 2015 edu.mines.csci448.ttyree. All rights reserved.
//

#import "ViewController.h"
#import "CalculatorBrain.h"

@interface ViewController()
@property (nonatomic) BOOL userIsInTheMiddleOfEnteringANumber;
@property (nonatomic) BOOL hasPeriodBeenPressed;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation ViewController

@synthesize display;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize hasPeriodBeenPressed;
@synthesize brain = _brain;

- (CalculatorBrain *)brain {
    if (!_brain) _brain = [[CalculatorBrain alloc] init];
    return _brain;
}

- (IBAction)digitPressed:(UIButton *)sender {
    NSString *digit = [sender currentTitle];
    if (self.userIsInTheMiddleOfEnteringANumber) {
        if ([digit isEqualToString:@"."]) {
            if (self.hasPeriodBeenPressed == YES){

            } else {
                self.display.text = [self.display.text stringByAppendingString:digit];
                self.hasPeriodBeenPressed = YES;
            }
        } else {
        
        self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
        if ([digit isEqualToString:@"."]) {
            self.display.text = digit;
            self.hasPeriodBeenPressed = YES;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        } else {
            self.display.text = digit;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.hasPeriodBeenPressed = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

@end
