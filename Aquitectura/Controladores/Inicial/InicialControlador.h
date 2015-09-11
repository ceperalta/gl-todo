//
//  InicialControlador.h
//  Aquitectura
//
//  Created by Carlos Peralta on 20/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InicialUIViewController.h"

@class InicialUIViewController;

@interface InicialControlador : NSObject

- (void) crearCuenta_email:(NSString*)emailNSString clave:(NSString*)claveNSString repiteClave:(NSString*)repiteClaveNSString;
- (void) ingresar_email:(NSString*)emailNSString clave:(NSString*)claveNSString;
- (id) init_inicialUIViewController:(InicialUIViewController*)inicialUIViewController;
- (void) alertaCrearCuentaAceptada;
- (void) ingresarLoginOK;
- (void) aNil;

@end
