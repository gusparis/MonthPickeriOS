//
//  MonthPickerView.m
//  MonthPicker
//
//  Created by Gustavo Paris on 22/04/2020.
//  Copyright © 2020 Gustavo Paris. All rights reserved.
//

#import "MonthPickerView.h"
#define DEFAULT_SIZE 204

@interface MonthPickerView2() <UIPickerViewDataSource, UIPickerViewDelegate>
@end

@implementation MonthPickerView2

NSMutableArray *monthts;
NSMutableArray *years;


- (instancetype)initWithFrame:(CGRect)frame
{
  if ((self = [super initWithFrame:frame])) {
    self.delegate = self;
    NSDate *date = [NSDate date];
    NSCalendar *gregorian = [NSCalendar currentCalendar];
    NSDateComponents *dateComponents = [gregorian components:(NSCalendarUnitMonth|NSCalendarUnitYear) fromDate:date];
    NSInteger currentMonth = [dateComponents month];
    NSInteger currentYear = [dateComponents year];
      
    years = [NSMutableArray array];
    for(NSInteger i = currentYear - DEFAULT_SIZE; i <= currentYear + DEFAULT_SIZE; i ++) {
        [years addObject:@(i)];
    }
      
    monthts = [NSMutableArray array];
    NSDateFormatter *df = [[NSDateFormatter alloc] init];
    for(NSInteger i = 0; i < 12; i ++){
        [monthts addObject:[[df monthSymbols] objectAtIndex:(i)]];
    }
      
    [self selectRow:(DEFAULT_SIZE / 2) - 7 + currentMonth inComponent:0 animated:YES];
    [self selectRow:DEFAULT_SIZE inComponent:1 animated:YES];
  }
  return self;
}

// row titles
- (NSString *)pickerView:(nonnull UIPickerView *) pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return [NSString stringWithFormat:@"%@", monthts[row % 12]];
            break;
        case 1:
            return [NSString stringWithFormat:@"%@", years[row]];
            break;
        default:
            return nil;
    }
}

// number of columns
- (NSInteger)numberOfComponentsInPickerView:(nonnull UIPickerView *)pickerView {
    return 2;
}

// number of rows
- (NSInteger)pickerView:(nonnull UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component {
    switch (component) {
        case 0:
            return DEFAULT_SIZE;
        case 1:
            return [years count];
            break;
        default:
            return 0;
    }
}

@end
