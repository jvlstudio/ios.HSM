//
//  TypeDefs.h
//  HSM
//
//  Created by Felipe Ricieri on 02/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#ifndef HSM_TypeDefs_h
#define HSM_TypeDefs_h

typedef enum HSMMenuRows : NSUInteger
{
    kMenuHome           = 0,
    kMenuEvents         = 1,
    kMenuBooks          = 3,
    kMenuNetwork        = 2,
    kMenuIssues         = 4,
    kMenuTV             = 5,
    //kMenuNews           = 6,
    kMenuEducation      = 6,
    kMenuSettings       = 7
}
HSMMenuRows;

typedef enum HSMIndexCell : NSUInteger
{
    kCellMenu           = 0,
    kCellEvents         = 1,
    kCellBooks          = 2,
    kCellAgenda         = 3,
    kCellAgendaBreak    = 4,
    kCellPanelist       = 5,
    kCellNetwork        = 6,
    kCellAgendaShow     = 7,
    kCellEventMultiple  = 8,
    //kCellAdvertising    = 9,
    kCellAgendaButton   = 9,
    kCellMagazine       = 10
}
HSMIndexCell;

typedef enum PassColor : NSUInteger
{
    kPassColorGreen     = 0,
    kPassColorGold      = 1,
    kPassColorRed       = 2
}
PassColor;

typedef enum PassCellType : NSUInteger
{
    kCellTypeSubtitle       = 0,
    kCellTypePicker         = 1,
    kCellTypePickerPayment  = 2,
    kCellTypeForm           = 3,
    kCellTypeAdd            = 4,
    kCellTypeEdit           = 5
}
PassCellType;

#endif
