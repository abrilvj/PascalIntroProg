procedure abrirArchuvo(var archivo:tarch; nombre:String; var error:Boolean);
begin
    error := false;
    assign(archivo, nombre);
    {$I-} 
    reset(archivo); 
    {$I+} { activa la verificación de errores entrada/salida}
    if ioresult <> 0 then
        error := true;
end;

var archivo :tarch;
    nombre : String;
    error : Boolean;
begin
    writeln('Ingresar nombre del archivo:');
    readln(nombre);
    abrirArch(archivo, nombre, error);
    if not error then 
        tratar(archivo);
    close(archivo);
end.
