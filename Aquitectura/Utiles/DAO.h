//
//  DAO.h
//  Aquitectura
//
//  Created by Carlos Peralta on 2/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "CuentaDTO.h"
#import "TareaDTO.h"
#import "CategoriaDTO.h"

@class CuentaDTO, TareaDTO, CategoriaDTO;

@interface DAO : NSObject

- (void) agregarCuenta_CuentaDTO: (CuentaDTO*)cuentaDTO postNotificationNameNSString:(NSString*)postNotificationNameNSString;
- (void) controlarLogin_CuentaDTO: (CuentaDTO*)cuentaDTO postNotificationNameNSString:(NSString*)postNotificationNameNSString;
- (void) tomarTodasLasTareas_postNotificationNameNSString:(NSString*)postNotificationNameNSString;
- (void) tomarTodasLasCategorias_postNotificationNameNSString:(NSString*)postNotificationNameNSString;
- (void) tomarTodasLasTareasParaCategoria_postNotificationNameNSString:(NSString*)postNotificationNameNSString intIDCategoria:(int)intIDCategoria;
- (void) agregarTarea_postNotificationNameNSString:(NSString*)postNotificationNameNSString tareaTareaDTO:(TareaDTO*)tareaTareaDTO;
- (void) agregarCategoria_postNotificationNameNSString:(NSString*)postNotificationNameNSString categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO;
- (void) eliminarTarea_postNotificationNameNSString:(NSString*)postNotificationNameNSString tareaTareaDTO:(TareaDTO*)tareaTareaDTO;


@end
