//
//  CalculatorBrain.m
//  Calculator
//
//  Created by xue on 13-2-3.
//
//

#import "CalculatorBrain.h"
#import <math.h>
@interface CalculatorBrain()
@property (nonatomic, strong) NSMutableArray *operandStack;
@end

@implementation CalculatorBrain

@synthesize operandStack = _operandStack;
@synthesize PI = _PI;

- (double) PI {
    if(_PI == 0) _PI = M_PI;
    return _PI;
}

- (NSMutableArray *)  operandStack{
    if (!_operandStack) {
        _operandStack = [[NSMutableArray alloc] init];
    }
    
    return _operandStack;
}

- (double) popOperand{
    NSNumber *operandObject = [self.operandStack lastObject];
    if (operandObject) {
        [self.operandStack removeLastObject];
    }
    return [operandObject doubleValue];
}

- (void)pushOperand:(double)operand{
    NSNumber *operandObject = [NSNumber numberWithDouble:operand];
    [self.operandStack addObject:operandObject];
}

-(double) performOperation:(NSString *)operation{
    double result = 0;
    if ([operation isEqualToString:@"+"]) {
        result = [self popOperand] + [self popOperand];
    } else if ([operation isEqualToString:@"*"]){
        result = [self popOperand] * [self popOperand];
    } else if ([operation isEqualToString:@"-"]){
        double subtrahend = [self popOperand];
        result = [self popOperand] - subtrahend;
    } else if ([operation isEqualToString: @"/"]){
        double divide = [self popOperand];
        if (divide == 0) {
            result = 0;
        } else {
            result = [self popOperand] / divide;
        }
    } else if ([operation isEqualToString:@"sin"]){
        result = sin([self popOperand]);
    } else if([operation isEqualToString:@"cos"]){
        result = cos([self popOperand]);
    } else if ([operation isEqualToString:@"sqrt"]){
        result = sqrt([self popOperand]);
    } else if ([operation isEqualToString:@"log"]){
        result = log10([self popOperand]);
    } else if ([operation isEqualToString:@"e"]){
        result = exp([self popOperand]);
    }
    [self pushOperand:result];
    return result;
}

- (void) cleanOperand{
    [self.operandStack removeAllObjects];
}

- (double) changeSign {
    double result = -[self popOperand];
    return result;
}

@end
