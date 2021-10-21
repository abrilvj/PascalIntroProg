Program TrabajoPractico;

type PuntArbol = ^NodoArbol;
 NodoArbol = record
  nombre: string;
  victorias: integer;
  ant, sig : PuntArbol;
  end;
  
type PuntLista = ^NodoLista;
 NodoLista = record
  letra : char;
  pregunta : string;
  respuesta : string;
  Rcorrecta : string;
  sig : PuntLista ;
  end;
  
 
type reg_palabra = record
 nro_set : integer;
 letra : char;
 palabra : string;
 consigna : string;
 end;
 
 
type  ArchP = file of reg_palabra ;


type Eljuego = record
 nombre : string;
 puntero : PuntLista ;
 end;
 
 
type Arreglo = array [1..2] of Eljuego;

 
type Jugadores_dat = record
 nombre : string;
 victorias : integer;
 end;
 

type ArchJD = file of Jugadores_dat;



// cargado y agregado de jugadores

// esta funcion determinara si el jugador ingresado ya forma parte del arbol o no. 

function EstaJugador (arbol: PuntArbol ; participante: string) : boolean; 

 begin
  
    if arbol = nil then 
     EstaJugador:= false 
    else 
     if arbol^.nombre = participante then
      begin
       EstaJugador := true;
       writeln (' el jugador pertenece a la base de datos ' );
      end
        else 
        begin
         if ( participante < arbol^.nombre ) then
        EstaJugador := EstaJugador ( arbol^.ant, participante )
         else 
        EstaJugador := EstaJugador ( arbol^.sig, participante ) 
        end;
 end;     


// este procedimiento inserta el nodo cargado con informacion al arbol. 

procedure InsertarNodoArbol (var arbol: PuntArbol; NodoCarg: PuntArbol );
    begin
    
       If (arbol = nil) then
        begin
         arbol := NodoCarg
        end
      else
        If (arbol^.nombre < NodoCarg^.nombre) then
          InsertarNodoArbol(Arbol^.sig, NodoCarg)
        else
          InsertarNodoArbol(Arbol^.ant, NodoCarg);
    
    end;


// en los proximos dos procedimientos si ya existen jugadores en el archivo se cargaran en el arbol.
procedure CargarNodoArchivoConDatos ( var Nodo : PuntArbol ; datos : Jugadores_dat);
 
  begin
    new(Nodo);
    Nodo^.nombre := datos.nombre;
    Nodo^.victorias := datos.victorias;
    Nodo^.ant := nil;
    Nodo^.sig := nil;
 
 end;
 
procedure PasarArchivoAArbol( var arbol : PuntArbol ; var archivo:ArchJD  );

 var 
  Nodo : PuntArbol;
  datos : Jugadores_dat;
  

 begin
  
   
  while not eof (archivo) do
   begin
   
   read (archivo, datos);
   CargarNodoArchivoConDatos ( Nodo, datos);
   InsertarNodoArbol (arbol, Nodo );
    
   end;
 
 end;


// este procedure agregara al jugador en el archivo de participantes y con su registro de victorias en 0. 
procedure AgregarJugadorAlArchivo (var Archivo: ArchJD; participante: string);
    var
    
     datos: Jugadores_dat;
     
    begin
      
      
      datos.nombre := participante;
      datos.victorias := 0;
      seek (Archivo, filesize(Archivo));
      write(Archivo, datos);
     
      
    end;

// este procedimiento se encargara de llamar a todas las partes del enunciado 1 que trabajaran en conjunto.
procedure Total1 ( var arbol : puntarbol ; var archivo : ArchJD);
 
  var
   nodo : PuntArbol;
   participante : string;
   dat: Jugadores_dat;
  
   begin
  
   
    writeln('ingrese el nombre del jugador');
    readln(participante);
    
   
    If  (EstaJugador(arbol, participante) = False) then
   begin     
      dat.nombre := participante;
      dat.victorias := 0;
      CargarNodoArchivoConDatos (nodo, dat);
      InsertarNodoArbol(arbol , nodo);
      AgregarJugadorAlArchivo ( Archivo,participante);
   end
   else
   writeln('ya existe este jugador en el arbol');
    
end;    
 
// mostrar lista de jugadores    

// este procedure a partir del recorrido in-order del arbol jugadores mostrara la lista completa de los mismos con sus respectivas victorias. 
procedure MostrarArbolDeJugadores (arbol:PuntArbol);
      
      var
        
         nodo : PuntArbol;
      
     begin
          nodo := arbol;
         
         if nodo <> nil then
          begin
           MostrarArbolDeJugadores ( arbol ^.ant);
            writeln;
            writeln;
            writeln (nodo^.nombre, '.  victorias:  ', nodo^.victorias);
            writeln;
             MostrarArbolDeJugadores ( arbol ^.sig);
         end;
    end;


// jugar

// esta funcion comprueba que los jugadores ingresados para jugar sean distintos.
function Jugadores_Dist ( jugador1, jugador2 : string ) : boolean;
 
  begin
   
    if jugador1 = jugador2 then
     begin
      writeln(' los jugadores ingresados son iguales. No se podra comenzar con el juego');
      Jugadores_Dist := false 
     end
    else
    Jugadores_Dist := true;
    
  end;
  

// esta funcion llama a jugadores distintos y a estajugador en el arbol si ambos resultan verdaderos se podra jugar
function SePuedeJugar (   jugador1, jugador2 : string ; arbol : PuntArbol  ) : boolean;
    var condicion:boolean;
    begin
        condicion:=true;
        writeln ( 'se comprobaran condiciones de juego' ) ;
        
        if Jugadores_Dist ( jugador1, jugador2 ) = false then
         begin
             writeln (' los jugadores ingresados NO son distintos');
             condicion := false;
         END ;   
        if  EstaJugador ( arbol, jugador1 )= false then
        begin
            writeln ('El jugador 1 no existe en la base de datos');
            condicion := false;
        end;
        if  EstaJugador ( arbol, jugador2 ) = false then
        begin 
            writeln ('El jugador 2 no existe en la base de datos');
            condicion := false ;
        end;
        
        SePuedeJugar := condicion;
    
    end;


// este procedimiento me cargara un nodo que luego pertenecera a la lista circular
procedure CrearNodoLista ( var nodoL : PuntLista ; var informacion : ArchP ) ;

  var
   datos : reg_palabra;
   estado_respuesta : string;
  begin
     
      estado_respuesta := 'pp';
       read ( informacion, datos);
       new(nodoL);
        nodoL^.letra := datos.letra;
        nodoL^.pregunta := datos.consigna;
        nodoL^.respuesta := estado_respuesta ;
        nodoL^.Rcorrecta := datos.palabra;
        nodoL^.sig := nil;
    
  end;

// este procedimiento insertara los nodos cargados en la lista
procedure InsertarNodoEnLista ( nodoL : PuntLista ; var Lista : PuntLista );
 
  begin
   
    if Lista = nil then
     Lista := nodoL
    else 
     InsertarNodoEnLista ( nodoL, Lista^.sig );
   end;

// este procedimiento enlazara el ultimo lugar con el primer lugar formando una lista circular    
procedure ListaSeVuelveCircular ( var Lista : PuntLista; puntero: PuntLista);
   
  
  begin
     
     if ( Lista <> nil) then
      ListaSeVuelveCircular ( Lista^.sig, puntero )
    else
     Lista := puntero;
  end;
  
 // este procedimento llamara a los procedimientos encargados de la creacion de la lista y se hace un randomize para elegir aleatoriamente el set de preguntas 
procedure CreacionLista ( var Lista : PuntLista ; var archivoP : ArchP );
 
  var
  nodoL, principal : PuntLista;
  contador, maxabc, Nro_Set: integer;
  
  begin
 
   contador := 1;
   maxabc := 26;

   reset (archivoP);
   Nro_Set := Random(5) + 1;
   writeln ('El numero de Set es:', Nro_Set);
   Nro_Set := ((Nro_Set - 1)* maxabc);
   seek (archivoP, Nro_Set);
   CrearNodoLista ( nodoL, archivoP);
   InsertarNodoEnLista ( nodoL, Lista);  
   principal := Lista; // me guardo la primer posicion de la lista para luego poder hacerla circular
   contador:= contador +1;
   while (contador <= maxabc) do
     begin
      
       CrearNodoLista ( nodoL, archivoP);
       InsertarNodoEnLista ( nodoL, Lista);
       contador := contador + 1;
       
     end;
   
   ListaSeVuelveCircular ( Lista, principal);
   
  end;
 
 // este procedimiento carga el arreglo con el nombre y el puntero que apunta a la lista
procedure CargarArreglo (var partida : Arreglo; datlist1, datlist2 : Eljuego );  
  
  begin
    partida[1] := datlist1;
    partida[2] := datlist2;
  end;
  
  
  
  
// esta funcion me busca si en mi lista hay preguntas pendientes para responder 
function BuscarPrgPendientes ( lista : PuntLista; principio : PuntLista ) : boolean;
  begin
  if (lista= nil) then
   BuscarPrgPendientes := false; // en el caso de que me quede una lista de tamaño 1 
  if lista^.respuesta = 'pp' then
   BuscarPrgPendientes := true
   else  if (lista <> principio ) then
   BuscarPrgPendientes := BuscarPrgPendientes ( lista^.sig, principio)
   else 
   BuscarPrgPendientes := false;

  end;

procedure Pregunta (lista : PuntLista) ;
  var
  respuesta: string;
  
  begin
   
   if lista^.respuesta <> 'pp' then
    Pregunta (lista^.sig)
    
   else if lista^.respuesta = 'pp' then
   begin
    writeln (lista^.letra);
    writeln (lista^.pregunta);
    writeln('Ingrese su respuesta');
    readln(respuesta);
   
   
   if lista^.Rcorrecta = respuesta then
    begin
     lista^.respuesta := 'acertada';
     writeln('respuesta correcta');
     Pregunta (lista^.sig);
    end

    else 
      begin
      lista^.respuesta := 'errada';
      writeln('respuesta erronea');
      end;

  end;
  end;

 
 
// este procedimiento se encarga de llamar a todas las partes de jugar y asi poder comenzar el juego o no.
procedure Jugar ( arbol: PuntArbol;var archivoJug: ArchJD ; var archivoPreg : ArchP ; var partida : Arreglo );
    var
      jugador1, jugador2 : string;
       lista1 , lista2 : PuntLista;
       datlist1, datlist2 : Eljuego;
      
      begin
       
        writeln ('ingrese nombre de los jugadores 1 y 2 respectivamente');
        readln ( jugador1);
        readln ( jugador2);
        
          if (SePuedeJugar (jugador1,jugador2, arbol)) then
            begin 
              writeln('se puede jugar');
          
                CreacionLista ( lista1, archivoPreg);      
                datlist1.nombre := jugador1;
                datlist1.puntero := lista1;
           
               CreacionLista ( lista2, archivoPreg);
               datlist2.nombre := jugador2;
               datlist2.puntero := lista2;
              
              CargarArreglo (partida, datlist1, datlist2 );  
              
              While (BuscarPrgPendientes (partida [1].puntero^.sig, partida[1].puntero)) and (BuscarPrgPendientes(partida[2].puntero^.sig ,partida[2].puntero) ) do
                begin
                
                 if  BuscarPrgPendientes (partida [1].puntero^.sig, partida[1].puntero)  then
                   begin
                    writeln('Responde ', jugador1);
                    Pregunta (partida[1].puntero);
                    
                   end;
                if  BuscarPrgPendientes (partida [2].puntero^.sig, partida[2].puntero)  then
                   begin
                    writeln('Responde ', jugador2);
                    Pregunta (partida[2].puntero);
                    
                   end;
     
             end;    
            end
         else
          writeln('no se puede jugar');
      
        END;



function CantDeAcertadas (lista : PuntLista ; principio : PuntLista): integer;
     begin
       
       if (lista = nil) then
        CantDeAcertadas:= 0
       else if (lista = principio) then
         begin
          if (lista^.respuesta = 'acertada') then
           CantDeAcertadas:= 1
           else
           CantDeAcertadas:= 0;
         end
       else if (lista^.respuesta = 'acertada') then
        CantDeAcertadas:= 1+ CantDeAcertadas (lista^.sig, principio)
       else
        CantDeAcertadas:= CantDeAcertadas (lista^.sig, principio);
     end; 
 


// este procedimiento actualizara las victorias de los jugadores en el arbol 
procedure ActualizarVictoriasArbol (var arbol: PuntArbol; nombre: string);

 begin
  
   if (arbol^.nombre = nombre) then
    arbol^.victorias := arbol^.victorias + 1 
   else
    if (arbol^.nombre < nombre) then
    ActualizarVictoriasArbol (arbol^.sig, nombre)
   else
    ActualizarVictoriasArbol (arbol^.ant, nombre);
 
 end;    
    
procedure ActualizarVictoriasArchivo (var archivo: ArchJD; nombre : string);
  
  var
   datos : Jugadores_dat;
  posicion: integer;
  begin
   reset(archivo);
   read (archivo, datos);
  while not eof (archivo) do
  begin
   if (datos.nombre = nombre) then
      begin  
      posicion:= filepos(archivo);
      posicion:=posicion-1;
      seek(archivo, posicion);
      datos.victorias := datos.victorias + 1;
      write (archivo,datos);
      posicion:=filesize(archivo);
      seek(archivo,posicion);
      end
    else     
     read(archivo,datos);
  end; 
  writeln(' termino de actualizar el archivo');
end;


procedure QuienGano (var archivo: ArchJD ; var Arbol: PuntArbol; partida : Arreglo);
    var 
    
    jug1, jug2 : Eljuego;
    cant1, cant2 : integer;
     begin
     
     jug1 := partida [1];
     cant1 := CantDeAcertadas (jug1.puntero^.sig ,jug1.puntero);
     jug2 := partida [2];
     cant2 := CantDeAcertadas (jug2.puntero^.sig, jug2.puntero);
     
     
     if (cant1 = cant2) then
      writeln('fue empate')
      else
     if (cant1 < cant2) then
       begin
       writeln('gano:',jug2.nombre);
       ActualizarVictoriasArbol (arbol, jug2.nombre);
       ActualizarVictoriasArchivo (archivo, jug2.nombre);
       end
       else
     if (cant1 > cant2 ) then
       begin
        writeln ('gano:', jug1.nombre);
        ActualizarVictoriasArbol (arbol, jug1.nombre);
        ActualizarVictoriasArchivo (archivo, jug1.nombre);
       end;
     end;


 

// salir


//////////////////////////////MENU/////////////////////////////////////////

procedure MostrarMenu ();

begin
     writeln ('Marque con el teclado la OPCION deseada');
     writeln;
     writeln;
     writeln ( ' Seleccione opcion 1 si desea agregar un jugador NUEVO ');
     writeln;
     writeln ( ' Seleccione opcion 2 si desea ver la lista de jugadores ');
     writeln;
     writeln ( ' Seleccione opcion 3 si desea comenzar a jugar ');
     writeln;
     writeln ( ' Seleccione opcion 4 si desea salir ');

end;


procedure Menu ( var archivo : ArchJD ; var Arbol : PuntArbol; var archivoPregunt : ArchP);
 var
  
  opcion : integer;
  jugadores : Arreglo;
   begin
     
   MostrarMenu ();
     readln (opcion);
     
      while (opcion >= 1) and (opcion < 4)do
         
         begin
          if opcion = 1 then
             begin
             Total1 ( arbol, archivo);
             end;
             
          if opcion = 2 then
             begin
             MostrarArbolDeJugadores (arbol);
             end;
         
         if opcion = 3 then
             begin
               // aca va el arreglo mepa
               Jugar ( Arbol, archivo, archivoPregunt, jugadores );
               QuienGano (archivo , arbol, jugadores);
             end;

        MostrarMenu();  
        readln (opcion);
       end;
   
  end;


// programa principal //

var
 
// no tiene q estar en el principal tiene q estar en menu. y no se tiene que llamar arreglito ..arreglito : Arreglo;
 Arbol: puntarbol;
 archivo : ArchJD;
 archivoPregunta : ArchP;
 
 
begin
  Randomize;
  assign(archivo, '/ip2/NazarenoRuiz-jugadores.dat');
  assign (archivoPregunt, '/ip2/palabras.dat');
  reset(archivo);
  reset (archivoPregunt);
  PasarArchivoAArbol(Arbol, archivo);
  Menu ( archivo,  Arbol, archivoPregunta);
  close(archivo);
  close(archivoPregunt);
END.
