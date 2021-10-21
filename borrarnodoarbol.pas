procedure Borrar (var arbol: puntArbol; numero:integer);
// Borra un nodo de un arbol binario dado el numero que posee el nodo
var aux: puntArbol;
begin
    if (arbol <> nil) then begin
        if (numero < arbol^.num) then
            Borrar(arbol^.ant, numero)
        else if (numero > arbol^.num) then
            Borrar(arbol^.sig, numero)
        else begin
            if (arbol^.ant = nil) and (arbol^.sig = nil) then begin
                dispose(arbol);
                arbol := nil;
            end else if (arbol^.ant = nil) then begin
                aux := arbol;
                arbol := arbol^.sig;
                dispose(aux);
                aux := nil;
            end else if (arbol^.sig = nil) then begin
                aux := arbol;
                arbol := arbol^.ant;
                dispose(aux);
                aux := nil;
            end else begin
                aux := BuscaMayor(arbol^.ant);
                arbol^.num := aux^.num;
                Borrar(arbol^.ant, arbol^.num);
            end;
        end;
    end else
        WriteLn('No se ha encontrado el numero ingresado en el arbol');
end;
