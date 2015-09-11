//
//  NuevaTareaModelo.m
//  Aquitectura
//
//  Created by Carlos Peralta on 9/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "NuevaTareaModelo.h"
#import "NuevaTareaControlador.h"
#import "DAO.h"

@interface NuevaTareaModelo()

@property (retain,nonatomic) NuevaTareaControlador *nuevaTareaControlador;
@property (assign,nonatomic) NSString *postNotificationNameNSString;

@end


@implementation NuevaTareaModelo


- (id) init_NuevaTareaControlador:(NuevaTareaControlador*)nuevaTareaControlador{
    NSLog(@"%s", __FUNCTION__);
    
    _nuevaTareaControlador  = nuevaTareaControlador;
   
    return self;
}

- (void) agregarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"agregarTarea";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminoDeAgregarTarea:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao agregarTarea_postNotificationNameNSString:_postNotificationNameNSString tareaTareaDTO:tareaTareaDTO];
}

- (void) agregarCategoria_categoriaCategoriaDTO:(CategoriaDTO*)categoriaCategoriaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"agregarCategoria";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(terminoDeAgregarCategoria:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao agregarCategoria_postNotificationNameNSString:_postNotificationNameNSString categoriaCategoriaDTO:categoriaCategoriaDTO];
    
}

- (void) terminoDeAgregarTarea:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        [_nuevaTareaControlador terminoAgregarTarea];
    }
}

- (void) terminoDeAgregarCategoria:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        
        NSDictionary *datosNSDictionary = (NSDictionary*)[userInfo objectForKey:@"datos"];
        
        CategoriaDTO *categoriaDTO = [[CategoriaDTO alloc] init];
        categoriaDTO.idCategoriaInt = [(NSString*)[datosNSDictionary objectForKey:@"id"] intValue];
        categoriaDTO.categoriaNombreNSString = (NSString*)[datosNSDictionary objectForKey:@"nombre_cat"];
        
        [_nuevaTareaControlador terminoAgregarCategoria_categoriaCategoriaDTO:categoriaDTO];
    }
}

@end
