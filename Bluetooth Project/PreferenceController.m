//
//  PreferenceController.m
//  Bluetooth Project
//
//  Created by Pétur Egilsson on 1/20/12.
//  Copyright (c) 2012 Bluebird Apps. All rights reserved.
//

#import "PreferenceController.h"

// Default values
#define DEFAULT_COUNT_DOWN_VALUE    30
#define DEFAULT_LOCK_SCREEN         TRUE
#define DEFAULT_DIM_DISPLAY         TRUE
#define DEFAULT_DIM_KEYBOARD        TRUE
#define DEFAULT_THRESHOLD_VALUE     -5

// Holds the relevant keys in the .plist in ~/Library/Preferences/
NSString * const BBACountDownValueKey    = @"BBACountDownValue";
NSString * const BBALockScreenKey        = @"BBALockScreen";
NSString * const BBADimDisplayKey        = @"BBADimDisplay";
NSString * const BBADimKeyboardKey       = @"BBADimKeyboard";
NSString * const BBAThresholdValueKey    = @"BBAThresholdValue";

@implementation PreferenceController

@synthesize deviceSelector;
@synthesize isRunning;
@synthesize countdownValue; // Seconds before actions are taken, after connection is lost
@synthesize lockScreen;     // Lock screen?
@synthesize dimDisplay;     // Dim display?
@synthesize dimKeyboard;    // Dim keyboard?
@synthesize thresholdValue; // Minimum signal strength before taking actions
@synthesize signalStrength; // Current signal strength
@synthesize selectedDeviceName; // name of the currently selected device
@synthesize selectedDevice;
@synthesize pairedDevices;
@synthesize firstTimeLaunch;
@synthesize screenIsLocked;
@synthesize screenIsUnlocked;

#pragma mark Defaults
+ (void)initialize {
    
    // Create a dictionary to hold the default values
    NSMutableDictionary *defaultValues = [NSMutableDictionary dictionary];
    
    // Set the defaults into the directory
    [defaultValues setObject:[NSNumber numberWithUnsignedInt:DEFAULT_COUNT_DOWN_VALUE] forKey:BBACountDownValueKey];
    [defaultValues setObject:[NSNumber numberWithBool:DEFAULT_LOCK_SCREEN] forKey:BBALockScreenKey];
    [defaultValues setObject:[NSNumber numberWithBool:DEFAULT_DIM_DISPLAY] forKey:BBADimDisplayKey];
    [defaultValues setObject:[NSNumber numberWithBool:DEFAULT_DIM_KEYBOARD] forKey:BBADimKeyboardKey];
    [defaultValues setObject:[NSNumber numberWithUnsignedInt:DEFAULT_THRESHOLD_VALUE] forKey:BBAThresholdValueKey];
    
    // Register the defaults
    [[NSUserDefaults standardUserDefaults] registerDefaults:defaultValues];
    
#ifdef DEBUG
    NSLog(@"initialize: registered defaults: %@", defaultValues);
#endif
}

// Set and get defaults for count down value
+ (NSInteger)preferenceCountDownValue {
    return [[NSUserDefaults standardUserDefaults] integerForKey:BBACountDownValueKey];
}
+ (void)setPreferenceCountDownValue:(NSUInteger)value {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:BBACountDownValueKey];
}

// Set and get defaults for lock screen
+ (BOOL)preferenceLockScreen {
    return [[NSUserDefaults standardUserDefaults] boolForKey:BBALockScreenKey];
}
+ (void)setPreferenceLockScreen:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:BBALockScreenKey];
    
}

// Set and get defaults for dim display
+ (BOOL)preferenceDimDisplay {
    return [[NSUserDefaults standardUserDefaults] boolForKey:BBADimDisplayKey];
}
+ (void)setPreferenceDimDisplay:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:BBADimDisplayKey];
}

// Set and get defaults for dim keyboard
+ (BOOL)preferenceDimKeyboard {
    return [[NSUserDefaults standardUserDefaults] boolForKey:BBADimKeyboardKey];
}
+ (void)setPreferenceDimKeyboard:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:BBADimKeyboardKey];
}

// Set and get defaults for threshold value
+ (NSUInteger)preferenceThresholdValue {
    return [[NSUserDefaults standardUserDefaults] integerForKey:BBAThresholdValueKey];
}
+ (void)setPreferenceThresholdValue:(NSInteger)value {
    [[NSUserDefaults standardUserDefaults] setInteger:value forKey:BBAThresholdValueKey];
}


- (id)init {
    self = [super initWithWindowNibName:@"Preference"];
    if (self) {
        [self setSignalStrength:-20];
        
        NSNotificationCenter *nc = [NSNotificationCenter defaultCenter];
        [nc addObserver:self
               selector:@selector(refreshDeviceList:)
                   name:NSPopUpButtonCellWillPopUpNotification
                 object:nil];
        
        [nc addObserver:self selector:@selector(screenIsLocked:) name:@"com.apple.screenIsLocked" object:nil];
        
        [nc addObserver:self selector:@selector(screenIsUnlocked:) name:@"com.apple.screenIsUnlocked" object:nil];
        
        NSLog(@"Is screen locked? :%i", screenIsLocked);
        
        //shouldLock = YES; // assume yes
        //task = [[NSTask alloc] init];
          //[task setLaunchPath: @"/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"];
        counter = 0;
    }
    
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
    [self setCountdownValue:[PreferenceController preferenceCountDownValue]];
    [self setLockScreen:[PreferenceController preferenceLockScreen]];
    [self setDimDisplay:[PreferenceController preferenceDimDisplay]];
    [self setDimKeyboard:[PreferenceController preferenceDimKeyboard]];
    [self setThresholdValue:[PreferenceController preferenceThresholdValue]];
    [self setPairedDevices:[IOBluetoothDevice pairedDevices]];
    //conThread = [[NSThread alloc] initWithTarget:self selector:@selector(tryOpeningNewConnection) object:nil];
    [NSTimer scheduledTimerWithTimeInterval:1.5f target:self selector:@selector(updateIndicator) userInfo:nil repeats:YES];
}
-(void)updateIndicator{
    if (![task isRunning]) {
        NSLog(@"Is screen locked? :%i", screenIsLocked);
        if (counter < 4) {
            counter++;
        }
        if (selectedDevice && ![selectedDevice isConnected]) {
            NSLog(@"No connection - attempting to establish new connection");
            [self setSignalStrength:-20];
            if (![conThread isExecuting]) {
                conThread = [[NSThread alloc] initWithTarget:self selector:@selector(tryOpeningNewConnection) object:nil];
                [conThread start];
            }else{
                NSLog(@"Abort attempt - already attempting to establish connection");
            }
        }
        if (selectedDevice && [selectedDevice isConnected]){
            NSLog(@"Polling signal strength...");
            [self setSignalStrength:[selectedDevice RSSI]];
            if (([self signalStrength] < [self thresholdValue]) && counter == 4) {
                NSLog(@"Device out of range - locking");
                //[self lockdown];
                counter = 0;
                [self lockdown];
                NSLog(@"Is screen locked? :%i", screenIsLocked);
            }
        }
    }else{
        NSLog(@"Screensaver is running");
    }
}

                                                                              
-(void)tryOpeningNewConnection{
    NSLog(@"Establishing new connection");
    [selectedDevice openConnection];
    if ([selectedDevice isConnected]) {
        NSLog(@"Connection succeded!");
    }else{
        NSLog(@"Error - connection could not be established!");
    }
}

-(void)lockdown{
    task = [[NSTask alloc] init];
    //********* Using lock screen istead of screensaver is NOT good
    //********* because we are unable to register when the user has logged in again
    NSMutableArray *arguments = [NSArray arrayWithObject:@"-suspend"];
    [task setArguments: arguments];
    [task setLaunchPath: @"/System/Library/CoreServices/Menu Extras/User.menu/Contents/Resources/CGSession"];
    //********* Therefore using screen saver instead
    //[task setLaunchPath: @"/System/Library/Frameworks/ScreenSaver.framework/Versions/A/Resources/ScreenSaverEngine.app/Contents/MacOS/ScreenSaverEngine"];
        
    //[task setLaunchPath:@"/usr/bin/open"];
    //NSArray *arguments;
    //arguments = [NSArray arrayWithObject:@"/System/Library/Frameworks/ScreenSaver.framework/Resources/ScreenSaverEngine.app"];
    //[task setArguments:arguments];
    [task launch];
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
        [self setDimDisplay:DEFAULT_DIM_DISPLAY];
        [self setLockScreen:DEFAULT_LOCK_SCREEN];
        [self setDimKeyboard:DEFAULT_DIM_KEYBOARD];
        [self setCountdownValue:DEFAULT_COUNT_DOWN_VALUE];
        [self setThresholdValue:DEFAULT_THRESHOLD_VALUE];
    }
}

- (IBAction)help:(id)sender {
    NSAlert *help = [NSAlert alertWithMessageText:@"If BlueLock is unable to connect with your device, make sure that bluetooth is enable both on your device but also in MacOS X.\n\n If your device is not currently listed, you will need to pair it with your Mac.\nUse the Bluetooth setup assistant to do so."
                                    defaultButton:@"Open Bluetooth Assistant"
                                  alternateButton:@"Close"
                                      otherButton:nil
                        informativeTextWithFormat:@""];
    [help setIcon:[NSImage imageNamed:@"bluetoothIcon"]];
    
    [help beginSheetModalForWindow:[self window]
                     modalDelegate:self
                    didEndSelector:@selector(helpEnded:code:context:)
                       contextInfo:NULL];
}
- (void)helpEnded:(NSAlert *)alert
             code:(NSInteger)choise
          context:(void *)v {
    
    if (choise == NSAlertDefaultReturn) {
        NSTask *bttask;
        bttask = [[NSTask alloc] init];
        [bttask setLaunchPath: @"/System/Library/CoreServices/Bluetooth Setup Assistant.app/Contents/MacOS/Bluetooth Setup Assistant"];
        [bttask launch];
    }

    
}

-(IBAction)selectDevice:(id)sender{
    NSInteger sel = [sender indexOfSelectedItem];
    if (sel > -1) {
        [self setSelectedDevice:[pairedDevices objectAtIndex:sel]];
    }else{
        [self setSelectedDevice:nil];
    }
    
}
     
-(void)changeSelectedDevice{
    NSArray *device = [bluetoothSelectorController getResults];
    [self setSelectedDevice:[device objectAtIndex:0]];
    [self setSelectedDeviceName:[[device objectAtIndex:0] name]];
}

-(IBAction)addNewDevice:(id)sender{
    [[[IOBluetoothPairingController alloc] init] runModal];
    
}

#pragma mark Accessors

//overload
- (void)setCountdownValue:(NSUInteger)value {
    [PreferenceController setPreferenceCountDownValue:value];
    [self willChangeValueForKey:@"countdownValue"];
    countdownValue = value;
    [self didChangeValueForKey:@"countdownValue"];
}
//overload
- (void)setDimDisplay:(BOOL)value {
    [PreferenceController setPreferenceDimDisplay:value];
    [self willChangeValueForKey:@"dimDisplay"];
    dimDisplay = value;
    [self didChangeValueForKey:@"dimDisplay"];
}
//overload
- (void)setLockScreen:(BOOL)value {
    [PreferenceController setPreferenceLockScreen:value];
    [self willChangeValueForKey:@"lockScreen"];
    lockScreen = value;
    [self didChangeValueForKey:@"lockScreen"];
}
//overload
- (void)setDimKeyboard:(BOOL)value {
    [PreferenceController setPreferenceDimKeyboard:value];
    [self willChangeValueForKey:@"dimKeyboard"];
    dimKeyboard = value;
    [self didChangeValueForKey:@"dimKeyboard"];
}
//overload
- (void)setThresholdValue:(NSInteger)value {
    NSLog(@"Changing thresholdvalue");
    [PreferenceController setPreferenceThresholdValue:value];
    [self willChangeValueForKey:@"thresholdValue"];
    thresholdValue = value;
    [self didChangeValueForKey:@"thresholdValue"];
    NSLog(@"Changed to: %ld", value);
}
//overload
- (void)setSelectedDeviceName:(NSString *)value{
    [self willChangeValueForKey:@"selectedDeviceName"];
    selectedDeviceName = value;
    [self didChangeValueForKey:@"selectedDeviceName"];
}

- (void)setIsRunning:(BOOL)value{
    [self willChangeValueForKey:@"isRunning"];
    isRunning = value;
    [self didChangeValueForKey:@"isRunning"];
    
}
//
- (void)setSignalStrength:(NSInteger)value{
    [self willChangeValueForKey:@"signalStrength"];
    signalStrength = value;
    [self didChangeValueForKey:@"signalStrength"];
}
#pragma mark Delegates

- (void)windowWillClose:(NSNotification *)notification {
    NSLog(@"Window will close");
    [self setIsRunning:NO];
}

- (void)windowDidBecomeKey:(NSNotification *)notification{
    NSLog(@"Window did expose");
    [self setIsRunning:YES];
}

- (IBAction)refreshDeviceList:(id)sender {
    [self setPairedDevices:[IOBluetoothDevice pairedDevices]];
}

@end


