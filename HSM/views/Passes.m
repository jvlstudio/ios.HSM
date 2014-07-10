//
//  Passes.m
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#import "Passes.h"
#import "PassForm.h"

@interface Passes ()
- (void) pushWithPassColor:(PassColor) dPassColor dictionary:(NSDictionary*) dict;
@end

@implementation Passes

#pragma mark -
#pragma mark Controller Methods

- (void)viewDidLoad
{
    [super viewDidLoadWithBackButton];
    [self setConfigurations];
}

#pragma mark -
#pragma mark Default Methods

- (void)setConfigurations
{
    [super setConfigurations];
    [self setTitle:@"Passes"];
    
    // ...
    NSInteger height = v.frame.size.height;
    for (NSDictionary *dict in [self array])
    {
		NSString *key = [dict objectForKey:@"color"];
        // if exists...
        //if (dict)
        //{
            // green
            if ([key isEqualToString:KEY_PASS_GREEN])
            {
                [greenName setText:[dict objectForKey:@"name"]];
                [greenDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
                [greenValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"price_from"]]];
                [greenValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"price_to"]]];
                if (![[dict objectForKey:@"valid_to"] isEqualToString:KEY_EMPTY])
                    [greenValidate setText:[NSString stringWithFormat:@"Válido até %@", [dict objectForKey:@"valid_to"]]];
                else
                    [greenValidate setText:@""];
                
                CGRect rect = greenView.frame;
                rect.origin.y = height;
                [greenView setFrame:rect];
                height += greenView.frame.size.height;
                [scr addSubview:greenView];
            }
            // gold
            if ([key isEqualToString:KEY_PASS_GOLD])
            {
                [goldName setText:[dict objectForKey:@"name"]];
                [goldDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
                [goldValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"price_from"]]];
                [goldValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"price_to"]]];
                if (![[dict objectForKey:@"valid_to"] isEqualToString:KEY_EMPTY])
                    [goldValidate setText:[NSString stringWithFormat:@"Válido até %@", [dict objectForKey:@"valid_to"]]];
                else
                    [goldValidate setText:@""];
                
                CGRect rect = goldView.frame;
                rect.origin.y = height;
                [goldView setFrame:rect];
                height += goldView.frame.size.height;
                [scr addSubview:goldView];
            }
            // red
            if ([key isEqualToString:KEY_PASS_RED])
            {
                [redName setText:[dict objectForKey:@"name"]];
                [redDescription setText:[dict objectForKey:KEY_DESCRIPTION]];
                [redValue setText:[NSString stringWithFormat:@"Preço Normal: R$%@", [dict objectForKey:@"price_from"]]];
                [redValueSpecial setText:[NSString stringWithFormat:@"R$%@", [dict objectForKey:@"price_to"]]];
                if (![[dict objectForKey:@"valid_to"] isEqualToString:KEY_EMPTY])
                    [redValidate setText:[NSString stringWithFormat:@"Válido até %@", [dict objectForKey:@"valid_to"]]];
                else
                    [redValidate setText:@""];
                
                CGRect rect = redView.frame;
                rect.origin.y = height;
                [redView setFrame:rect];
                height += redView.frame.size.height;
                [scr addSubview:redView];
            }
        //}
    }
    
    // ..
    [scr setContentSize:CGSizeMake(v.frame.size.width, height)];
    [scr addSubview:v];
    
    //if ([adManager hasAdWithCategory:kAdBannerFooter])
    //    [adManager addAdTo:scr type:kAdBannerFooter];
}

#pragma mark -
#pragma mark IBActions

- (IBAction) pressGreen:(id)sender
{
    [self pushWithPassColor:kPassColorGreen dictionary:[self passForColor:@"green"]];
}
- (IBAction) pressGold:(id)sender
{
    [self pushWithPassColor:kPassColorGold dictionary:[self passForColor:@"gold"]];
}
- (IBAction) pressRed:(id)sender
{
    [self pushWithPassColor:kPassColorRed dictionary:[self passForColor:@"red"]];
}

- (NSDictionary *) passForColor:(NSString *) color
{
	NSDictionary *pass = nil;
	for (NSDictionary *dict in [self array])
		if([[dict objectForKey:@"color"] isEqualToString:color])
			pass = dict;
	
	return pass;
}

#pragma mark -
#pragma mark Private Methods

- (void) pushWithPassColor:(PassColor) dPassColor dictionary:(NSDictionary*) dict
{
    PassForm *vc = [[PassForm alloc] initWithNibName:NIB_PASSES_FORM andPassColor:dPassColor dictionary:dict];
    [[self navigationController] pushViewController:vc animated:YES];
}

@end
