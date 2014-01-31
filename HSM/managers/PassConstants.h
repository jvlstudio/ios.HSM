//
//  PassConstants.h
//  HSM
//
//  Created by Felipe Ricieri on 04/10/13.
//  Copyright (c) 2013 ikomm Digital Solutions. All rights reserved.
//

#ifndef HSM_PassConstants_h
#define HSM_PassConstants_h

#define KEY_FORM_DATE               @"formDate"
#define KEY_FORM_PARTICIPANT        @"formParticipant"
#define KEY_FORM_PAYMENT            @"formPayment"

#define XIB_PASSES                  @"PassesResources"

#define CELL_PICKER                 @"passPickerCell"
#define CELL_PICKER_PAYMENT         @"passPickerPaymentCell"
#define CELL_FORM                   @"passFormCell"
#define CELL_ADD                    @"passAddCell"
#define CELL_EDIT                   @"passEditCell"

#define TITLE_BG                    @"hsm_passes_title_%@.png"
#define CELL_SUBTITLE_BG            @"hsm_passes_subtitle_%@.png"
#define CELL_PICKER_BG              @"hsm_passes_field_picker.png"
#define CELL_PICKER_PAYMENT_BG      @"hsm_passes_field_payment.png"
#define CELL_FORM_BG                @"hsm_passes_field_form.png"
#define CELL_ADD_BG                 @"hsm_passes_field_add.png"
#define CELL_EDIT_BG                CELL_ADD_BG

#define VALUES_TYPES                @[@"subtitle", @"pickerDate", @"pickerPayment", @"form", @"add", @"edit"]
#define VALUES_DATES                @[@"", @"04 de novembro", @"05 de novembro", @"06 de novembro"]
#define VALUES_PAYMENT              @[@"", @"Cartão de Crédito"]

#define PICKER_WIDTH                WINDOW_WIDTH
#define PICKER_HEIGHT               216
#define RECT_PICKER_SHOW            CGRectMake(ZERO, WINDOW_HEIGHT-PICKER_HEIGHT, PICKER_WIDTH, PICKER_HEIGHT)
#define RECT_PICKER_HIDE            CGRectMake(ZERO, WINDOW_HEIGHT, PICKER_WIDTH, PICKER_HEIGHT)

#endif
