//
//  InicialModelo.m
//  Aquitectura
//
//  Created by Carlos Peralta on 24/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "InicialModelo.h"
#import "App.h"
#import "CuentaDTO.h"
#import "InicialControlador.h"
#import "DAO.h"

@interface InicialModelo()

@property (retain,nonatomic) InicialControlador *inicialControlador;
@property (retain,nonatomic) App *app;
@property (assign,nonatomic) NSString *postNotificationNameNSString;

@end


@implementation InicialModelo


- (id) init_InicialControlador:(InicialControlador*)inicialControlador{
    NSLog(@"%s", __FUNCTION__);
    
    _inicialControlador = inicialControlador;
    _app = (App*)[[UIApplication sharedApplication] delegate];
    return self;
}

- (void)dealloc{
     NSLog(@"%s", __FUNCTION__);
}

#pragma mark -
#pragma mark Crear cuenta, notificaciones y demas...

- (void) controlarLogin_email:(NSString*)email clave:(NSString*)clave {
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"controlarLoginDesdeBackend";
    CuentaDTO *cuentaDTO = [[CuentaDTO alloc] init];
    cuentaDTO.nombreNSString = email;
    cuentaDTO.claveNSString = clave;
    
    [_app.controladorPrincipalNSObject mostrarActivityIndicator_msg:NSLocalizedString(@"Login_ControlandoLogin", nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminaControlarLoginCuenta:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao controlarLogin_CuentaDTO:cuentaDTO postNotificationNameNSString:_postNotificationNameNSString];
}

- (void) terminaControlarLoginCuenta:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    NSLog(@"NOTIFICACION REMOVIDA: terminaRequestRed");
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        [_app.controladorPrincipalNSObject ocultarActivityIndicator];
        [_inicialControlador ingresarLoginOK];
    }
}

#pragma mark -
#pragma mark Crear cuenta, notificaciones y demas...

- (void) crearCuenta_email:(NSString*)email clave:(NSString*)clave{
    NSLog(@"%s", __FUNCTION__);

    _postNotificationNameNSString = @"agregarCuentaEnBackend";
    
    CuentaDTO *cuentaDTO = [[CuentaDTO alloc] init];
    cuentaDTO.nombreNSString = email;
    cuentaDTO.claveNSString = clave;

    [_app.controladorPrincipalNSObject mostrarActivityIndicator_msg:NSLocalizedString(@"CrearCuenta_creandoCuenta", nil)];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminaCrearCuenta:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao agregarCuenta_CuentaDTO:cuentaDTO postNotificationNameNSString:_postNotificationNameNSString];
}

- (void) terminaCrearCuenta:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"terminaRequestRed" object:nil];
    NSLog(@"NOTIFICACION REMOVIDA: terminaRequestRed");
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        [_app.controladorPrincipalNSObject ocultarActivityIndicator];
        [_app.controladorPrincipalNSObject mostrarAlerta_msg:NSLocalizedString(@"CrearCuenta_creada", nil)];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertaCrearCuentaAceptada) name:@"AlertaGeneralAceptada" object:nil];
    }
}

- (void) alertaCrearCuentaAceptada{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:@"AlertaGeneralAceptada" object:nil];
    NSLog(@"NOTIFICACION REMOVIDA: AlertaGeneralAceptada");
    
    [_inicialControlador alertaCrearCuentaAceptada];
}

@end
