//
//  PreferenceController.h
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface PreferenceController : NSWindowController <NSWindowDelegate> 

@property NSUInteger countdownValue;
@property BOOL lockScreen;
@property BOOL dimDisplay;
@property BOOL dimKeyboard;
@property NSUInteger thresholdValue;
@property NSUInteger signalStrength;

- (IBAction)resetToDefaults:(id)sender;

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choise
           context:(void *)v;

@end
