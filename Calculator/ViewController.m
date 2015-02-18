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
@property (nonatomic, strong) NSDictionary *variableValue;
@end

@implementation ViewController

@synthesize display;
@synthesize topDisplay;
@synthesize userIsInTheMiddleOfEnteringANumber;
@synthesize hasPeriodBeenPressed;
@synthesize brain = _brain;

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation {
    return self.splitViewController ?
    YES : UIInterfaceOrientationIsPortrait(toInterfaceOrientation);
}

/*- (GraphViewController *)graphViewController {
   // TODO: declare the delegate protocol in viewcontroller.h to be able to use this functionality
    return self.popoverDelegate ?
    self.popoverDelegate :[self.splitViewController.viewControllers lastObject];
}*/

- (NSDictionary *)variableValues {
    
    
    // create a dictionary which holds the value of variable. Can be easily extended to keep more than one variable.
    
    return _variableValue;
}

-(void)updateView {
    
    // Find the result by running the program passing in the test variable values
    //id result = [CalculatorBrain runProgram:self.brain.program
                    //usingVariableValues:self.variableValue];
    
    // update display property based on the type of the result. If string, display as is. if number, convert to string format.
    
    // update the label with description of program
    
    
    
    // And the user isn't in the middle of entering a number
    //self.userInMiddleOfEnteringNumber = NO;
}

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
                self.topDisplay.text = [self.topDisplay.text stringByAppendingString:digit];
                self.hasPeriodBeenPressed = YES;
            }
        } else {
        
        self.topDisplay.text = [self.topDisplay.text stringByAppendingString:digit];
        self.display.text = [self.display.text stringByAppendingString:digit];
        }
    } else {
        if ([digit isEqualToString:@"."]) {
            self.display.text = digit;
            self.topDisplay.text = [self.topDisplay.text stringByAppendingString:digit];
            self.hasPeriodBeenPressed = YES;
            self.userIsInTheMiddleOfEnteringANumber = YES;
        } else {
            self.display.text = digit;
            self.topDisplay.text = [self.topDisplay.text stringByAppendingString:digit];
            self.userIsInTheMiddleOfEnteringANumber = YES;
        }
    }
    
}

- (IBAction)enterPressed {
    [self.brain pushOperand:[self.display.text doubleValue]];
    self.topDisplay.text = [self.topDisplay.text stringByAppendingString:@" "];
    self.userIsInTheMiddleOfEnteringANumber = NO;
    self.hasPeriodBeenPressed = NO;
}

- (IBAction)operationPressed:(id)sender {
    if (self.userIsInTheMiddleOfEnteringANumber) {
        [self enterPressed];
    }
    NSString *operation = [sender currentTitle];
    if ([operation isEqualToString:@"Clear"]){
        self.topDisplay.text = @" ";
    } else {
        self.topDisplay.text = [self.topDisplay.text stringByAppendingString:operation];
        self.topDisplay.text = [self.topDisplay.text stringByAppendingString:@" "];
        self.topDisplay.text = [self.topDisplay.text stringByAppendingString:@"="];
        self.topDisplay.text = [self.topDisplay.text stringByAppendingString:@" "];
    }
    
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
}

/*- (IBAction)variablePressed:(UIButton *)sender {
    
    // push variable and updateView
    
    [self.brain pushVariable:sender.currentTitle];
    [self updateView];
}*/

/*- (IBAction)drawGraphPressed {
    
    if ([self graphViewController]) {
        [[self graphViewController] setProgram:self.brain.program];
        [[self graphViewController] refreshView ];
    } else {
        [self performSegueWithIdentifier:@"DisplayGraphView" sender:self];
    }
}*/

//- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
//    [segue.destinationViewController setProgram:self.brain.program];
//}


- (void)viewDidAppear:(BOOL)animated {
    [self updateView];
}

- (void)viewDidUnload {
    [super viewDidUnload];
}


@end
