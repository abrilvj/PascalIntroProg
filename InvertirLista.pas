function GeneraListaInvertida(listaAlumnos: PListaAlumnos): PListaInvertida;
var listaInvertida, nuevoNodo: PListaInvertida;
begin
    listaInvertida := nil;
    
    while (listaAlumnos <> nil) do begin
        new(nuevoNodo);
        nuevoNodo^.alumno := listaAlumnos;
        nuevoNodo^.sig := nil;
        InsertarOrdenadoAlfabeticamente(listaInvertida, nuevoNodo);
        listaAlumnos := listaAlumnos^.sig;
    end;
    
    GeneraListaInvertida := listaInvertida;
end;
