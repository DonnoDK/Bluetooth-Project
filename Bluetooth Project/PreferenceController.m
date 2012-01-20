//
//  PreferenceController.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

@synthesize countdownValue;
@synthesize lockScreen;
@synthesize dimDisplay;
@synthesize dimKeyboard;
@synthesize thresholdValue;
@synthesize signalStrength;

- (id)init {
    self = [super initWithWindowNibName:@"Preference"];
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
    
    // Implement this method to handle any initialization after your window controller's window has been loaded from its nib file.
}

@end
