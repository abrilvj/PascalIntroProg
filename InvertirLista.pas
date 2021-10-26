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

procedure ReverseList(var list: tipoLista);
var curr, prev, next: TipoLista;
begin
    prev := nil;
    curr := list;
    while curr <> nil do
    begin
        next := curr^.sig;
        curr^.sig := prev;
        prev := curr;
        curr := next
    end;
    list := prev
end; 
