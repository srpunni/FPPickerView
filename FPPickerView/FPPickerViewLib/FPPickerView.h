//
//  FPPickerView.h
//  FPPickerView
//
//  Created by XAV-MAC13 on 28/06/13.
//  Copyright (c) 2013 XAV-MAC13. All rights reserved.
//

#import <Foundation/Foundation.h>
@class FPPickerView;
typedef enum {
    FPPickerViewPositionUp,
    FPPickerViewPositionDown
} FPPickerViewPosition;
@protocol FPPickerViewDelegate <NSObject>
-(NSString*) pickerView:(FPPickerView*)pickerView titleForRowAtIndex:(int)index;
@optional
-(void) pickerView:(FPPickerView*)pickerView didSelectRowAtIndex:(int)index;
-(void) pickerView:(FPPickerView*)pickerView didSelectObject:(id)object;
@end

@protocol FPPickerViewDataSource <NSObject>

-(int) numberOfRowsInPickerView:(FPPickerView*)pickerView;
@end

@interface FPPickerView : UIView
@property(nonatomic,strong) NSMutableArray* items;
@property(nonatomic,weak) id<FPPickerViewDelegate> delegate;
@property(nonatomic,weak)id<FPPickerViewDataSource>datasource;
@property(nonatomic,strong) NSString* titlePropertyVariableName;
@property(nonatomic,weak)UITextField* dropDownTextField;
@property(nonatomic,assign)int borderWidth;
@property(nonatomic,assign)int selectedIndex;
@property(nonatomic,assign)FPPickerViewPosition position;
+(FPPickerView*) pickerViewOnTextField:(UITextField*)textField withItems:(NSMutableArray*)array andTitleVariableName:(NSString*)propertyVariableName;
+(FPPickerView*) pickerViewOnTextField:(UITextField*)textField withItems:(NSMutableArray*)array andTitleVariableName:(NSString*)propertyVariableName andColor:(UIColor*)tColor;
@end
