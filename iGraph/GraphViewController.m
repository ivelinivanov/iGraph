//
//  GraphViewController.m
//  iGraph
//
//  Created by Ivelin Ivanov on 9/4/13.
//  Copyright (c) 2013 MentorMate. All rights reserved.
//

#import "GraphViewController.h"
#import "DDMathEvaluator.h"

@interface GraphViewController ()
{
    float checkValueX;
    float checkValueY;
}

@end

@implementation GraphViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    checkValueX = -4.0f;
    checkValueY = -4.0f;
    
	// Create a CPTGraph object and add to hostView
    CPTGraph* graph = [[CPTXYGraph alloc] initWithFrame:self.graphView.bounds];
    self.graphView.hostedGraph = graph;
    
    // Get the (default) plotspace from the graph so we can set its x/y ranges
    CPTXYPlotSpace *plotSpace = (CPTXYPlotSpace *) graph.defaultPlotSpace;
    
    // Note that these CPTPlotRange are defined by START and LENGTH (not START and END) !!
    [plotSpace setYRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -8 ) length:CPTDecimalFromFloat( 16 )]];
    [plotSpace setXRange: [CPTPlotRange plotRangeWithLocation:CPTDecimalFromFloat( -4 ) length:CPTDecimalFromFloat( 8 )]];
    
    // Create the plot (we do not define actual x/y values yet, these will be supplied by the datasource...)
    CPTScatterPlot* plot = [[CPTScatterPlot alloc] initWithFrame:CGRectZero];
    
    // Let's keep it simple and let this class act as datasource (therefore we implemtn <CPTPlotDataSource>)
    plot.dataSource = self;
    
    // Finally, add the created plot to the default plot space of the CPTGraph object we created before
    [graph addPlot:plot toPlotSpace:graph.defaultPlotSpace];
}

-(void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];
    
    checkValueX = -4.0f;
    checkValueY = -4.0f;
}

- (IBAction)changeFormulaButtonPressed:(id)sender
{
    [self dismissViewControllerAnimated:YES completion:nil];
}

#pragma mark - Plot Data Source

-(NSUInteger)numberOfRecordsForPlot:(CPTPlot *)plotnumberOfRecords
{
    return 81;
}


-(NSNumber *)numberForPlot:(CPTPlot *)plot field:(NSUInteger)fieldEnum recordIndex:(NSUInteger)index
{

    
    // This method is actually called twice per point in the plot, one for the X and one for the Y value
    if(fieldEnum == CPTScatterPlotFieldX)
    {
        // Return x value, which will, depending on index, be between -4 to 4
        return [NSNumber numberWithFloat: checkValueX += 0.1];
    } else {
        // Return y value, for this example we'll be plotting y = x * x
        NSDictionary *variableSubstitutions = [NSDictionary dictionaryWithObject:[NSNumber numberWithFloat:checkValueY += 0.1] forKey:@"x"];
        
        return [[DDMathEvaluator sharedMathEvaluator] evaluateString:self.mathString withSubstitutions:variableSubstitutions];
    }
}

@end
