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

#define V_HEIGHT        339 //411
#define ELASTIC_HEIGHT  0
#define DATES_HEIGHT    209
#define BOTTOM_Y        V_HEIGHT
#define NEGATIVE_INDEX  190

#pragma mark - Typedef

typedef enum EventInfoType : NSInteger
{
    kTypeNone   = 0,
    kTypeDates  = 1,
    kTypeInfo   = 2
}
EventInfoType;

#pragma mark - Interface

@interface EventSingle ()
- (void) updateRootScrollFrame;
- (void) eventExpandForType:(EventInfoType) type;
- (void) eventRetrive;
/**/
- (BOOL) isMostra;
/**/
- (NSDictionary*) passesForKey:(NSString*) key;
@end

#pragma mark - Implementation

@implementation EventSingle
{
    EventInfoType contentOpen;
    EventManager *manager;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void) setConfigurations
{
    [super setConfigurations];
	eventDictionary = [[self dictionary] objectForKey:@"info"];
    [self setTitle:[eventDictionary objectForKey:@"name"]];
    
    manager = [[EventManager alloc] initWithEvent:[self dictionary]];
    
    CGRect rect = scr.frame;
    rect.size.height -= IPHONE5_COEF;
    [scr setFrame:rect];
    
    // ..
    contentOpen = kTypeNone;
    
    // ad..
    //Advertising *ad = [[Advertising alloc] initOnView:[self view]];
    //[ad correctRectOfView:scr];
    if ([adManager hasAdWithCategory:kAdBannerFooter])
        [adManager addAdTo:scr type:kAdBannerFooter];
    
    // configurate ..
    if ([[HSMaster core] eventDidHappen:eventDictionary]
	|| [[[self dictionary] objectForKey:@"passes"] count] == 0)
    {
        [butPasses setEnabled:NO];
        [butPasses setAlpha:0.5];
    }
    
	/*
    if (![[[self dictionary] objectForKey:KEY_SHOW_PASSES] isEqualToString:KEY_YES])
    {
        [butPasses setTitle:@"Mais informações" forState:UIControlStateNormal];
        // hack
        [butPanelist setEnabled:NO];
        [butPanelist setAlpha:0.5];
    }
	*/
    
    NSString *strImg    = [[eventDictionary objectForKey:@"images"] objectForKey:@"single"];
    [imgCover setImageWithURL:[NSURL URLWithString:strImg]];
    [elasticView setBackgroundColor:[UIColor colorWithRed:35.0/255.0 green:34.0/255.0 blue:46.0/255.0 alpha:1]];
    
    NSArray *arrPan     = [[self dictionary] objectForKey:@"panelists"];
    if ([arrPan count] < 1)
    {
        [butPanelist setEnabled:NO];
        [butPanelist setAlpha:0.5];
    }
    
	/*
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
     
    }
	*/
	CGRect rect1        = bottomView.frame;
	rect1.origin.y      = v.frame.size.height+v.frame.origin.y;
	[bottomView setFrame:rect1];
	[scr addSubview:bottomView];
    
    // ..
    CGRect rect2        = elasticView.frame;
    rect2.size.height   = 1;
    rect2.origin.y      = v.frame.size.height+v.frame.origin.y-5;
    //if ([self isMostra])
	//   rect2.origin.y  += NEGATIVE_INDEX;
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
    [tvDescription setText:[eventDictionary objectForKey:KEY_DESCRIPTION]];
    [labDates setText:[eventDictionary objectForKey:@"date_pretty"]];
    [labHours setText:[eventDictionary objectForKey:@"hours"]];
    [labLocal setText:[eventDictionary objectForKey:@"locale"]];
    
    [labDates setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    [labHours setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    [labLocal setFont:[UIFont fontWithName:FONT_REGULAR size:16.0]];
    
    [elasticView addSubview:tvDescription];
    [elasticView addSubview:datesView];
    
    // ..
    [self updateRootScrollFrame];
    [scr addSubview:v];
    
    [[butAgenda titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butPanelist titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butPasses titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butPassRed titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butRooms titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butGrade titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
    [[butCicle titleLabel] setFont:[UIFont fontWithName:FONT_REGULAR size:17.0]];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressAgenda:(id)sender
{
	NSArray *agenda = [[self dictionary] objectForKey:@"agenda"];
    Agenda *vc = [[Agenda alloc] initWithNibName:NIB_AGENDA andArray:agenda];
	vc.dates = [eventDictionary objectForKey:@"dates"];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressPanelist:(id)sender
{
	NSArray *panelists = [[self dictionary] objectForKey:@"panelists"];
    Panelist *vc = [[Panelist alloc] initWithNibName:NIB_PANELIST andArray:panelists];
    [[self navigationController] pushViewController:vc animated:YES];
}
- (IBAction) pressPasses:(id)sender
{
	NSArray *passes = [[self dictionary] objectForKey:@"passes"];
	Passes *vc = [[Passes alloc] initWithNibName:NIB_PASSES andArray:passes];
	[[self navigationController] pushViewController:vc animated:YES];
	
    //if ([[[self dictionary] objectForKey:KEY_SHOW_PASSES] isEqualToString:KEY_YES])
    //{
        // passes..
		/*
        // ...
        [tools requestUpdateFrom:URL_PASSES success:^{
            [loaderView removeFromSuperview];
            NSArray *results = [[tools JSONData] objectForKey:KEY_DATA];
            [tools propertyListWrite:results forFileName:PLIST_PASSES_VALUES];
            NSDictionary *passesDict = [self passesForKey:[[self dictionary] objectForKey:KEY_SLUG]];
            Passes *vc = [[Passes alloc] initWithNibName:NIB_PASSES andDictionary:passesDict];
            [[self navigationController] pushViewController:vc animated:YES];
        } fail:^{
            [loaderView removeFromSuperview];
            // ...
            NSArray *plistPasses = [tools propertyListRead:PLIST_PASSES_VALUES];
            if ([plistPasses count] > 0) {
                NSDictionary *passesDict = [self passesForKey:[[self dictionary] objectForKey:KEY_SLUG]];
                Passes *vc = [[Passes alloc] initWithNibName:NIB_PASSES andDictionary:passesDict];
                [[self navigationController] pushViewController:vc animated:YES];
            }
            else {
                [tools dialogWithMessage:@"Não foi possível carregar os Passes deste evento. Por favor, verifique sua conexão à internet."];
            }
        }];*/
    //}
	/*
	else {
        EventEmpty *vc = [[EventEmpty alloc] initWithNibName:NIB_EVENT_EMPTY andDictionary:[self dictionary]];
        [vc setTitle:@"Mais informações"];
        [[self navigationController] pushViewController:vc animated:YES];
    }*/
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
    [imgBottom setImage:[UIImage imageNamed:@"hsm_v5_events_single_card_bottom_about.png"]];
    if(contentOpen == kTypeInfo)
    {
        [self eventRetrive];
        //[butContent setAlpha:0.3];
        [imgBottom setImage:[UIImage imageNamed:@"hsm_v5_events_single_card_bottom.png"]];
        return;
    }
    
    [self eventExpandForType:kTypeInfo];
}
- (IBAction) pressDates:(id)sender
{
    [imgBottom setImage:[UIImage imageNamed:@"hsm_v5_events_single_card_bottom_infos.png"]];
    if(contentOpen == kTypeDates)
    {
        [self eventRetrive];
        [imgBottom setImage:[UIImage imageNamed:@"hsm_v5_events_single_card_bottom.png"]];
        return;
    }
    
    [self eventExpandForType:kTypeDates];
}

#pragma mark -
#pragma mark Methods

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
    return NO;
	/*
	if ([[[self dictionary] objectForKey:KEY_SLUG] isEqualToString:@"mostra13"])
        return YES;
    else
        return NO;*/
}

/**/

- (NSDictionary*) passesForKey:(NSString*) key
{
    FRTools *ftools = [[FRTools alloc] initWithTools];
    NSMutableDictionary *new = [NSMutableDictionary dictionary];
    NSArray *plist = [ftools propertyListRead:PLIST_PASSES_VALUES];
    
    for (NSDictionary *dict in plist) {
        if ([[dict objectForKey:@"event_slug"] isEqualToString:key]) {
            [new setObject:dict forKey:[dict objectForKey:KEY_COLOR]];
        }
    }
    
    return [new copy];
}

@end
