//
//  HomeTareasModelo.m
//  Aquitectura
//
//  Created by Carlos Peralta on 4/9/15.
//  Copyright (c) 2015 Eduardo Pujol. All rights reserved.
//

#import "HomeTareasModelo.h"
#import "TareaDTO.h"
#import "CategoriaDTO.h"
#import "HomeTareasControlador.h"
#import "App.h"
#import "DAO.h"


@interface HomeTareasModelo()

@property (retain,nonatomic) HomeTareasControlador *homeTareasControlador;
@property (retain,nonatomic) App *app;
@property (assign,nonatomic) NSString *postNotificationNameNSString;

@end


@implementation HomeTareasModelo

- (id) init_HomeTareasControlador:(HomeTareasControlador*)homeTareasControlador{
    NSLog(@"%s", __FUNCTION__);
    
    
    _homeTareasControlador  = homeTareasControlador;
    _app = (App*)[[UIApplication sharedApplication] delegate];
    return self;
}

- (void) tomarTareasParaCat_idCatInt:(int)idCatInt{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"tomarTareasBackend";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lleganTodasLasTareas:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao tomarTodasLasTareasParaCategoria_postNotificationNameNSString:_postNotificationNameNSString intIDCategoria:idCatInt];
}

- (void) tomarTareas{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"tomarTareasBackend";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(lleganTodasLasTareas:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao tomarTodasLasTareas_postNotificationNameNSString:_postNotificationNameNSString];
}

- (void) lleganTodasLasTareas:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
       
        NSMutableArray *tareasNSMutableArray = [[NSMutableArray alloc] init];
        
        NSDictionary *datosNSDictionary = [userInfo objectForKey:@"datos"];
        
        NSArray *tareasNSArray = [datosNSDictionary objectForKey:@"tareas"];
        for(NSDictionary *object in tareasNSArray) {
            NSLog(@" >>>> %@", [object objectForKey:@"nombreTarea"]);
            
            TareaDTO *tareaDTO = [[TareaDTO alloc] init];
            NSString *strId = (NSString*)[object objectForKey:@"idTarea"];
            tareaDTO.idTareaInt = [strId intValue];
            strId = (NSString*)[object objectForKey:@"categoriaID"];
            tareaDTO.idCategoriaParaEstaTareaInt = [strId intValue];
            tareaDTO.categoriaNSString = [object objectForKey:@"catNombre"];
            tareaDTO.tareaNSString = [object objectForKey:@"nombreTarea"];
            
            [tareasNSMutableArray addObject:tareaDTO];
        }
       
        [_homeTareasControlador lleganTareas:tareasNSMutableArray];
    }
}

- (void) eliminarTarea_tareaTareaDTO:(TareaDTO*)tareaTareaDTO{
    NSLog(@"%s", __FUNCTION__);
    
    _postNotificationNameNSString = @"eliminarTarea";
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(llegaDeEliminarTarea:) name:_postNotificationNameNSString object:nil];
    
    DAO *dao = [[DAO alloc] init];
    [dao eliminarTarea_postNotificationNameNSString:_postNotificationNameNSString tareaTareaDTO:tareaTareaDTO];
    
}

- (void) llegaDeEliminarTarea:(NSNotification *) notification{
    NSLog(@"%s", __FUNCTION__);
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:_postNotificationNameNSString object:nil];
    
    NSDictionary *userInfo = notification.userInfo;
    NSString *strRespuestaDAOCodigoNSString = (NSString*)[userInfo objectForKey:@"codigo"];
    
    if ([strRespuestaDAOCodigoNSString isEqualToString:@"200"]){
        [_homeTareasControlador elimiacionTareaOK];
    }else{
        [_homeTareasControlador problemasEnEliminacionTarea];
    }
}

@end
