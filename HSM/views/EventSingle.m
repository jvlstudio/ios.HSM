//
//  EventSingle.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "EventSingle.h"
#import "EventMultiple.h"
#import "EventEmpty.h"
#import "EventMiddle.h"

#import "EventManager.h"

#import "Agenda.h"
#import "Panelist.h"
#import "Passes.h"

#define PADDING_BOTTOM  20
#define DELAY_ANIMATION 0.4f

#define V_HEIGHT        411
#define ELASTIC_HEIGHT  0
#define DATES_HEIGHT    209
#define BOTTOM_Y        V_HEIGHT
#define NEGATIVE_INDEX  190

typedef enum EventInfoType : NSInteger
{
    kTypeNone   = 0,
    kTypeDates  = 1,
    kTypeInfo   = 2
}
EventInfoType;

@interface EventSingle ()
- (void) configurate;
- (void) updateRootScrollFrame;
- (void) eventExpandForType:(EventInfoType) type;
- (void) eventRetrive;
/**/
- (BOOL) isMostra;
@end

@implementation EventSingle
{
    EventInfoType contentOpen;
    EventManager *manager;
}

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setTitle:[[self dictionary] objectForKey:KEY_NAME]];
    
    manager = [[EventManager alloc] initWithEvent:[self dictionary]];
    
    [labTinyDescription setText:[[self dictionary] objectForKey:KEY_TINY_DESCRIPTION]];
    [labTinyDescription alignBottom];
    
    // ..
    contentOpen = kTypeNone;
    [self configurate];
    
    // ad..
    Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    [ad correctRectOfView:scr];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressAgenda:(id)sender
{
    Agenda *vc = [[Agenda alloc] initWithNibName:NIB_AGENDA andDictionary:[manager event]];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressPanelist:(id)sender
{
    Panelist *vc = [[Panelist alloc] initWithNibName:NIB_PANELIST andArray:[manager panelists]];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressPasses:(id)sender
{
    if ([[[self dictionary] objectForKey:KEY_SHOW_PASSES] isEqualToString:KEY_YES])
    {
        Passes *vc = [[Passes alloc] initWithNibName:NIB_PASSES andDictionary:[manager passes]];
        [[self navigationController] pushViewController:vc animated:YES];
    }
    else {
        EventEmpty *vc = [[EventEmpty alloc] initWithNibName:NIB_EVENT_EMPTY andDictionary:[self dictionary]];
        [vc setTitle:@"Mais informações"];
        [[self navigationController] pushViewController:vc animated:YES];
    }
}
- (IBAction) pressRooms:(id)sender
{
    EventMiddle *vc     = [[EventMiddle alloc] initWithNibName:@"EventMiddle" bundle:nil];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressCicle:(id)sender
{
    NSArray *content  = [[self dictionary] objectForKey:@"agenda"];
    EventMultiple *vc = [[EventMultiple alloc] initWithNibName:NIB_EVENT_MULTIPLE andArray:content];
    [vc setTitle:@"Ciclo de Palestras"];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressGrade:(id)sender
{
    NSString *strURL = @"http://agenda.expositoronline.com.br/?eventid=8";
    NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction) pressPassRed:(id)sender
{
    NSString *strURL = @"http://www.expositoronline.com.br/Collaboration/Mailling/Registration.aspx?ca=1338&fe=73&pr=127&co=2";
    NSURL *url = [ [ NSURL alloc ] initWithString: strURL ];
    [[UIApplication sharedApplication] openURL:url];
}
- (IBAction) pressContent:(id)sender
{
    if(contentOpen == kTypeInfo)
    {
        [self eventRetrive];
        [butContent setAlpha:0.3];
        return;
    }
    
    [self eventExpandForType:kTypeInfo];
    [butContent setAlpha:1];
    [butDates setAlpha:0.3];
}
- (IBAction) pressDates:(id)sender
{
    if(contentOpen == kTypeDates)
    {
        [self eventRetrive];
        [butDates setAlpha:0.3];
        return;
    }
    
    [self eventExpandForType:kTypeDates];
    [butDates setAlpha:1];
    [butContent setAlpha:0.3];
}

#pragma mark -
#pragma mark Methods

- (void) configurate
{
    if (![[[self dictionary] objectForKey:KEY_SHOW_PASSES] isEqualToString:KEY_YES])
    {
        [butPasses setTitle:@"Mais informações" forState:UIControlStateNormal];
        // hack
        [butPanelist setEnabled:NO];
        [butPanelist setAlpha:0.5];
    }
    
    NSString *strImg    = [NSString stringWithFormat:@"hsm_events_%@.png", [[self dictionary] objectForKey:KEY_SLUG]];
    [imgCover setImage:[UIImage imageNamed:strImg]];
    
    NSDictionary *dictColor = [[self dictionary] objectForKey:KEY_COLOR];
    [elasticView setBackgroundColor:[UIColor colorWithRed:[[dictColor objectForKey:KEY_COLOR_RED] floatValue]/255.0
                                                    green:[[dictColor objectForKey:KEY_COLOR_GREEN] floatValue]/255.0
                                                     blue:[[dictColor objectForKey:KEY_COLOR_BLUE] floatValue]/255.0 alpha:1]];
    
    NSArray *arrPan     = [[self dictionary] objectForKey:@"panelists"];
    if ([arrPan count] < 1)
    {
        //[butPanelist setEnabled:NO];
        //[butPanelist setAlpha:0.5];
    }
    
    // ...
    if ([self isMostra])
    {
        CGRect rect       = bottom2View.frame;
        rect.origin.y     = v.frame.size.height+v.frame.origin.y-NEGATIVE_INDEX;
        [bottom2View setFrame:rect];
        
        CGRect cframe = v.frame;
        cframe.origin.y -= NEGATIVE_INDEX;
        [v setFrame:cframe];
        
        [scr addSubview:bottom2View];
    }
    else {
        CGRect rect1        = bottomView.frame;
        rect1.origin.y      = v.frame.size.height+v.frame.origin.y;
        [bottomView setFrame:rect1];
        
        [scr addSubview:bottomView];
    }
    
    // ..
    CGRect rect2        = elasticView.frame;
    rect2.size.height   = 1;
    rect2.origin.y      = v.frame.size.height+v.frame.origin.y-5;
    if ([self isMostra])
        rect2.origin.y  += NEGATIVE_INDEX;
    [elasticView setFrame:rect2];
    
    // ..
    CGRect rect3        = tvDescription.frame;
    rect3.origin.x      = 10;
    rect3.origin.y      = 10;
    rect3.size.width    = elasticView.frame.size.width-20;
    rect3.size.height   = 0;
    [tvDescription setFrame:rect3];
    [tvDescription setAlpha:0];
    
    // ..
    CGRect rect4        = datesView.frame;
    rect4.origin.x      = 10;
    rect4.origin.y      = 10;
    rect4.size.width    = elasticView.frame.size.width-20;
    rect4.size.height   = 0;
    [datesView setFrame:rect4];
    [datesView setAlpha:0];
    
    // ..
    [tvDescription setText:[[self dictionary] objectForKey:KEY_DESCRIPTION]];
    [labDates setText:[[self dictionary] objectForKey:KEY_DATES]];
    [labHours setText:[[self dictionary] objectForKey:KEY_HOURS]];
    [labLocal setText:[[self dictionary] objectForKey:KEY_LOCAL]];
    
    [labDates setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    [labHours setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    [labLocal setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    
    [elasticView addSubview:tvDescription];
    [elasticView addSubview:datesView];
    
    // ..
    [self updateRootScrollFrame];
    [scr addSubview:v];
}
- (void)updateRootScrollFrame
{
    float bottomHeight = 0;
    if ([self isMostra])
        bottomHeight = bottom2View.frame.size.height - NEGATIVE_INDEX;
    else
        bottomHeight = bottomView.frame.size.height;
    
    [scr setContentSize:CGSizeMake(v.frame.size.width, v.frame.size.height+bottomHeight)];
}
- (void) eventExpandForType:(EventInfoType)type
{
    // always start from the all original points.
    NSInteger height = 0;
    
    // ..
    switch (type)
    {
        case kTypeNone:
            // ...
            break;
            
        case kTypeDates:
        {
            height = DATES_HEIGHT;
            [UIView animateWithDuration:DELAY_ANIMATION animations:^{
                // ...
                CGRect rect1        = elasticView.frame;
                rect1.size.height   = height + PADDING_BOTTOM;
                //if ([[[self dictionary] objectForKey:KEY_SLUG] isEqualToString:@"mostra13"])
                    //rect1.origin.y  += NEGATIVE_INDEX;
                [elasticView setFrame:rect1];
                
                // ..
                CGRect rect2        = bottomView.frame;
                CGRect rect22       = bottom2View.frame;
                rect2.origin.y      = height + PADDING_BOTTOM + BOTTOM_Y;
                rect22.origin.y     = height + PADDING_BOTTOM + BOTTOM_Y;
                if ([self isMostra])
                    rect22.origin.y  -= NEGATIVE_INDEX;
                [bottomView setFrame:rect2];
                [bottom2View setFrame:rect22];
                
                // ...
                // dates
                CGRect rect3        = datesView.frame;
                rect3.size.height   = height;
                [datesView setFrame:rect3];
                [datesView setAlpha:1];
                
                // ...
                // info
                [tvDescription setAlpha:0];
                
                // ..
                CGRect rect5        = v.frame;
                rect5.size.height   = height + PADDING_BOTTOM + V_HEIGHT;
                [v setFrame:rect5];
                
                // ..
                [self updateRootScrollFrame];
                contentOpen = kTypeDates;
            }];
        }
            break;
            
        case kTypeInfo:
        {
            height = tvDescription.contentSize.height;
            [UIView animateWithDuration:DELAY_ANIMATION animations:^{
                // ...
                CGRect rect1        = elasticView.frame;
                rect1.size.height   = height + PADDING_BOTTOM;
                //if ([[[self dictionary] objectForKey:KEY_SLUG] isEqualToString:@"mostra13"])
                    //rect1.origin.y  = NEGATIVE_INDEX;
                [elasticView setFrame:rect1];
                
                // ..
                CGRect rect2        = bottomView.frame;
                rect2.origin.y      = height + PADDING_BOTTOM + BOTTOM_Y;
                [bottomView setFrame:rect2];
                CGRect rect22        = bottom2View.frame;
                rect22.origin.y      = height + PADDING_BOTTOM + BOTTOM_Y;
                if ([self isMostra])
                    rect22.origin.y  -= NEGATIVE_INDEX;
                [bottom2View setFrame:rect22];
                
                // ...
                // dates
                [datesView setAlpha:0];
                
                // ...
                // info
                CGRect rect3        = tvDescription.frame;
                rect3.size.height   = height;
                [tvDescription setFrame:rect3];
                [tvDescription setAlpha:1];
                
                // ..
                CGRect rect5        = v.frame;
                rect5.size.height   = height + PADDING_BOTTOM + V_HEIGHT;
                [v setFrame:rect5];
                
                // ..
                [self updateRootScrollFrame];
                contentOpen = kTypeInfo;
            }];
        }
            break;
    }
}
- (void) eventRetrive
{
    [UIView animateWithDuration:DELAY_ANIMATION animations:^{
        // ...
        CGRect rect1        = elasticView.frame;
        rect1.size.height   = 0;
        [elasticView setFrame:rect1];
        
        // ..
        CGRect rect2        = bottomView.frame;
        rect2.origin.y      = BOTTOM_Y;
        [bottomView setFrame:rect2];
        CGRect rect22        = bottom2View.frame;
        rect22.origin.y      = BOTTOM_Y;
        if ([self isMostra])
            rect22.origin.y  -= NEGATIVE_INDEX;
        [bottom2View setFrame:rect22];
        
        // ...
        CGRect rect3        = tvDescription.frame;
        rect3.size.height   = 0;
        [tvDescription setFrame:rect3];
        [tvDescription setAlpha:0];
        
        // ..
        CGRect rect4        = v.frame;
        rect4.size.height   = V_HEIGHT;
        [v setFrame:rect4];
        
        // ..
        [self updateRootScrollFrame];
    }];
    
    contentOpen = kTypeNone;
}

/**/

- (BOOL) isMostra
{
    if ([[[self dictionary] objectForKey:KEY_SLUG] isEqualToString:@"mostra13"])
        return YES;
    else
        return NO;
}

@end
