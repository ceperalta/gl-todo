//
//  InicialControlador.m
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "InicialControlador.h"
#import "InicialModelo.h"
#import "InicialUIViewController.h"
#import "App.h"

@interface InicialControlador ()
    @property (nonatomic, retain) InicialModelo *inicialModelo;
    @property (nonatomic, weak) InicialUIViewController *vistaInicialUIViewController;
@end


@implementation InicialControlador

- (void) aNil{
     NSLog(@"%s", __FUNCTION__);
    _inicialModelo = nil;
    _vistaInicialUIViewController = nil;
}

- (id) init_inicialUIViewController:(InicialUIViewController*)inicialUIViewController{
    NSLog(@"%s", __FUNCTION__);
    _inicialModelo = [[InicialModelo alloc] init_InicialControlador:self];
    _vistaInicialUIViewController = inicialUIViewController;
    return self;
}

- (void) ingresar_email:(NSString*)emailNSString clave:(NSString*)claveNSString{
    NSLog(@"%s", __FUNCTION__);
    [_inicialModelo controlarLogin_email:emailNSString clave:claveNSString];
}

- (void) ingresarLoginOK{
     NSLog(@"%s", __FUNCTION__);
    [_vistaInicialUIViewController irAlHomeIngresoCorrecto];
}


- (void) crearCuenta_email:(NSString*)emailNSString clave:(NSString*)claveNSString repiteClave:(NSString*)repiteClaveNSString{
    NSLog(@"%s", __FUNCTION__);
    
    if ([self validarDatosCrearCuenta_email:emailNSString clave:claveNSString repiteClave:repiteClaveNSString]) {
        [_inicialModelo crearCuenta_email:emailNSString clave:claveNSString];
    }
}

- (bool) validarDatosCrearCuenta_email:(NSString*)emailNSString clave:(NSString*)claveNSString repiteClave:(NSString*)repiteClaveNSString{
    NSLog(@"%s", __FUNCTION__);
    
    BOOL validacionOKBOOL = true;
    
    if (![repiteClaveNSString isEqualToString:claveNSString]) {
        [_vistaInicialUIViewController claveYRepeticionNoSonIguales];
        validacionOKBOOL = false;
    }
    
    if (emailNSString.length == 0 || claveNSString.length == 0 || repiteClaveNSString.length == 0) {
        [_vistaInicialUIViewController alertarValidacionCompleteTodosLosCamposCrearCuenta];
        validacionOKBOOL = false;
    }
    
    return validacionOKBOOL;
}

- (void) alertaCrearCuentaAceptada{
    NSLog(@"%s", __FUNCTION__);
    [_vistaInicialUIViewController cuentaCreadaVolverAlLogin];
}

-(void)dealloc{
    NSLog(@"%s", __FUNCTION__);
}

@end
