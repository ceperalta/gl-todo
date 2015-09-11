//
//  CategoriasModelo.m
//  Aquitectura
//
//  Created by Carlos Peralta on 7/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "CategoriasModelo.h"
#import "CategoriasControlador.h"
#import "App.h"
#import "CategoriaDTO.h"
#import "DAO.h"



@interface CategoriasModelo()

@property (retain,nonatomic) CategoriasControlador *categoriasControlador;
@property (retain,nonatomic) App *app;
@property (assign,nonatomic) NSString *postNotificationNameNSString;

@end


@implementation CategoriasModelo



- (id) init_HomeCategoriasControlador:(CategoriasControlador*)categoriasControlador{
    NSLog(@"%s", __FUNCTION__);
    
    
    _categoriasControlador  = categoriasControlador;
    _app = (App*)[[UIApplication sharedApplication] delegate];
    return self;
}

- (void) tomarCategorias{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"tomarCategoriasDesdeBackend";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lleganTodasLasCategorias:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao tomarTodasLasCategorias_postNotificationNameNSString:_postNotificationNameNSString];
}

- (void) lleganTodasLasCategorias:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        
        NSMutableArray *categoriasNSMutableArray = [[NSMutableArray alloc] init];
        
        NSDictionary *datosNSDictionary = [userInfo objectForKey:@"datos"];
        
        NSArray *categoriasNSArray = [datosNSDictionary objectForKey:@"categorias"];
        for(NSDictionary *object in categoriasNSArray) {
            
            CategoriaDTO *categoriaDTO = [[CategoriaDTO alloc] init];
            NSString *strId = (NSString*)[object objectForKey:@"idCategoria"];
            categoriaDTO.idCategoriaInt = [strId intValue];
            categoriaDTO.categoriaNombreNSString = [object objectForKey:@"catNombre"];
            
            [categoriasNSMutableArray addObject:categoriaDTO];
        }
        
        [_categoriasControlador lleganCategorias:categoriasNSMutableArray];
    }
}


@end
