//
//  InicialModelo.h
//  Aquitectura
//
//  Created by Carlos Peralta on 24/8/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "InicialControlador.h"

@class InicialControlador;

@interface InicialModelo : NSObject

- (void) controlarLogin_email:(NSString*)email clave:(NSString*)clave;
- (void) crearCuenta_email:(NSString*)email clave:(NSString*)clave;
- (id) init_InicialControlador:(InicialControlador*)inicialControlador;

@end
