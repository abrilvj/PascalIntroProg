// Carga un arbol con 20 valores random

procedure Insertar(var arbol: tArbol; numero: Integer);
begin
    if (arbol = nil) then begin
        new(arbol);
        writeln('Insertando ', numero);
        arbol^.num := numero;
        arbol^.ant := nil;
        arbol^.sig := nil;
    end else
        if (arbol^.num > numero) then
            Insertar(arbol^.ant, numero)
        else
            Insertar(arbol^.sig, numero);
end;

procedure CargarArbol(var arbol: tArbol);
var i: Integer;
begin
    Randomize;
    for i := 1 to 20 do
        Insertar(arbol, Random(100));
end;
