//
//  ViewController.m
//  iGraph
//
//  Created by Ivelin Ivanov on 9/4/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "EquationViewController.h"
#import "GraphViewController.h"

@interface EquationViewController ()

@end

@implementation EquationViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}


-(void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    NSString *rawString = [self.textField.text stringByReplacingOccurrencesOfString:@"x" withString:@"$x"];
    NSString *mathString = [rawString stringByReplacingOccurrencesOfString:@"^" withString:@"**"];
    
    GraphViewController *destination = (GraphViewController *)segue.destinationViewController;
    destination.mathString = mathString;
}

#pragma mark - Keyboard dismissing

- (void)touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event
{
    [self.view endEditing:YES];
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}

@end
