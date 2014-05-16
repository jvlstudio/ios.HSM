//
//  Constants.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#ifndef HSM_Constants_h
#define HSM_Constants_h

/* numbers */

#define ZERO                        0
#define ONE                         1
#define DELAY                       0.5

/* nibs */

#define NIB_MENU                    @"Menu"
#define NIB_HOME                    @"Home"
#define NIB_OPENING                 @"Opening"
#define NIB_EVENTS                  @"Events"
#define NIB_EVENT_SINGLE            @"EventSingle"
#define NIB_EVENT_MULTIPLE          @"EventMultiple"
#define NIB_EVENT_EMPTY             @"EventEmpty"
#define NIB_BOOKS                   @"Books"
#define NIB_BOOK_SINGLE             @"BookSingle"
#define NIB_MAGAZINES               @"Magazines"
#define NIB_NETWORK                 @"Network"
#define NIB_NETWORK_SINGLE          @"NetworkSingle"
#define NIB_NETWORK_SIGN            @"NetworkSign"
#define NIB_AGENDA                  @"Agenda"
#define NIB_PANELIST                @"Panelist"
#define NIB_PANELIST_SINGLE         @"PanelistSingle"
#define NIB_PASSES                  @"Passes"
#define NIB_PASSES_FORM             @"PassForm"
#define NIB_PASSES_END              @"PassEnd"
#define NIB_PASSES_ADD              @"PassAdd"

/* resources */

#define XIB_RESOURCES               @"AppResources"

/* plist */

#define PLIST_ADS                   @"HSM-Ads"
#define PLIST_MENU                  @"HSM-Menu"
#define PLIST_EVENTS                @"HSM-Events"
#define PLIST_BOOKS                 @"HSM-Books"
#define PLIST_MAGAZINES             @"HSM-Magazines"
#define PLIST_PASSES                @"HSM-Passes"
#define PLIST_PASSES_VALUES         @"HSM-Passes-Values"
#define PLIST_PASS_COMPLETED        @"HSM-Pass-Completed"
#define PLIST_LOGS                  @"HSM-Logs"
#define PLIST_NETWORK               @"HSM-Network"
#define PLIST_MYCONTACT             @"HSM-MyContact"

/* urls */

#define URL                         @"http://apps.ikomm.com.br/hsm"
#define URL_GRAPH                   [NSString stringWithFormat:@"%@/%@", URL, @"graph"]
#define URL_PASS_ADD                [NSString stringWithFormat:@"%@/%@", URL_GRAPH, @"pass-add.php"]
#define URL_PASSES                  @"http://apps.ikomm.com.br/hsm5/graph/passes.php"
#define URL_ADS                     @"http://apps.ikomm.com.br/hsm5/graph/ads.php"
#define URL_ADS_RECEIVE             @"http://apps.ikomm.com.br/hsm5/graph/ads-receive.php?ad_id=%@"
#define URL_ADS_UPLOADS             @"http://apps.ikomm.com.br/hsm5/uploads"

#define URL_QRCODE                  @"http://chart.apis.google.com/chart?cht=qr&chs=500x500&chl=%@"

/* questions */

#define IS_IPHONE5                  (([[UIScreen mainScreen] bounds].size.height-568) ? NO : YES)
#define IPHONE5_OFFSET              88
#define IPHONE5_COEF                IS_IPHONE5 ? ZERO : IPHONE5_OFFSET

/* third-part app ids */

#define FACEBOOK_APP_ID             @"139301386281076"
#define FACEBOOK_APP_SECRET         @"9ceee311105aa8af80062dd97f49fded"
#define FACEBOOK_APP_PERMS          @[@"publish_stream", @"publish_actions", @"email"]
#define PARSE_APP_ID                @"rTeFsHt9rmZVXtPu20QPONd1e3nldhpXB8XavuBY"
#define PARSE_APP_SECRET            @"j6XeRt7HSaA1lJ00yK7BknHBxfo7HWFV3DdTCVoZ"
#define GOOGLE_ANALYTICS_TRACKER    @""

/* frames > widths */

#define WINDOW_WIDTH                [[UIScreen mainScreen] bounds].size.width

/* frames > heights */

#define WINDOW_HEIGHT               [[UIScreen mainScreen] bounds].size.height
#define STATUSBAR_HEIGHT            20
#define NAVIGATIONBAR_HEIGHT        44
#define KEYBOARD_HEIGHT             216
#define SIDE_MENU_OFFSET            60

/* fonts & colors */

#define FONT_FAMILY                 @"CaeciliaLTStd"
#define FONT_REGULAR                @"CaeciliaLTStd-Roman"
#define FONT_LIGHT                  @"CaeciliaLTStd-Light"
#define FONT_BOLD                   @"CaeciliaLTStd-Bold"

#define COLOR_BACKGROUND            [UIColor colorWithRed:29.0/255.0 green:28.0/255.0 blue:38.0/255.0 alpha:1]
#define COLOR_MENU_BACKGROUND       [UIColor colorWithRed:17.0/255.0 green:17.0/255.0 blue:24.0/255.0 alpha:1]
#define COLOR_TITLE                 [UIColor colorWithRed:252.0/255.0 green:209.0/255.0 blue:0.0/255.0 alpha:1]
#define COLOR_DESCRIPTION           [UIColor colorWithRed:172.0/255.0 green:169.0/255.0 blue:200.0/255.0 alpha:1]

#define AD_HEIGHT   44
#define AD_WIDTH    WINDOW_WIDTH
#define AD_RECT     CGRectMake(ZERO, WINDOW_HEIGHT-AD_HEIGHT, AD_WIDTH, AD_HEIGHT)

/* arraies */

#define ALPHABET                    @[@"A", @"B", @"C", @"D", @"E", @"F", @"G"]

#endif
