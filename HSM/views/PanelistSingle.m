//
//  PanelistSingle.m
//  HSM
//
//  Created by Felipe Ricieri on 03/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "PanelistSingle.h"
#import "EventManager.h"

#define PADDING     30.0

@interface PanelistSingle ()
- (void) setFrames;
- (UITextView*) createTextView;
- (UILabel*) createLabelTitle;
- (NSString*) changeDateLabel:(NSString*) str;
- (NSString*) changeHourLabel:(NSString*) str;
- (void) disabledButton;
@end

@implementation PanelistSingle
{
    EventManager *manager;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}
- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self setFrames];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
    [self setTitle:[[self dictionary] objectForKey:KEY_NAME]];
    
    // info..
    manager     = [[EventManager alloc] initWithEvent:[self dictionary]];
    
    // ...
    tvDescription   = [self createTextView];
    tvTheme         = [self createTextView];
    labThemeTitle   = [self createLabelTitle];
    
    [labThemeTitle setText:[[self dictionary] objectForKey:@"theme_title"]];
    [labThemeTitle sizeToFit];
    
    // ...
    [labName setText:[[self dictionary] objectForKey:KEY_NAME]];
    [labSpeech setText:[[self dictionary] objectForKey:KEY_SPEECH]];
    [labDate setText:[self changeDateLabel:[[self dictionary] objectForKey:KEY_INFO_DATE]]];
    [labHour setText:[self changeHourLabel:[[self dictionary] objectForKey:KEY_INFO_HOUR]]];
    [tvDescription setText:[[self dictionary] objectForKey:KEY_DESCRIPTION]];
    [tvTheme setText:[[self dictionary] objectForKey:KEY_THEME]];
    
    [scr addSubview:v];
    [scr addSubview:tvDescription];
    [scr addSubview:labThemeTitle];
    [scr addSubview:tvTheme];
    [scr addSubview:butSchedule];
    
    [butSchedule setAlpha:0];
    
    // rect view
    //CGRect rectV = v.frame;
    //rectV.origin.y  = 64;
    //[v setFrame:rectV];
    
    NSString *strImg = [NSString stringWithFormat:@"p_%@_large.png", [[self dictionary] objectForKey:KEY_SLUG]];
    [imgPicture setImage:[UIImage imageNamed:strImg]];
    
    // ...
    NSDictionary *logs  = [tools propertyListRead:PLIST_LOGS];
    NSString *logKey    = [NSString stringWithFormat:@"%@_%@", KEY_EVENT_SCHEDULED, [[self dictionary] objectForKey:KEY_SLUG]];
    if ([[logs objectForKey:logKey] isEqualToString:KEY_YES])
    {
        [self disabledButton];
    }
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressSchedule:(id)sender
{
    [manager saveEKEventOnCalendar:[self dictionary]];
    // ...
    [tools dialogWithMessage:@"Esta palestra foi adicionada ao seu Calendário com sucesso."];
    [self disabledButton];
}

#pragma mark -
#pragma mark Private Methods

- (void)setFrames
{
    // rect description
    CGRect rect1        = tvDescription.frame;
    rect1.origin.y      = v.frame.size.height + (PADDING*0);
    rect1.size.height   = tvDescription.contentSize.height;
    [tvDescription setFrame:rect1];
    [tvDescription setEditable:NO];
    
    // rect title
    CGRect rect2        = labThemeTitle.frame;
    rect2.origin.y      = tvDescription.frame.size.height + tvDescription.frame.origin.y;
    rect2.size.height   = 100;
    [labThemeTitle setFrame:rect2];
    
    // rect theme
    CGRect rect3        = tvTheme.frame;
    rect3.origin.y      = labThemeTitle.frame.size.height + labThemeTitle.frame.origin.y;
    rect3.size.height   = tvTheme.contentSize.height;
    [tvTheme setFrame:rect3];
    [tvTheme setEditable:NO];
    
    // rect button
    CGRect rect4 = butSchedule.frame;
    rect4.origin.y      = tvTheme.frame.origin.y + tvTheme.frame.size.height + PADDING;
    rect4.origin.x      = (WINDOW_WIDTH/2) - (rect4.size.width/2);
    [butSchedule setFrame:rect4];
    
    [tvDescription setAlpha:1];
    [labThemeTitle setAlpha:1];
    [tvTheme setAlpha:1];
    [butSchedule setAlpha:1];
    
    [scr setContentSize:CGSizeMake(v.frame.size.width, butSchedule.frame.origin.y+butSchedule.frame.size.height + PADDING)];
}
- (UITextView*) createTextView
{
    UITextView *tv = [[UITextView alloc] initWithFrame:CGRectMake(10, 0, WINDOW_WIDTH-20, 350)];
    [tv setBackgroundColor:[UIColor clearColor]];
    [tv setTextColor:COLOR_DESCRIPTION];
    [tv setFont:[UIFont fontWithName:@"Helvetica" size:12.0]];
    [tv setAlpha:0];
    
    return tv;
}
- (UILabel *)createLabelTitle
{
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(10, 0, WINDOW_WIDTH-20, 170)];
    [lab setFont:[UIFont fontWithName:FONT_REGULAR size:14]];
    [lab setTextColor:COLOR_TITLE];
    [lab setAlpha:0];
    [lab setNumberOfLines:6];
    
    return lab;
}

- (NSString*) changeDateLabel:(NSString*) str
{
    //str = [str stringByReplacingOccurrencesOfString:@" de " withString:@""];
    //str = [str stringByReplacingOccurrencesOfString:@"novembro" withString:@"/11"];
    return str;
}
- (NSString*) changeHourLabel:(NSString*) str
{
    //str = [str stringByReplacingOccurrencesOfString:@" às " withString:@" "];
    return str;
}
- (void) disabledButton
{
    [butSchedule setEnabled:NO];
    [butSchedule setAlpha:0.5];
    [butSchedule setTitle:@"Agendado" forState:UIControlStateDisabled];
}

@end
