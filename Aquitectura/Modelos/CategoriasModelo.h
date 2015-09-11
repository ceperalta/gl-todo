//
//  CategoriasModelo.h
//  Aquitectura
//
//  Created by Carlos Peralta on 7/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CategoriasControlador.h"

@class CategoriasControlador;

@interface CategoriasModelo : NSObject

- (void) tomarCategorias;
- (id) init_HomeCategoriasControlador:(CategoriasControlador*)categoriasControlador;


@end
