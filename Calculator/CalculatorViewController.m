//
//  CalculatorViewController.m
//  Calculator
//
//  Created by xue on 13-2-3.
//
//

#import "CalculatorViewController.h"
#import "CalculatorBrain.h"

@interface CalculatorViewController ()
@property (nonatomic) BOOL userInTheMiddleOfEnteringNumber;
@property (nonatomic, strong) CalculatorBrain *brain;
@end

@implementation CalculatorViewController

@synthesize display;
@synthesize userInTheMiddleOfEnteringNumber;
@synthesize brain = _brain;

-(CalculatorBrain *) brain{
    if (!_brain) {
        _brain = [[CalculatorBrain alloc] init];
    }
    return _brain;
}

- (void) pressRecord:(NSString *) text {
    if([self.pressedDisplay.text length] != 0){        
        if ([self.pressedDisplay.text hasSuffix:@"="]) {
            self.pressedDisplay.text = [self.pressedDisplay.text substringToIndex:self.pressedDisplay.text.length - 1];
        } else {
            self.pressedDisplay.text = [self.pressedDisplay.text stringByAppendingString:@" "];
        }
    }
    self.pressedDisplay.text = [self.pressedDisplay.text stringByAppendingString:text];
}

- (IBAction)digitPressed:(UIButton *)sender {
    
    if(self.userInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
    } else {
        self.display.text = [sender currentTitle];
        self.userInTheMiddleOfEnteringNumber = YES;
    }
}

- (IBAction)enterPressed{
    if ([self.display.text isEqualToString:@"π"]) {
        [self.brain pushOperand:self.brain.PI];
    } else {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    self.userInTheMiddleOfEnteringNumber = NO;
    [self pressRecord:self.display.text];
}

- (IBAction)operationPressed:(id)sender {
    if (self.userInTheMiddleOfEnteringNumber) {
        [self enterPressed];
    }
    
    NSString *operation = [sender currentTitle];
    double result = [self.brain performOperation:operation];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    [self pressRecord:operation];
    [self pressRecord:@"="];
}

- (IBAction)cleanPressed:(id)sender {
    [self.brain cleanOperand];
    self.display.text = @"0";
    self.userInTheMiddleOfEnteringNumber = NO;
    self.pressedDisplay.text = @"";
}

- (IBAction)backspacePressed:(id)sender {
    
    if(self.userInTheMiddleOfEnteringNumber) {
        self.display.text = [self.display.text substringToIndex:self.display.text.length - 1];
    }
    if ([self.display.text isEqualToString:@""]) {
        self.display.text = @"0";
        self.userInTheMiddleOfEnteringNumber = NO;
    }
}

- (IBAction)plusMinusPressed:(UIButton *)sender {
    [self.brain pushOperand:[self.display.text doubleValue]];
    double result = [self.brain changeSign];
    self.display.text = [NSString stringWithFormat:@"%g", result];
    if (!userInTheMiddleOfEnteringNumber) {
        [self.brain pushOperand:[self.display.text doubleValue]];
    }
    [self pressRecord:sender.currentTitle];
}

- (IBAction)dotPressed:(id)sender {
    if ([self.display.text rangeOfString:@"."].location == NSNotFound) {
        if(self.userInTheMiddleOfEnteringNumber) {
            self.display.text = [self.display.text stringByAppendingString:[sender currentTitle]];
        } else {
            self.display.text = [sender currentTitle];
            self.userInTheMiddleOfEnteringNumber = YES;
        }
    }
}

- (IBAction)piPressed:(id)sender {
    if(self.userInTheMiddleOfEnteringNumber) {
        [self enterPressed];
    }
    
    self.display.text = @"π";
    [self enterPressed];
}


@end
