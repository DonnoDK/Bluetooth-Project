//
//  popUpButton.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/25/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "popUpButton.h"

@implementation popUpButton

- (id)initWithFrame:(NSRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code here.
    }
    
    return self;
}

- (void)drawRect:(NSRect)dirtyRect
{
    // Drawing code here.
}

- (void)mouseDown:(NSEvent *)theEvent {
    NSLog(@"hello");
}

@end
