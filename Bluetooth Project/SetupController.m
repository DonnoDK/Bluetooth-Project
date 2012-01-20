//
//  SetupController.m
//  Bluetooth Project
//
//  Created by Brian Pedersen on 1/20/12.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "SetupController.h"

@implementation SetupController

-(id)init{
    self = [super initWithWindowNibName:@"Setup"];
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
