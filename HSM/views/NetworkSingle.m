//
//  NetworkSingle.m
//  HSM
//
//  Created by Felipe Ricieri on 17/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "NetworkSingle.h"

@interface NetworkSingle ()
- (void) setInfo;
- (void) setDisabled;
/**/
- (void) openBlackView;
- (void) closeBlackView;
@end

@implementation NetworkSingle
{
    FRTools *tools;
    BOOL isBlackViewOpen;
}

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setTitle:@"Contato"];
    contact = [self dictionary];
    tools   = [[FRTools alloc] initWithTools];
    // ..
    [self setInfo];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressAddContact:(id)sender
{
    BOOL didAdd = [self addContactToAddressBook:contact];
    if (!didAdd)
        [tools dialogWithMessage:@"Não foi possível salvar este contato em sua Agenda."];
    else
    {
        [tools dialogWithMessage:[NSString stringWithFormat:@"O contato de \"%@\" foi adicionado com sucesso em sua Agenda.", [contact objectForKey:KEY_NAME]]];
        [self setContactAsAdded:[contact objectForKey:KEY_EMAIL]];
        [self setDisabled];
    }
}
- (IBAction) pressSendEmail:(id)sender
{
    // get a new new MailComposeViewController object
    MFMailComposeViewController *mc = [[MFMailComposeViewController alloc] init];
    
    // his class should be the delegate of the mc
    mc.mailComposeDelegate = self;
    
    // set a mail subject ... but you do not need to do this :)
    [mc setSubject:@"Network HSM"];
    
    // set some basic plain text as the message body ... but you do not need to do this :)
    [mc setMessageBody:@"Olá," isHTML:NO];
    
    // set some recipients ... but you do not need to do this :)
    [mc setToRecipients:[NSArray arrayWithObjects:[contact objectForKey:KEY_EMAIL], nil]];
    
    // displaying our modal view controller on the screen (of course animated has to be set on YES if you want to see any transition)
    [self presentViewController:mc animated:YES completion:nil];
}
- (IBAction) pressBlack:(id)sender
{
    if (isBlackViewOpen)
        [self closeBlackView];
    else
        [self openBlackView];
}

#pragma mark -
#pragma mark Methods

- (void) setInfo
{
    [labName setFont:[UIFont fontWithName:FONT_BOLD size:16]];
    [labName2 setFont:[UIFont fontWithName:FONT_BOLD size:16]];
    [labEmail setFont:[UIFont fontWithName:FONT_REGULAR size:12]];
    [labCompany setFont:[UIFont fontWithName:FONT_REGULAR size:12]];
    [labRole setFont:[UIFont fontWithName:FONT_REGULAR size:12]];
    [labPhone setFont:[UIFont fontWithName:FONT_REGULAR size:12]];
    [labMobile setFont:[UIFont fontWithName:FONT_REGULAR size:12]];
    
    [labName setText:[contact objectForKey:KEY_NAME]];
    [labName2 setText:[contact objectForKey:KEY_NAME]];
    [labEmail setText:[contact objectForKey:KEY_EMAIL]];
    [labCompany setText:[contact objectForKey:KEY_COMPANY]];
    [labRole setText:[contact objectForKey:KEY_ROLE]];
    [labPhone setText:[contact objectForKey:KEY_PHONE]];
    [labMobile setText:[contact objectForKey:KEY_MOBILE]];
    
    NSString *strImg    = [NSString stringWithFormat:@"hsm_ball_%@.png", [contact objectForKey:KEY_BARCOLOR]];
    [imgColor setImage:[UIImage imageNamed:strImg]];
    
    NSString *strQRCode = [NSString stringWithFormat:URL_QRCODE, [self QRCodeEncrypt:contact]];
    [imgQRCode setImageWithURL:[NSURL URLWithString:strQRCode]];
    
    [labName alignBottom];
    [labCompany alignTop];
    [labName2 alignBottom];
    
    [blackView setHidden:YES];
    [blackView setAlpha:0];
    isBlackViewOpen = NO;
    
    // ..
    if ([self hasContactBeenAdd:[contact objectForKey:KEY_EMAIL]])
        [self setDisabled];
}
- (void) setDisabled
{
    [butAddContact setEnabled:NO];
    [butAddContact setAlpha:0.5];
}

/**/

- (void) openBlackView
{
    [blackView setHidden:NO];
    [[self navigationController] setNavigationBarHidden:YES animated:YES];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = CGRectMake((WINDOW_WIDTH/2)-125, (WINDOW_HEIGHT/2)-125, 250, 250);
        [imgQRCode setFrame:frame];
        [butBlack setFrame:frame];
        [blackView setAlpha:1];
    } completion:^(BOOL finished) {
        isBlackViewOpen = YES;
    }];
}
- (void) closeBlackView
{
    [[self navigationController] setNavigationBarHidden:NO animated:YES];
    [UIView animateWithDuration:0.3f animations:^{
        CGRect frame = CGRectMake(174, 215, 125, 125);
        [imgQRCode setFrame:frame];
        [butBlack setFrame:frame];
        [blackView setAlpha:0];
    } completion:^(BOOL finished) {
        isBlackViewOpen = NO;
        [blackView setHidden:YES];
    }];
}

#pragma mark -
#pragma mark MFMailComposeViewController

// delegate function callback
- (void)mailComposeController:(MFMailComposeViewController *)controller
          didFinishWithResult:(MFMailComposeResult)result
                        error:(NSError *)error
{
    // switchng the result
    switch (result) {
        case MFMailComposeResultCancelled:
            NSLog(@"Mail send canceled.");
            /*
             Execute your code for canceled event here ...
             */
            break;
        case MFMailComposeResultSaved:
            NSLog(@"Mail saved.");
            /*
             Execute your code for email saved event here ...
             */
            break;
        case MFMailComposeResultSent:
            NSLog(@"Mail sent.");
            /*
             Execute your code for email sent event here ...
             */
            break;
        case MFMailComposeResultFailed:
            NSLog(@"Mail send error: %@.", [error localizedDescription]);
            /*
             Execute your code for email send failed event here ...
             */
            break;
        default:
            break;
    }
    // hide the modal view controller
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
