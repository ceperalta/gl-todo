//
//  LoginWidget.h
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol CrearCuentaWidgetProtocol <NSObject>

@required
- (void) crearCuentaUIButton_presionado;

@required
- (void) cancelarUIButton_presionado;

@end

IB_DESIGNABLE
@interface CrearCuentaWidget : UIView


@property (weak, nonatomic) id<CrearCuentaWidgetProtocol> delegado;

@property (weak, nonatomic) IBOutlet UITextField *emailUITextField;

@property (weak, nonatomic) IBOutlet UITextField *claveUITextField;

@property (weak, nonatomic) IBOutlet UITextField *repitaClaveUITextField;

@property (weak, nonatomic) IBOutlet UIButton *crearCuentaUIButton;

@property (weak, nonatomic) IBOutlet UIButton *cancelarUIButton;

@end
