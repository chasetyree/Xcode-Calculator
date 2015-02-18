//
//  CalculatorBrain.m
//  Calculator
//
//  Created by Taylor Chase Tyree on 1/16/15.
//  Copyright (c) 2015 edu.mines.csci448.ttyree. All rights reserved.
//

#import "CalculatorBrain.h"

@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
//@property (nonatomic, strong) NSMutableArray *programStack;
@end


@implementation CalculatorBrain
//@synthesize programStack = _programStack;
@synthesize operandStack = _operandStack;

- (NSMutableArray *)operandStack {
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    return _operandStack;
}

/*- (NSMutableArray *)programStack {
    if (_programStack == nil) _programStack = [[NSMutableArray alloc] init];
    return _programStack;
}*/

+ (NSString *)descriptionOfProgram:(id)program {
    
    
    // TODO: write however you would like to display the sequence of operands, variables, operations on stack
    
    return @"What?";
}


- (double)popOperand {
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) [self.operandStack removeLastObject];
    return [operandObject doubleValue];
}



+ (id)popOperandOffProgramStack:(NSMutableArray *) stack {
    
    double result = 0;
    
    id topOfStack = [stack lastObject];
    if (topOfStack) [stack removeLastObject]; else return @"0";
    
    if ([topOfStack isKindOfClass:[NSNumber class]]) return topOfStack;
    
    NSString *operation = topOfStack;
    
    if ([operation isEqualToString:@"π"]) {
        result = M_PI;
    }
    // TODO: similarly, handle all other operations, including sin, cos, +, -, etc. (hint: see how many operands each operator needs).
    if ([operation isEqualToString:@"+"]) {
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        double op2 = [[self popOperandOffProgramStack:stack] doubleValue];
        result = op1 + op2;
        //result = [self popOperandOffProgramStack:stack]] + [self popOperandOffProgramStack:stack];
    } else if ([@"*" isEqualToString:operation]) {
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        double op2 = [[self popOperandOffProgramStack:stack] doubleValue];
        result = op1 * op2;
        //result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        //double subtrahend = [self popOperand];
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        double op2 = [[self popOperandOffProgramStack:stack] doubleValue];
        result = op2 - op1;
        //result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        //double divisor = [self popOperand];
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        double op2 = [[self popOperandOffProgramStack:stack] doubleValue];
        //result = op1 + op2;
        if (op1) result = op2 / op1;
    } else if ([operation isEqualToString:@"Sin"]) {
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        //result = sin([self popOperand]);
        result = sin(op1);
    } else if ([operation isEqualToString:@"Cos"]) {
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        result = cos(op1);
        //result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"Sqrt"]) {
        double op1 = [[self popOperandOffProgramStack:stack] doubleValue];
        result = sqrt(op1);
    } else if ([operation isEqualToString:@"Clear"]) {
        //_operandStack = [[NSMutableArray alloc] init];
    }
    
    return [NSNumber numberWithDouble:result];
}

- (void)pushOperand:(double)operand {
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];

    [self.operandStack addObject:operandObject];
    
}


/*- (void)pushOperation:(NSString *) operation {
    [self.operandStack addObject:operation];
}*/

+ (id)runProgram:(id)program {
    // Call the new runProgram method with a nil dictionary
    return [self runProgram:program usingVariableValues:nil];
}

+ (BOOL)isOperation:(NSString *)operation {
    
    //TODO: Check to see if it's a valid operation.
    
    return YES;
}

+ (id)runProgram:(id)program
usingVariableValues:(NSDictionary *)variableValues {
    
    
    NSMutableArray *stack= [program mutableCopy];
    
    // For each item in the program
    for (int i=0; i < [stack count]; i++) {
        id obj = [stack objectAtIndex:i];
        
        // See whether we think the item is a variable
        if ([obj isKindOfClass:[NSString class]] && ![self isOperation:obj]) {
            id value = [variableValues objectForKey:obj];
            // If value is not an instance of NSNumber, set it to zero
            if (![value isKindOfClass:[NSNumber class]]) {
                value = [NSNumber numberWithInt:0];
            }
            // Replace program variable with value.
            [stack replaceObjectAtIndex:i withObject:value];
        }		
    }	
    // Starting popping off the stack
    return [self popOperandOffProgramStack:stack];
    //return [self id];
}


- (double)performOperation:(NSString *)operation {
    double result = 0.0;
 
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([@"*" isEqualToString:operation]) {
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]) {
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString:@"/"]) {
        double divisor = [self popOperand];
        if (divisor) result = [self popOperand] / divisor;
    } else if ([operation isEqualToString:@"Sin"]) {
        result = sin([self popOperand]);
    } else if ([operation isEqualToString:@"Cos"]) {
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"Sqrt"]) {
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"Clear"]) {
        _operandStack = [[NSMutableArray alloc] init];
    } else if ([operation isEqualToString:@"π"]) {
        result = M_PI;
        
    }
    
    [self pushOperand:result];
    
    return result;
}

@end
