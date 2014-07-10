//
//  EventSingle.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "KDViewController.h"

@interface EventSingle : KDViewController
{
	NSDictionary *eventDictionary;
	
    IBOutlet UIScrollView *scr;
    IBOutlet UIView *v;
    IBOutlet UIView *elasticView;
    IBOutlet UIView *bottomView;
    IBOutlet UIView *bottom2View;
    IBOutlet UIView *datesView;
    IBOutlet UITextView *tvDescription;
    IBOutlet UIImageView *imgCover;
    
    IBOutlet UILabel *labDates;
    IBOutlet UILabel *labHours;
    IBOutlet UILabel *labLocal;
    
    IBOutlet UIButton *butAgenda;
    IBOutlet UIButton *butPanelist;
    IBOutlet UIButton *butContent;
    IBOutlet UIButton *butDates;
    IBOutlet UIButton *butPasses;
    IBOutlet UIButton *butRooms;
    IBOutlet UIButton *butCicle;
    IBOutlet UIButton *butGrade;
    IBOutlet UIButton *butPassRed;
    
    /**/
    
    IBOutlet UIImageView *img1;
    IBOutlet UIImageView *imgBottom;
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressAgenda:(id)sender;
- (IBAction) pressPanelist:(id)sender;
- (IBAction) pressContent:(id)sender;
- (IBAction) pressDates:(id)sender;
- (IBAction) pressPasses:(id)sender;
- (IBAction) pressRooms:(id)sender;
- (IBAction) pressCicle:(id)sender;
- (IBAction) pressGrade:(id)sender;
- (IBAction) pressPassRed:(id)sender;

@end
