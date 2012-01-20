//
//  PreferenceController.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "PreferenceController.h"

@implementation PreferenceController

@synthesize countdownValue; // Seconds before actions are taken, after connection is lost
@synthesize lockScreen;     // Lock screen?
@synthesize dimDisplay;     // Dim display?
@synthesize dimKeyboard;    // Dim keyboard?
@synthesize thresholdValue; // Minimum signal strength before taking actions
@synthesize signalStrength; // Current signal strength

- (id)init {
    self = [super initWithWindowNibName:@"Preference"];
    
#ifdef DEBUG
    NSLog(@"PreferenceController: init");
#endif
    
    return self;
}

- (id)initWithWindow:(NSWindow *)window
{
    self = [super initWithWindow:window];
    if (self) {
    }
    
    return self;
}

- (void)windowDidLoad
{
    [super windowDidLoad];
}

#pragma mark IBActions

// Called when the user wants to reset to defaults.
// Alert is invoked to asked him to confirm his actions.
- (IBAction)resetToDefaults:(id)sender {
    NSAlert *alert = [NSAlert alertWithMessageText:@"Are you sure you want to reset your preferences to the default values?"
                                     defaultButton:@"Yes"
                                   alternateButton:@"Cancel"
                                       otherButton:nil
                         informativeTextWithFormat:@""];
    
    [alert beginSheetModalForWindow:nil
                      modalDelegate:self
                     didEndSelector:@selector(alertEnded:code:context:)
                                              contextInfo:NULL];
    
}

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choise
           context:(void *)v {
    
    // If YES is returned, reset the preferences to defaults.
    if (choise == NSAlertDefaultReturn) {
        [self setDimDisplay:YES];
        [self setLockScreen:YES];
        [self setDimKeyboard:YES];
        [self setCountdownValue:30];
        [self setThresholdValue:50];
    }
}

@end
