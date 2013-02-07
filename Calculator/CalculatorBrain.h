//
//  CalculatorBrain.h
//  Calculator
//
//  Created by xue on 13-2-3.
//
//

#import <Foundation/Foundation.h>

@interface CalculatorBrain : NSObject

@property (nonatomic) double PI;

- (void) pushOperand:(double) operand;
- (double) performOperation:(NSString *)operation;
- (void) cleanOperand;
- (double) changeSign;





@end
