//
//  LoginWidget.h
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>





@protocol LoginWidgetProtocol <NSObject>

@required
- (void) btnIngresarPresionado;

@required
- (void) btnCrearCuentaPresionado;

@end


IB_DESIGNABLE
@interface LoginWidget : UIView

@property (weak, nonatomic) IBOutlet UITextField *emailUITextField;
@property (weak, nonatomic) IBOutlet UITextField *claveUITextField;


@property (weak, nonatomic) id<LoginWidgetProtocol> delegado;


@end
