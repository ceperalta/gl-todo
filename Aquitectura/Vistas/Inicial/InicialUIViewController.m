//
//  InicialUIViewController.m
//  Aquitectura
//
//  Created by Eduardo Pujol on 19/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "InicialUIViewController.h"
#import "ControladorPrincipalNSObject.h"
#import "App.h"
#import "InicialControlador.h"
#import "CrearCuentaWidget.h"


@interface InicialUIViewController () <UITextFieldDelegate>

    @property (nonatomic, retain) InicialControlador *inicialControlador;
    @property (nonatomic, weak) ControladorPrincipalNSObject *controladorPrincipalRefNSObject;
    @property (nonatomic, retain) CrearCuentaWidget *crearCuentaWidget;
    @property (nonatomic, assign) BOOL yaModificoConstaintsLoginBOOL;
    @property (nonatomic, assign) BOOL ingresarLuegoDeBajarLoginBOOL;
    @property (nonatomic, assign) BOOL estaEnLoginBOOL;

@end

@implementation InicialUIViewController


- (id)inciaConSuNibYControlador_ControladorPrincipalNSObject:(ControladorPrincipalNSObject*)controladorPrincipalNSObject{
    NSLog(@"%s", __FUNCTION__);
    _controladorPrincipalRefNSObject = controladorPrincipalNSObject;
    
    // Incializamos el controlador formal..
    _inicialControlador = [[InicialControlador alloc] init_inicialUIViewController:self];
    
    // Instanciamos el NIB
    return [self initWithNibName:@"InicialVistaNib" bundle:nil];
}

- (void)viewDidLoad{
    NSLog(@"%s", __FUNCTION__);
    _loginWidget.delegado = self;
    _loginWidget.emailUITextField.delegate = self;
    _loginWidget.claveUITextField.delegate = self;
    
    _yaModificoConstaintsLoginBOOL = false;
    _ingresarLuegoDeBajarLoginBOOL = false;
    _estaEnLoginBOOL = true;
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(ocultaTeclado) name:UIKeyboardWillHideNotification object:nil];
}

- (void) irAlHomeIngresoCorrecto{
     NSLog(@"%s", __FUNCTION__);
    [_controladorPrincipalRefNSObject cargarHome];
   
}

- (void) aNil{
    NSLog(@"%s", __FUNCTION__);
    _inicialControlador = nil;
    _controladorPrincipalRefNSObject = nil;
    _crearCuentaWidget = nil;
}



- (void) claveYRepeticionNoSonIguales{
    NSLog(@"%s", __FUNCTION__);
    UIAlertView *alertaCrearCuentaIncorrectoUIAlertView = [[UIAlertView alloc]
                                                     initWithTitle:NSLocalizedString(@"CrearCuenta_TituloClavesNoCoinciden", nil)
                                                     message:NSLocalizedString(@"CrearCuenta_ClavesNoCoinciden", nil)
                                                     delegate:self
                                                     cancelButtonTitle:NSLocalizedString(@"Login_AceptarLoginIncorrect", nil)
                                                     otherButtonTitles:nil];
    [alertaCrearCuentaIncorrectoUIAlertView show]; 
}

- (void)dealloc{
    NSLog(@"%s", __FUNCTION__);
    [_inicialControlador aNil];
    [self aNil];
}

- (void) alertarValidacionCompleteTodosLosCamposCrearCuenta{
    NSLog(@"%s", __FUNCTION__);
    
    UIAlertView *alertaCrearCuentaIncorrectoUIAlertView = [[UIAlertView alloc]
                                                           initWithTitle:NSLocalizedString(@"General_validacion", nil)
                                                           message:NSLocalizedString(@"General_completarTodosLosCampos", nil)
                                                           delegate:self
                                                           cancelButtonTitle:NSLocalizedString(@"General_aceptar", nil)
                                                           otherButtonTitles:nil];
    [alertaCrearCuentaIncorrectoUIAlertView show];

    
}

- (void) ocultaTeclado{
    NSLog(@"%s", __FUNCTION__);
    
    
    [self.view layoutIfNeeded];
    
    _alineaVerticalmenteNSLayoutConstraint.constant = 0;
    
    /*
     NSLayoutConstraint *lc = (NSLayoutConstraint*)[_coleccionLogoNSLayoutConstraint objectAtIndex:0];
     lc.constant = 91;
     */
    _espacioVerticalLogoNSLayoutConstraint.constant = 91;
    
    [UIView animateWithDuration:0.5
                     animations:^{
                         [self.view layoutIfNeeded]; // Called on parent view
                     }
                     completion:^(BOOL finished){
                         
                         if (_ingresarLuegoDeBajarLoginBOOL && _estaEnLoginBOOL)  {
                             _ingresarLuegoDeBajarLoginBOOL = false;
                             [self btnIngresarPresionado];
                         }
                     }
     ];
    
    _yaModificoConstaintsLoginBOOL = false;
    
    
}

- (void) cuentaCreadaVolverAlLogin{
    [self cancelarUIButton_presionado];
}

#pragma mark -
#pragma mark UITextFieldDelegate

- (void)textFieldDidBeginEditing:(UITextField *)textField{
    NSLog(@"%s", __FUNCTION__);
    
    // 568 de alto hasta el iphone 5, requiere subir login...
    if( [[UIScreen mainScreen] bounds].size.height < 569 && !_yaModificoConstaintsLoginBOOL){
        _yaModificoConstaintsLoginBOOL = true;
        [self.view layoutIfNeeded];
        
        _alineaVerticalmenteNSLayoutConstraint.constant = 85;
        
        /*
        NSLayoutConstraint *lc = (NSLayoutConstraint*)[_coleccionLogoNSLayoutConstraint objectAtIndex:0];
        lc.constant = 10;
        */
        _espacioVerticalLogoNSLayoutConstraint.constant = 30;
        
        [UIView animateWithDuration:1.5
                         animations:^{
                             [self.view layoutIfNeeded]; // Called on parent view
                                    }];
    }
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    NSLog(@"%s", __FUNCTION__);
    if(textField == _loginWidget.emailUITextField){
        [_loginWidget.claveUITextField becomeFirstResponder];
    }else{
        _ingresarLuegoDeBajarLoginBOOL = true;
        [textField resignFirstResponder];
    }

    return true;
}

#pragma mark -
#pragma mark Delegado_LoginWidgetProtocol.h



- (void) btnIngresarPresionado{
    NSLog(@"%s", __FUNCTION__);
    [_inicialControlador ingresar_email:_loginWidget.emailUITextField.text clave:_loginWidget.claveUITextField.text];
    //TODO: con  [self irAlHomeIngresoCorrecto] gira... ;
    //[self irAlHomeIngresoCorrecto];
}

- (void) btnCrearCuentaPresionado{
    NSLog(@"%s", __FUNCTION__);
    
    _crearCuentaWidget = [[CrearCuentaWidget alloc] initWithFrame:_loginWidget.frame];
    _crearCuentaWidget.delegado = self;
    
    _crearCuentaWidget.emailUITextField.delegate = self;
    _crearCuentaWidget.claveUITextField.delegate = self;
    _crearCuentaWidget.repitaClaveUITextField.delegate = self;
    
    [self.vistaContenedorLoginCreaCuentaWidgetsUIView addSubview:self.crearCuentaWidget];
    
    
    [UIView transitionFromView:_loginWidget
                        toView: self.crearCuentaWidget
                        duration:0.7
                        options: UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionFlipFromRight
                        completion:^(BOOL finished){
                            _estaEnLoginBOOL = false;
                    }
     ];

}


#pragma mark -
#pragma mark CrearCuentaWidgetProtocol.h

- (void) crearCuentaUIButton_presionado{
    NSLog(@"%s", __FUNCTION__);
    [_inicialControlador crearCuenta_email:self.crearCuentaWidget.emailUITextField.text clave:self.crearCuentaWidget.claveUITextField.text repiteClave:self.crearCuentaWidget.repitaClaveUITextField.text];

}

- (void) cancelarUIButton_presionado{
    NSLog(@"%s", __FUNCTION__);
    [UIView transitionFromView:_crearCuentaWidget
                        toView:_loginWidget
                      duration:0.7
                       options:UIViewAnimationOptionShowHideTransitionViews | UIViewAnimationOptionTransitionFlipFromLeft
                    completion:^(BOOL finished){
                        _estaEnLoginBOOL = true;
                        [_crearCuentaWidget removeFromSuperview];
                    }
     ];
}



@end
