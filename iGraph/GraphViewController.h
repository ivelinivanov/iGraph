//
//  GraphViewController.h
//  iGraph
//
//  Created by Ivelin Ivanov on 9/4/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CorePlot-CocoaTouch.h"

@interface GraphViewController : UIViewController <CPTPlotDataSource>

@property (copy, nonatomic) NSString *mathString;
@property (weak, nonatomic) IBOutlet CPTGraphHostingView *graphView;

- (IBAction)changeFormulaButtonPressed:(id)sender;
@end
