//
//  NuevaTareaControlador.h
//  Aquitectura
//
//  Created by Carlos Peralta on 9/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "NuevaTarea.h"
#import "TareaDTO.h"
#import "CategoriaDTO.h"

@class NuevaTarea, TareaDTO, CategoriaDTO;

@interface NuevaTareaControlador : NSObject

- (id) init_nuevaTareaUIViewController:(NuevaTarea*)nuevaTareaUIViewController;
- (void) agregarTarea_tareaNSString:(TareaDTO*)tareaTareaDTO;
- (void) terminoAgregarTarea;
- (void) terminoAgregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO;
- (void) agregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO;
- (void) agregarTareaAccionRequerida;

@end
