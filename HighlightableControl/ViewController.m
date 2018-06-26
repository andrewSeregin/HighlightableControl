//
//  ViewController.m
//  HighlightableControl
//
//  Created by Andrew Seregin on 26.06.2018.
//  Copyright © 2018 Andrew Seregin. All rights reserved.
//

#import "ViewController.h"
#import "HighlightableControl.h"

@interface ViewController ()

@property (strong, nonatomic) HighlightableControl *highlightableLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    UILabel *label = [UILabel new];
    label.text = @"Hello";
    label.textAlignment = NSTextAlignmentCenter;
    
    self.highlightableLabel = [[HighlightableControl alloc] initWithContent:label];
    self.highlightableLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.view addSubview:self.highlightableLabel];
    
    [NSLayoutConstraint activateConstraints:@[[self.highlightableLabel.heightAnchor constraintEqualToConstant:50],
                                              [self.highlightableLabel.widthAnchor constraintEqualToConstant:50],
                                              [self.highlightableLabel.centerXAnchor constraintEqualToAnchor:self.view.centerXAnchor],
                                              [self.highlightableLabel.centerYAnchor constraintEqualToAnchor:self.view.centerYAnchor]]];
    
}

@end
