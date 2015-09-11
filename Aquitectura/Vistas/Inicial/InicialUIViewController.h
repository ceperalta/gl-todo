//
//  InicialUIViewController.h
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ControladorPrincipalNSObject.h"
#import "LoginWidget.h"
#import "CrearCuentaWidget.h"

@class ControladorPrincipalNSObject;


@interface InicialUIViewController : UIViewController <LoginWidgetProtocol, CrearCuentaWidgetProtocol>
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *espacioVerticalLogoNSLayoutConstraint;

@property (strong, nonatomic) IBOutletCollection(NSLayoutConstraint) NSArray *coleccionLogoNSLayoutConstraint;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *alineaVerticalmenteNSLayoutConstraint;
@property (weak, nonatomic) IBOutlet LoginWidget *loginWidget;
@property (weak, nonatomic) IBOutlet UIView *vistaContenedorLoginCreaCuentaWidgetsUIView;

- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject;
- (void) irAlHomeIngresoCorrecto;

- (void) claveYRepeticionNoSonIguales;

- (void) alertarValidacionCompleteTodosLosCamposCrearCuenta;
- (void) cuentaCreadaVolverAlLogin;


@end

