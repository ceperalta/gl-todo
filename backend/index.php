<?php

// ********************************* Servicios REST ***********************************************

$arrPartesURI = split("/", $_SERVER['REQUEST_URI']);

$primerComponenteUri = $arrPartesURI[1];
$segundoComponenteUri = $arrPartesURI[2];
$tercerComponenteUri = $arrPartesURI[3];
$cuartoComponenteUri = $arrPartesURI[4];

if($primerComponenteUri == "rest" &&  count($arrPartesURI) > 2){

	
	// ************************************************ CATEGORIAS *************************************************** 
	if($segundoComponenteUri == "categorias"){

		if($_SERVER['REQUEST_METHOD'] == 'POST'){
				$obj = json_decode($_POST['json']);
				$sql = "insert into categorias (id, nombre_cat) values (null,'".$obj->categoria."')";
				ejecutar_sql($sql);

				$sql = "select * from categorias where nombre_cat='".$obj->categoria."'";
				$res = ejecutar_sql($sql);
				$reg = mysql_fetch_array($res);

				echo '{"id":"'.$reg[id].'","nombre_cat":"'.$reg[nombre_cat].'"}';
		}

		if($tercerComponenteUri == "todas"){
			if($_SERVER['REQUEST_METHOD'] == 'GET'){
				$sql = "select * from categorias";
				$res = ejecutar_sql($sql);
				
				$strJSON = '{"categorias":[';
				while( $reg = mysql_fetch_array($res) ){
					$strJSON .= '{"idCategoria":"'.$reg[id].'", "catNombre":"'.$reg[nombre_cat].'"},';
				}
				$strJSON = substr($strJSON, 0, strlen($strJSON)-1);
				$strJSON .= ']}';

				echo $strJSON;
			}
		}
	}

	// ************************************************ TAREAS *************************************************** 
	if($segundoComponenteUri == "tareas"){
		syslog(LOG_INFO, "tareas con metodo" . $_SERVER['REQUEST_METHOD']);
		if($_SERVER['REQUEST_METHOD'] == 'DELETE'){
			
			ejecutar_sql("delete from tareas where id=".$tercerComponenteUri);
			ejecutar_sql("delete from tareas_categorias where fk_tarea=".$tercerComponenteUri);
			echo "";
			
			//http_response_code(500);
			//echo '{"errorNegocioMsg":"problema al eliminar..."}';
		}

		if($_SERVER['REQUEST_METHOD'] == 'POST'){

				$obj = json_decode($_POST['json']);
				$sql = "insert into tareas (id, tarea) values (null,'".$obj->tarea."')";
				ejecutar_sql($sql);

				$sql = "select id from tareas where tarea='".$obj->tarea."'";
				$res = ejecutar_sql($sql);
				$reg = mysql_fetch_array($res);

				ejecutar_sql("insert into tareas_categorias (id, fk_tarea, fk_categoria) values (null,".$reg[id].",".$obj->idCategoria.")");

				echo ""; // sale 200
		}


		if($tercerComponenteUri == "todas"){
			if($_SERVER['REQUEST_METHOD'] == 'GET'){
				$sql = "select tareas.id as tareasid, tareas.tarea as nombreTarea, categorias.id as categoriasID, categorias.nombre_cat as catNombre from tareas, tareas_categorias, categorias WHERE tareas.id = tareas_categorias.fk_tarea AND categorias.id = tareas_categorias.fk_categoria order by tareas.id desc";
				$res = ejecutar_sql($sql);
				
				$strJSON = '{"tareas":[';
				while( $reg = mysql_fetch_array($res) ){
					$strJSON .= '{"idTarea":"'.$reg[tareasid].'", "nombreTarea":"'.$reg[nombreTarea].'", "categoriaID":"'.$reg[categoriasID].'", "catNombre":"'.$reg[catNombre].'"},';
				}
				$strJSON = substr($strJSON, 0, strlen($strJSON)-1);
				$strJSON .= ']}';

				echo $strJSON;
			}
		}

		if($tercerComponenteUri == "conCategoria"){
			if($_SERVER['REQUEST_METHOD'] == 'GET'){
				$sql = "select tareas.id as tareasid, tareas.tarea as nombreTarea, categorias.id as categoriasID, categorias.nombre_cat as catNombre from tareas, tareas_categorias, categorias WHERE tareas.id = tareas_categorias.fk_tarea AND categorias.id = tareas_categorias.fk_categoria AND categorias.id=".$cuartoComponenteUri." order by tareas.id desc";
				$res = ejecutar_sql($sql);
				
				$strJSON = '{"tareas":[';
				while( $reg = mysql_fetch_array($res) ){
					$strJSON .= '{"idTarea":"'.$reg[tareasid].'", "nombreTarea":"'.$reg[nombreTarea].'", "categoriaID":"'.$reg[categoriasID].'", "catNombre":"'.$reg[catNombre].'"},';
				}
				$strJSON = substr($strJSON, 0, strlen($strJSON)-1);
				$strJSON .= ']}';

				echo $strJSON;
			}
		}

	}
	
	// ************************************************ CUENTAS *************************************************** 
	if($segundoComponenteUri == "cuentas"){
		if($_SERVER['REQUEST_METHOD'] == 'PUT'){
			$vars = array();
			parse_str(file_get_contents("php://input"),$vars);
			$obj = json_decode($vars['json']);
		}

		if($_SERVER['REQUEST_METHOD'] == 'POST'){
			$obj = json_decode($_POST['json']);
			if($obj->accion == "controlarLogin"){
				syslog(LOG_INFO,"controlarLogin <<<<<");

				$res = ejecutar_sql("select count(id) as total from usuarios where usuario='".$obj->usuario."' and clave='".$obj->clave."'");
				$reg = mysql_fetch_array($res);

				if($reg['total']>0){
					echo ""; //sale 200 ;)
				}else{
					http_response_code(500);
					echo '{"errorNegocioMsg":"Usuario y/o clave incorrecta."}';
				}
			}

			if($obj->accion == "crearCuenta"){
				syslog(LOG_INFO,"crearCuenta <<<<<");
				$res = ejecutar_sql("select count(id) as total from usuarios where usuario='".$obj->usuario."'");
				$reg = mysql_fetch_array($res);
				if($reg['total']>0){
					http_response_code(500);
					echo '{"errorNegocioMsg":"El usuario ya existe."}';
				}else{
					ejecutar_sql("insert into usuarios (usuario, clave) values ('".$obj->usuario."','".$obj->clave."')");
				}	
			}
		}
	}
	exit();	
}
// ********************************* FIN Servicios REST ***********************************************

echo "<head><meta charset='UTF-8'></head>";

echo "<h1>Usuarios</h1><hr>";

$res = ejecutar_sql("select * from usuarios");
while($reg=mysql_fetch_array($res))
{
	echo "Usuario: <b>" . $reg['usuario'] . "</b> Clave: <b>".$reg['clave']."</b><br>";
}

echo "<h1>Categorías</h1><hr>";

$res = ejecutar_sql("select * from categorias");
while($reg=mysql_fetch_array($res))
{
	echo "Categoria: <b>" . $reg['nombre_cat'] . "</b> ID: <b>".$reg['id']."</b><br>";
}

echo "<h1>Tareas</h1><hr>";
$sql = "select tareas.id as tareasid, tareas.tarea as nombreTarea, categorias.id as categoriasID, categorias.nombre_cat as catNombre from tareas, tareas_categorias, categorias WHERE tareas.id = tareas_categorias.fk_tarea AND categorias.id = tareas_categorias.fk_categoria order by tareas.id desc";
$res = ejecutar_sql($sql );
while($reg=mysql_fetch_array($res))
{
	echo "Tarea: <b>" . $reg['nombreTarea'] . "</b> ID: <b>".$reg['tareasid']."</b> Categoria: <b>".$reg['catNombre']."</b><br>";
}

function ejecutar_sql($sql)
{
	syslog(LOG_INFO, "ejecutar_sql > ".$sql);
	//echo $sql;
	//$con = mysql_connect(':/cloudsql/arquitectura-ios:db','root','');
	$con = mysql_connect('localhost:3307','root','contra');
	mysql_select_db('todo');
	$res = mysql_query($sql,$con);
	mysql_close($con);
	
	return $res;
}


/*
//jdbc:google:mysql://vaadincep2:db/telefonos
	final public static String strURLConDBGoogleCloudSQL = "jdbc:google:mysql://scptest-645:db/scp";
	final public static String strClaveBDGoogleCloudSQL = "";


En Navicat: :/cloudsql/arquitectura-ios:db


*/

?>

