 /*
Quinto Perito en Informatica
Nombre: Diego Suarez, 
Código Técnico: IN5BV
Carnét: 2022233
Fecha de creación: 	06/07/2023 22:49 Diego Suarez
Fecha de Modificaión: 
	06/07/2023 23:49 - samuel rodriguez
    07/07/2023 10:50 - Manuel Suarez
    07/07/2023 14:20 - Auky Sey
    07/07/2023 16:00 - Jose Tejaxun
    07/07/2023 16:52 - Omar Sanchez
 */

Drop database if exists DBKinEx; 
Create database DBKinEx; 

Use  DBKinEx;

create table Empresas (
    codigoEmpresa int auto_increment not null,
    nombreEmpresa varchar(150) not null,
    direccion varchar(150) not null,
    telefono varchar(10) not null,
    primary key PK_codigoEmpresa (codigoEmpresa)

);

create table TipoEmpleado(
    codigoTipoEmpleado int not null auto_increment,
    descripcion        varchar(50) not null,
    primary key PK_codigoTipoEmpleado (codigoTipoEmpleado)
);

Create table Empleados(
	codigoEmpleado int auto_increment not null,
    carnetEmpleado int not null,
    apellidoEmpleado varchar(150) not null,
    nombresEmpleado varchar(150) not null,
    direccionEmpleado varchar(150) not null,
    telefonoContacto varchar(10) not null,
    codigoTipoEmpleado int not null,
    primary key PK_codigoEmpleado (codigoEmpleado),
    constraint FK_Empleados_TipoEmpleado foreign key 
		(codigoTipoEmpleado) references TipoEmpleado(codigoTipoEmpleado)
);

Create table TipoProducto(
    codigoTipoProducto int auto_increment not null,
    descripcionTipoProducto       varchar(100) not null,
    primary key PK_TipoProducto (codigoTipoProducto)
);

create table MetodoDePago(
    codigoMetodoDePago int auto_increment not null,
    descripcion       varchar(100) not null,
    primary key PK_codigoMetodoDePago (codigoMetodoDePago)
);


Create table Producto(
    codigoProducto int not null,
    nombreProducto varchar(150) not null,
    cantidad int not null,
    precio varchar(100) not null,
    codigoTipoProducto int not null,
    primary key PK_codigoProducto (codigoProducto),
    constraint FK_Producto_TipoProducto foreign key
		(codigoTipoProducto) references TipoProducto(codigoTipoProducto)
);

Create table Usuario(
	codigoUsuario int not null auto_increment,
    nombreUsuario varchar (100) not null,
    apellidoUsuario varchar (100) not null,
    usuarioLogin varchar (50) not null,
    contrasena varchar (50) not null,
    primary key  Pk_codigoUsuario (codigoUsuario)
);


Create table Login(
	usuarioMaster varchar(50) not null,
    passwordLogin varchar(50) not null,
    primary key PK_usuarioMaster (usuarioMaster)
);

create table TipoUbicacion(
	codigoTipoUbicacion int auto_increment not  null,
	direccion varchar (100) not null,
	primary key PK_codigoTipoUbicacion(codigoTipoUbicacion)
);

create table Ubicacion(
    codigoUbicacion int auto_increment not null,
    codigoTipoUbicacion int not null,
    departamento varchar(100) not null,
    municipio  varchar(100) not null,
    aldeaColonia varchar (100) not null,
    primary key PK_codigoUbicacion(codigoUbicacion),
    constraint FK_Ubicacion_TipoUbicacion foreign key (codigoTipoUbicacion)
        references TipoUbicacion (codigoTipoUbicacion) on delete cascade
);

create table TipoCliente(
   codigoTipoCliente int auto_increment not null,
   descripcionTipoCliente varchar(150) not null,
   primary key PK_codigoTipoCliente (codigoTipoCliente)
);

create table Cliente(
   codigoCliente int auto_increment not null,
   apellidosCliente varchar(150) not null,
   nombresCliente varchar(150) not null,
   direccionCliente varchar(150) not null,
   telefonoCliente varchar(10) not null,
   codigoTipoCliente int not null,
   codigoMetodoDePago int not null,
   primary key PK_codigoCliente (codigoCliente),
   constraint FK_Cliente_TipoCliente foreign key (codigoTipoCliente)
      references TipoCliente (codigoTipoCliente) on delete cascade,
   constraint FK_Cliente_MetodoDePago foreign key (codigoMetodoDePago)
      references MetodoDePago (codigoMetodoDePago) on delete cascade
);

Create table TipoPaquete(
    codigoTipoPaquete int not null,
    descripcionTipoPaquete varchar(100) not null,
    primary key PK_codigoTipoPaquete (codigoTipoPaquete)
);

create table Paquete(
   codigoPaquete int auto_increment not null,
   tamañoPaquete varchar(150) not null,
   pesoPaquete varchar(150) not null,
   contenido varchar(150) not null,
   codigoTipoPaquete int not null,
   primary key PK_codigoPaquete (codigoPaquete),
   constraint FK_Paquete_TipoPaquete foreign key (codigoTipoPaquete)
      references TipoPaquete (codigoTipoPaquete) on delete cascade
);

Create table Ruta(
    codigoRuta int not null,
    distancia varchar(100) not null,
    medioDeTransporte varchar(100) not null,
    estadoRuta varchar(100) not null,
    primary key PK_codigoRuta (codigoRuta)
);

 
-- ---------------------------------AGREGAR EMPRESA--------------------------------
Delimiter $$
	create procedure sp_AgregarEmpresa (in nombreEmpresa varchar(150), in direccion varchar(150), in telefono varchar(10))
		Begin
			Insert into Empresas (nombreEmpresa, direccion, telefono)
				values (nombreEmpresa, direccion, telefono);
        End$$
Delimiter ;

Call sp_AgregarEmpresa('Mac', '2av 12-12 zona 21', '1526-2635');
Call sp_AgregarEmpresa('Campero', '3av 16-99 zona 12', '3652-6654');
Call sp_AgregarEmpresa ('Walmart', 'Ciudad de Guatemala', '3541-5542');
Call sp_AgregarEmpresa ('Cemaco', 'Zona 4 de Mixco', '3325-5521');
Call sp_AgregarEmpresa ('PriceSmart', 'Zona 1 de VillaNueva', '6540-5512');

-- ---------------------------- Listar Empresas ------------------------------------
Delimiter $$
	Create procedure sp_ListarEmpresas ()
		Begin
			Select
            E.codigoEmpresa, 
            E.nombreEmpresa, 
            E.direccion, 
            E.telefono
            from Empresas E;
        End$$
Delimiter ;

Call sp_ListarEmpresas ();

-- ---------------------------- Buscar Empresa -----------------------------
Delimiter $$
	Create procedure sp_BuscarEmpresa (in codEmpresa int)
		Begin
			Select 
            E.codigoEmpresa, 
            E.nombreEmpresa, 
            E.direccion, 
            E.telefono
            from Empresas E
            where codigoEmpresa = codEmpresa;
        End$$
Delimiter ;

call sp_BuscarEmpresa (1);

-- ---------------------------- Eliminar Empresa -----------------------------
Delimiter $$
	Create procedure sp_EliminarEmpresa (in codEmpresa int)
    Begin
		Delete from Empresas
        where codigoEmpresa = codEmpresa;
    End$$
Delimiter ;

 Call sp_EliminarEmpresa(3);
 
 -- --------------------------- CRUD TIPOEMPLEADO -----------------------------
 -- ---------------- Agregar TipoEmpleado ------------------------
Delimiter $$
	create procedure sp_AgregarTipoEmpleado (in descripcion varchar(50))
		Begin
			Insert into TipoEmpleado (descripcion)
				values (descripcion);
        End$$
Delimiter ;

Call sp_AgregarTipoEmpleado ('Mensajero');
Call sp_AgregarTipoEmpleado ('Gerente');
Call sp_AgregarTipoEmpleado ('Contador');
Call sp_AgregarTipoEmpleado ('Empaquetador');
Call sp_AgregarTipoEmpleado ('Conserje');

-- --------------------------- Listar TipoEmpleado -----------------------------
Delimiter $$
	Create procedure sp_ListarTipoEmpleado()
		Begin
			Select 
            T.codigoTipoEmpleado, 
            T.descripcion
            from TipoEmpleado T;  
        End$$
Delimiter ;

Call sp_ListarTipoEmpleado();
-- ------------------------------ Buscar TipoEmpleado -----------------------------
Delimiter $$
	Create procedure sp_BuscarTipoEmpleado (in codTipoEmpleado int)
		Begin
			Select 
            T.codigoTipoEmpleado,
            T.descripcion
            from TipoEmpleado T
            where codigoTipoEmpleado = codTipoEmpleado;
        End$$
Delimiter ;

call sp_BuscarTipoEmpleado (2);

-- ------------------------------- Eliminar TipoEmpleado -----------------------------
Delimiter $$
	Create procedure sp_EliminarTipoEmpleado (in codTipoEmpleado int)
		Begin
			Delete from TipoEmpleado
            where codigoTipoEmpleado = codTipoEmpleado;
        End$$
Delimiter ;


-- ---------------------------------- Agregar Usuarios ------------------------------------- --

Delimiter  $$
	Create procedure sp_AgregarUsuario(in nombreUsuario varchar (100) , in apellidoUsuario varchar (100), 
    in usuarioLogin varchar(50), in contrasena varchar (50))
		Begin
        Insert into Usuario(nombreUsuario,apellidoUsuario,usuarioLogin,contrasena)
			values (nombreUsuario,apellidoUsuario,usuarioLogin,contrasena);
        End$$
Delimiter ;

call sp_AgregarUsuario('Samuel','rodriguez','Samuel','165');
call sp_AgregarUsuario('Diego','Suarez','suarez','56');
call sp_AgregarUsuario('Victor','Alvarez','victor','924');
call sp_AgregarUsuario('Jose','Texajum','jtejaxun','625');


-- ----------------------------- Listar Usuarios --------------------------------- --
Delimiter $$
    create procedure sp_ListarUsuarios()
        Begin 
            Select 
            U.codigoUsuario, 
            U.nombreUsuario, 
            U.apellidoUsuario, 
            U.usuarioLogin, 
            U.contrasena
            from Usuario U;
        End$$
Delimiter ;

call sp_ListarUsuarios();

-- ------------------------------------- Procedimientos almacenados Entidad Empleados -----------------------------------
-- describe Empleados
-- ------------------------------------- AGREGAR Empleados ----------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_AgregarEmpleado(in carnetEmpleado int, apellidoEmpleado varchar(150), nombresEmpleado varchar(150), in direccionEmpleado varchar(150), in telefonoContacto varchar(10), in codigoTipoEmpleado int)
		Begin
			Insert into Empleados (carnetEmpleado, apellidoEmpleado, nombresEmpleado, direccionEmpleado, telefonoContacto, codigoTipoEmpleado)
				Values (carnetEmpleado, apellidoEmpleado, nombresEmpleado, direccionEmpleado, telefonoContacto, codigoTipoEmpleado);
        End$$	
Delimiter ;

call sp_AgregarEmpleado('2023001', 'Ramirez ', 'Sebastián', 'Zona 7', '23658974', 3);
call sp_AgregarEmpleado('2023002', 'Palacios', 'Daniel', 'Zona 5', '12365485', 1);
call sp_AgregarEmpleado('2023003', 'Rosales', 'Nancy', 'Zona 8', '30210369', 2);

-- --------------------------------------------------LISTAR Empleados ----------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_ListarEmpleados()
		Begin
			Select 
			E.codigoEmpleado, 
            E.carnetEmpleado, 
            E.apellidoEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.codigoTipoEmpleado
            from Empleados E;
        End$$	
Delimiter ;

call sp_ListarEmpleados();

-- ------------------------- BUSCAR Empleados---------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_BuscarEmpleados(in codEmp int)
		Begin
			Select 
            E.codigoEmpleado, 
            E.carnetEmpleado, 
            E.apellidoEmpleado, 
            E.nombresEmpleado, 
            E.direccionEmpleado, 
            E.telefonoContacto, 
            E.codigoTipoEmpleado
            from Empleados E where codigoEmpleado = codEmp;
        End$$
Delimiter ;

-- ---------------------------ELIMINAR Empleados---------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_EliminarEmpleados(in codEmp int)
		Begin
			Delete from Empleados
				where codigoEmpleado = codEmp;
		End$$
Delimiter ;

-- --------------------- EDITAR Empleados -----------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_EditarEmpleado(in codEmp int, in carnEmp int, in apeEmp varchar(150), in nomEmp varchar(150), in direcEmp varchar(150), in telCon varchar(10), in codTipEmp int)
		Begin
			Update Empleados E
				set E.carnetEmpleado = carnEmp, 
					E.apellidoEmpleado = apeEmp, 
					E.nombresEmpleado =nomEmp, 
					E.direccionEmpleado = direcEmp, 
					E.telefonoContacto = telCon,
					E.codigoTipoEmpleado = codTipEmp
                where codigoEmpleado = codEmp;
        End$$
Delimiter ;

-- ------------------------------------- Procedimientos almacenados Tipo Empleado -----------------------------------
-- codigoTipoProducto     descripcionTipoProducto  

Delimiter $$
	Create procedure sp_AgregarTipoProducto(in descripcionTipoProducto varchar(100))
		Begin
			Insert into TipoProducto (descripcionTipoProducto)
				values (descripcionTipoProducto);
        End$$	
Delimiter ;
call sp_AgregarTipoProducto("Mesa");
call sp_AgregarTipoProducto("Florero");
call sp_AgregarTipoProducto("Balon ");
call sp_AgregarTipoProducto("Caja");
call sp_AgregarTipoProducto("Escritorio");


-- listar 

Delimiter $$
	Create procedure sp_ListarTipoProducto()
		Begin
			Select 
            TP.codigoTipoProducto,
            TP.descripcionTipoProducto
            from TipoProducto TP;
		End$$
Delimiter ;


call sp_ListarTipoProducto();

-- buscar 

Delimiter $$
	Create procedure sp_BuscarTipoProducto(in codTipoProducto int)
		Begin
			Select
			TP.codigoTipoProducto,
            TP.descripcionTipoProducto
            from TipoProducto  TP where codigoTipoProducto = codTipoProducto;
        End$$
Delimiter ;
-- eliminar
Delimiter $$
	Create procedure sp_EliminarTipoProducto(in codTipoProducto int)
		Begin
			Delete from TipoProducto
				where codigoTipoProducto = codTipoProducto;
        End$$
Delimiter ;
-- editar 
Delimiter $$
	Create procedure sp_EditarTipoProducto(in codProducto int, in codTipProduc int)
		Begin
			Update TipoProducto TP
				set TP.codigoTipoProducto = codTipProduc
                where P.codigoProducto = codProducto;
        End$$
Delimiter ;
-- ------------------------------------- Procedimientos almacenados Entidad Producto -----------------------------------
-- describe Producto
-- ------------------------------------- AGREGAR Producto -------------------------------------------------------------
Delimiter $$
	Create procedure sp_AgregarProducto(in codigoProducto int, in nombreProducto varchar(150), in cantidad int, in precio varchar(100), in codigoTipoProducto int)
		Begin
			Insert into Producto (codigoProducto, nombreProducto, cantidad, precio, codigoTipoProducto)
				values (codigoProducto, nombreProducto, cantidad, precio, codigoTipoProducto);
        End$$	
Delimiter ;
call sp_AgregarProducto(1, 'Abarrotes', 6, 'Q.3000', 3);
call sp_AgregarProducto(2, 'Art. de libreria', 56, 'Q.10000', 1);
call sp_AgregarProducto(3, 'Articulos de computación', 15, 'Q.25000', 2);

-- --------------------------------------------------LISTAR Productos ----------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_ListarProductos()
		Begin
			Select 
            P.codigoProducto, 
            P.nombreProducto, 
            P.cantidad,
            P.precio,
            P.codigoTipoProducto
            from Producto  P;
		End$$
Delimiter ;

call sp_ListarProductos;

-- ------------------------- BUSCAR Producto ---------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_BuscarProducto(in codProducto int)
		Begin
			Select
			P.codigoProducto, 
            P.nombreProducto, 
            P.cantidad,
            P.precio,
            P.codigoTipoProducto
            from Producto  P where codigoProducto = codProducto;
        End$$
Delimiter ;

-- ---------------------------ELIMINAR Producto ---------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_EliminarProducto(in codProducto int)
		Begin
			Delete from Producto
				where codigoProducto = codProducto;
        End$$
Delimiter ;

-- --------------------- EDITAR Producto -----------------------------------------------------------------------------------------------------------------------------------------------
Delimiter $$
	Create procedure sp_EditarProducto(in codProducto int, in nombProduc varchar(150), in cant int, in pre varchar(100), in codTipProduc int)
		Begin
			Update Producto P
				set P.nombreProducto = nombProduc,
					P.cantidad = cant,
                    P.precio = pre,
                    P.codigoTipoProducto = codTipProduc
                where P.codigoProducto = codProducto;
        End$$
Delimiter ;

-- ------------------------------------- Procedimientos almacenados Metodo de pago  -----------------------------------
-- MetodoDePago codigoMetodoDePago  descripcion  


Delimiter $$
	Create procedure sp_AgregarMetodoDePago(in descripcion varchar(100))
		Begin
			Insert into MetodoDePago (descripcion)
				values (descripcion);
        End$$	
Delimiter ;
call sp_AgregarMetodoDePago("Targeta de credito");
call sp_AgregarMetodoDePago("Efectivo");
call sp_AgregarMetodoDePago("Efectivo");
call sp_AgregarMetodoDePago("Efectivo");
call sp_AgregarMetodoDePago("Targeta de credito");


-- listar 

Delimiter $$
	Create procedure sp_ListarMetodoDePago()
		Begin
			Select 
            MDP.codigoMetodoDePago,
            MDP.descripcion
            from MetodoDePago  MDP;
		End$$
Delimiter ;


call sp_ListarMetodoDePago();

-- buscar 

Delimiter $$
	Create procedure sp_BuscarMetodoDePago(in codMetodoDePago int)
		Begin
			Select
			MDP.codigoMetodoDePago,
            MDP.descripcion
            from MetodoDePago  MDP where codigoMetodoDePago = codMetodoDePago;
        End$$
Delimiter ;
-- eliminar
Delimiter $$
	Create procedure sp_EliminarMetodoDePago(in codTipoProducto int)
		Begin
			Delete from TipoProducto
				where codigoTipoProducto = codMetodoDePago;
        End$$
Delimiter ;
-- editar 
Delimiter $$
	Create procedure sp_EditarMetodoDePago(in codMetodoDePago int, in codTipProduc int)
		Begin
			Update TipoMetodoDePago MDP
				set MDP.codigoTipoProducto = codTipProduc
                where P.codigoProducto = codProducto;
        End$$
Delimiter ;
-- _________________________ Crud De tipoUbicacion ________________________________________ 
-- _________________________ agregar tipoUbicacion

 

Delimiter $$

 

    create procedure sp_AgregarTipoUbicacion(in direccion varchar(100))

    Begin

        Insert into TipoUbicacion(direccion)
            values(direccion);


    End$$

 

Delimiter ;

 

Call sp_AgregarTipoUbicacion('zona 1');
Call sp_AgregarTipoUbicacion('zona 2');
Call sp_AgregarTipoUbicacion('zona 3');
Call sp_AgregarTipoUbicacion('zona 4');

 

-- _________________________ Listar tipoUbicacion

 

Delimiter $$

    create procedure sp_ListarTipoUbicacion()

    Begin

        Select
            TU.codigoTipoUbicacion,
            TU.direccion
                from TipoUbicacion TU;

    End$$

Delimiter ;

Call sp_ListarTipoUbicacion();

 


-- _________________________ Buscar tipoUbicacion

 

Delimiter $$

 

    create procedure sp_BuscarTipoUbicacion(in codigoTipoUbicacion int)

    Begin 

        Select
            TU.codigoTipoUbicacion,
            TU.direccion
                from TipoUbicacion TU
                    where codigoTipoUbicacion = codigoTipoUbicacion;
    End$$

 

Delimiter ;

 

Call sp_BuscarTipoUbicacion(2);

 

-- _________________________ Eliminar tipoUbicacion

 

Delimiter $$

 

    create procedure sp_EliminartipoUbicacion(in codigoTipoUbicacion int)

        Begin

        Delete from tipoUbicacion
        where codigoTipoUbicacion = codigoTipoUbicacion;

        End$$

 

Delimiter ;

 


-- _________________________ Crud De Ubicacion ________________________________________ 
-- _________________________ agregar Ubicacion

 

Delimiter $$
    create procedure sp_AgregarUbicacion (in codigoTipoUbicacion int,in departamento varchar(100), in municipio varchar(100), in aldeaColonia varchar(100))
        Begin
            Insert into Ubicacion (codigoTipoUbicacion,departamento, municipio, aldeaColonia)
                values (codigoTipoUbicacion,departamento, municipio, aldeaColonia);
        End$$
Delimiter ;

 

Call sp_AgregarUbicacion('1','Alta Verapaz','Coban','1');
Call sp_AgregarUbicacion('2','Baja Verapaz','Rabinal','2');
Call sp_AgregarUbicacion('3','Chimaltenango','Tejar','3');
Call sp_AgregarUbicacion('4','Peten','Jocotan','4');

 


-- _________________________ Listar Ubicacion

 

Delimiter $$

 

    create procedure sp_ListarUbicacion()

        Begin
            Select
                U.codigoUbicacion,
                U.codigoTipoUbicacion,
                U.departamento,
                U.municipio,
                U.aldeaColonia

                from Ubicacion U;
        End$$

Delimiter ;

 

Call sp_ListarUbicacion();

 

-- _________________________ Buscar Ubicacion

 

Delimiter $$

 

    create procedure sp_BuscarUbicacion(in codigoUbicacion int)

        Begin
            Select
                U.codigoUbicacion,
                U.codigoTipoUbicacion,
                U.departamento,
                U.municipio,
                U.aldeaColonia

                from Ubicacion U
                    where codigoUbicacion = codigoUbicacion;
        End$$

 

Call sp_BuscarUbicacion(1);

 

-- _________________________ Eliminar Ubicacion

 

Delimiter $$

 

    create procedure sp_EliminarUbicacion(in codigoUbicacion int)

    Begin
        Delete from Ubicacion
        where codigoUbicacion = codigoUbicacion;
    End$$

 

Delimiter ;

-- ---------------------------------------Agregar Tipo Cliente --------------------------------------

delimiter $$
   create procedure sp_agregarTipoCliente(in desTCli varchar(150))
      begin
         insert into TipoCliente(descripcionTipoCliente)
            values(desTCli);
      end$$
delimiter ;

call sp_agregarTipoCliente('');
call sp_agregarTipoCliente('');
call sp_agregarTipoCliente('');
call sp_agregarTipoCliente('');

-- ----------------------------------------Listar Tipo Cliente --------------------------------------

delimiter $$
   create procedure sp_listarTipoClientes()
      begin
         select
            TC.codigoTipoCliente,
            TC.descripcionTipoCliente
		 from TipoCliente TC;
      end$$
delimiter ;

call sp_listarTipoClientes();

-- ----------------------------------------Buscar Tipo Cliente --------------------------------------

delimiter $$
   create procedure sp_buscarTipoCliente(in codTCli int)
      begin
		select
            TC.codigoTipoCliente,
            TC.descripcionTipoCliente
		 from TipoCliente TC where TC.codigoTipoCliente = codTCli;
      end$$
delimiter ;

call sp_buscarTipoCliente(2);

-- ----------------------------------------Eliminar Tipo Cliente ------------------------------------

delimiter $$
   create procedure sp_eliminarTipoCliente(in codTCli int)
     begin
        delete from TipoCliente
           where TipoCliente.codigoTipoCliente = codTCli;
	 end$$
delimiter ;


-- ----------------------------------------Editar Tipo Cliente----------------------------------------

delimiter $$
   create procedure sp_editarTipoCliente(in codTCli int, in desTCli varchar(150))
      begin
         update TipoCliente TC
            set TC.descripcionTipoCliente = desTCli
               where TC.codigoTipoCliente = codTCli;
      end$$
delimiter ;

call sp_editarTipoCliente(1,'hola');
-- ----------------------------------Agregar Cliente----------------------------------------------

delimiter $$
   create procedure sp_agregarCliente(in aCli varchar(150), in nCli varchar(150), in dirCli varchar(150), in telCli varchar(10),in codTCli int, codMPag int)
   begin
      insert into Cliente(apellidosCliente, nombresCliente, direccionCliente, telefonoCliente, codigoTipoCliente, codigoMetodoDePago)
          values(aCli, nCli, dirCli, telCli, codTCli, codMPag);
   end$$
delimiter ;

call sp_agregarCliente('Gil Siquina', 'Leticia Rosmery', 'Comalapa, Chimaltenango','3606-2308', 1, 2);
call sp_agregarCliente('Lopez Mendoza', 'Walter Fernando', 'Santo Domingo, Xenacoj', '3697-3164', 2, 3);
call sp_agregarCliente('Aquino Farfan', 'Wendy Miranda', 'Motagua, El Progreso', '59871-0397', 3, 2);
call sp_agregarCliente('Gomez Valencia', 'Jeferson Giovani', 'Guatemala, Guatemala', '3218-7810', 1, 1);

-- ----------------------------------Listar Clientes----------------------------------------------

delimiter $$
   create procedure sp_listarClientes()
      begin
         select 
            C.codigoCliente, 
            C.apellidosCliente, 
            C.nombresCliente, 
            C.direccionCliente, 
            C.telefonoCliente, 
            C.codigoTipoCliente,
            C.codigoMetodoDePago
		 from Cliente C;
      end$$
delimiter ;

call sp_listarClientes();

-- --------------------------------- Buscar Cliente------------------------------------------------

delimiter $$
   create procedure sp_buscarCliente(in codCli int)
      begin
         select
            C.codigoCliente, 
            C.apellidosCliente, 
            C.nombresCliente, 
            C.direccionCliente, 
            C.telefonoCliente, 
            C.codigoTipoCliente,
            C.codigoMetodoDePago
		 from Cliente C where C.codigoCliente = codCli;
      end$$
delimiter ;

call sp_buscarCliente(1);

-- ---------------------------------Eliminar Cliente-----------------------------------------------

delimiter $$
    create procedure sp_eliminarCliente(in codCli int)
       begin
          delete from Cliente
             where Cliente.codigoCliente = codCli;
       end$$
delimiter ;

-- call sp_eliminarCliente(2);

-- ----------------------------------Editar Cliente------------------------------------------------

delimiter $$
   create procedure sp_editarCliente(in codCli int, in aCli varchar(150), in nCli varchar(150), in dirCli varchar(150), in tCli varchar(10),in codTCli int, in codMPag int)
      begin
         update Cliente C 
            set C.apellidosCliente = aCli, C.nombresCliente = nCli, C.direccionCliente = dirCli, C.telefonoCliente = tCli, C.codigoTipoCliente = codTCli, C.codigoMetodoDePago = codMPag
               where C.codigoCliente = codCli;
      end$$
delimiter ;

-- call sp_editarCliente();

-- --- Procedimientos almacenados Tipo Paquete --- --

 

-- --- Agregar TipoPaquete --- --
Delimiter $$
    Create procedure sp_AgregarTipoPaquete (in codigoTipoPaquete int, in descripcionTipoPaquete varchar(100))
        Begin
            Insert into TipoPaquete(codigoTipoPaquete, descripcionTipoPaquete)
                values(codigoTipoPaquete, descripcionTipoPaquete);
        End$$
Delimiter ;

 

call sp_AgregarTipoPaquete(20, "Fragil");
call sp_AgregarTipoPaquete(21, "Pesado");
call sp_AgregarTipoPaquete(22, "inframable");
call sp_AgregarTipoPaquete(23, "Ligero");

 

-- --- Listar TipoPaquete --- --
Delimiter $$
    Create procedure sp_ListarTipoPaquetes ()
        Begin
            Select 
                T.codigoTipoPaquete,
                T.descripcionTipoPaquete
            From TipoPaquete T;
        End$$
Delimiter ;

 

call sp_ListarTipoPaquetes();

 

-- --- Buscar TipoPaquete --- --
Delimiter $$
    Create procedure sp_BuscarTipoPaquete (in codigoTipoPaquete int)
        Begin
            Select
                T.codigoTipoPaquete,
                T.descripcionTipoPaquete
            From TipoPaquete T
                where T.codigoTipoPaquete = codigoTipoPaquete;
        End$$
Delimiter ;

 

call sp_BuscarTipoPaquete(20);

 

-- --- EditarTipoPaquete --- --
Delimiter $$
    Create procedure sp_EditarTipoPaquete(in codigoTipoPaquete int, in descripcionTipoPaquete varchar(100))
        Begin
            Update TipoPaquete T
                set T.descripcionTipoPaquete = descripcionTipoPaquete
                    where T.codigoTipoPaquete = codigoTipoPaquete;
        End$$
Delimiter ;

 

-- --- Eliminar TipoPaquete --- --
Delimiter $$
    Create procedure sp_EliminarTipoPaquete (in codTipoPaquete int)
        Begin
            Delete from TipoPaquete
                where codigoTipoPaquete = codTipoPaquete;
        End$$
Delimiter ;

-- -----------------------------------Agregar Paquete-----------------------------------------------

delimiter $$
   create procedure sp_agregarPaquete(in tPaq varchar(150), in pPaq varchar(150), in con varchar(150), in codTPaq int)
      begin
         insert into Paquete(tamañoPaquete, pesoPaquete, contenido, codigoTipoPaquete)
            values(tPaq, pPaq, con, codTPaq);
      end$$
delimiter ;

call sp_agregarPaquete('Grande', '10 kg', 'Ropa', 20);
call sp_agregarPaquete('Pequeño', '12 kg', 'Juguetes', 22);
call sp_agregarPaquete('Mediano', '32 kg', 'Computadora', 21);
call sp_agregarPaquete('Pequeño', '18 kg', 'Microfono', 23);

-- ------------------------------------Listar Paquete-----------------------------------------------

delimiter $$
   create procedure sp_listarPaquetes()
      begin
         select 
            P.codigoPaquete, 
            P.tamañoPaquete, 
            P.pesoPaquete, 
            P.contenido, 
            P.codigoTipoPaquete
		 from Paquete P;
      end$$
delimiter ;

call sp_listarPaquetes();

-- ------------------------------------Buscar Paquete-----------------------------------------------

delimiter $$
   create procedure sp_buscarPaquete(in codPaq int)
      begin
         select 
            P.codigoPaquete, 
            P.tamañoPaquete, 
            P.pesoPaquete, 
            P.contenido, 
            P.codigoTipoPaquete
         from Paquete P where P.codigoPaquete = codPaq;
      end$$
delimiter ;

call sp_buscarPaquete(3);

-- ------------------------------------Eliminar Paquete---------------------------------------------

delimiter $$
   create procedure sp_eliminarPaquete(in codPaq int)
       begin
          delete from Paquete
             where Paquete.codigoPaquete = codPaq;
       end$$
delimiter ;

-- call sp_eliminarPaquete(3);

-- ------------------------------------Editar Paquete-----------------------------------------------


delimiter $$
   create procedure sp_editarPaquete(in codPaq int, in tPaq varchar(150), in pPaq varchar(150), in cont varchar(150), in codTPaq int)
      begin
         update Paquete P 
            set P.tamañoPaquete = tPaq, P.pesoPaquete = pPaq, P.contenido = cont, P.codigoTipoPaquete = codTPaq
               where P.codigoPaquete = codPaq;
      end$$
delimiter ;

-- call sp_editarPaquete();


 -- --- Procedimientos Almacenados Ruta --- --

 

-- --- Agregar Ruta --- --
Delimiter $$
    Create procedure sp_AgregarRuta (in codigoRuta int, in distancia varchar(100), in medioDeTransporte varchar(100), in estadoRuta varchar(100))
        Begin
            Insert into Ruta (codigoRuta, distancia, medioDeTransporte, estadoRuta)
                values(codigoRuta, distancia, medioDeTransporte, estadoRuta);
        End$$
Delimiter ;

 

call sp_AgregarRuta(120, "32 Km", "Carro", "Segura");
call sp_AgregarRuta(121, "10 Km", "Moto", "Con trafico, Seguro");
call sp_AgregarRuta(122, "20 Km", "Carro", "Accidentado");
call sp_AgregarRuta(123, "20 Km", "Moto", "Seguro");

 

-- --- Listar Rutas --- --
Delimiter $$
    Create procedure sp_ListarRutas ()
    Begin
        Select
            R.codigoRuta,
            R.distancia,
            R.medioDeTransporte,
            R.estadoRuta
        From Ruta R;
    End$$
Delimiter ;

 

call sp_ListarRutas();

 

-- --- Buscar Ruta --- --
Delimiter $$
    Create procedure sp_BuscarRuta(in codigoRuta int)
        Begin
            Select 
                R.codigoRuta,
                R.distancia,
                R.medioDeTransporte,
                R.estadoRuta
            From Ruta R
                where R.codigoRuta = codigoRuta;
        End$$
Delimiter ;

 

call sp_BuscarRuta(121);

 

-- --- Editar Ruta --- --
Delimiter $$
    Create procedure sp_EditarRuta(in codigoRuta int, in distancia varchar(100), in medioDeTransporte varchar(100), in estadoRuta varchar(100))
        Begin
            Update Ruta R
                set R.distancia = distancia, R.medioDeTransporte = medioDeTransporte, R.estadoRuta = estadoRuta
                    where R.codigoRuta = codigoRuta;
        End$$
Delimiter ;

 

-- --- Eliminar Ruta --- --
Delimiter $$
    Create procedure sp_EliminarRuta(in codRuta int)
        Begin
            Delete from Ruta
                where codigoRuta = codRuta;
        End$$
Delimiter ;






