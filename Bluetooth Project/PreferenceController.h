//
//  PreferenceController.h
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BBACountDownValueKey;
extern NSString * const BBALockScreenKey;
extern NSString * const BBADimDisplayKey;
extern NSString * const BBADimKeyboardKey;
extern NSString * const BBAThresholdValueKey;

@interface PreferenceController : NSWindowController <NSWindowDelegate> 

@property (nonatomic) NSUInteger countdownValue;
@property BOOL lockScreen;
@property (nonatomic) BOOL dimDisplay;
@property BOOL dimKeyboard;
@property NSUInteger thresholdValue;
@property NSUInteger signalStrength; // Not stored as a default

+ (NSUInteger)preferenceCountDownValue;
+ (void)setPreferenceCountDownValue:(NSUInteger)value;

+ (BOOL)preferenceLockScreen;
+ (void)setPreferenceLockScreen:(BOOL)value;

+ (BOOL)preferenceDimDisplay;
+ (void)setPreferenceDimDisplay:(BOOL)value;

+ (BOOL)preferenceDimKeyboard;
+ (void)setPreferenceDimKeyboard:(BOOL)value;

+ (NSUInteger)preferenceThresholdValue;
+ (void)setPreferenceThresholdValue:(NSUInteger)value;

- (IBAction)resetToDefaults:(id)sender;

- (void)alertEnded:(NSAlert *)alert
              code:(NSInteger)choise
           context:(void *)v;


@end
