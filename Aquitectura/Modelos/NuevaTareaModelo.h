//
//  NuevaTareaModelo.h
//  Aquitectura
//
//  Created by Carlos Peralta on 9/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NuevaTareaControlador.h"
#import "TareaDTO.h"
#import "CategoriaDTO.h"

@class NuevaTareaControlador, TareaDTO, CategoriaDTO;

@interface NuevaTareaModelo : NSObject

- (id) init_NuevaTareaControlador:(NuevaTareaControlador*)nuevaTareaControlador;

- (void) agregarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO;

- (void) agregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO;

@end
