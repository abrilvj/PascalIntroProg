// InOrder: imprime los hijos menores, luego el nodo, y luego los hijos mayores
// Se utiliza para imprimir los valores de los nodos de un arbol ordenado, en orden ascendente o descendente
procedure InOrder (var arbol: tArbol);
begin
    if (arbol <> nil) then begin
        InOrder(arbol^.izq);
        Tratar(arbol);
        InOrder(arbol^.der);
    end;
end;

// PreOrder: imprime primero el nodo, luego los hijos menores, y luego los hijos mayores
// Se utiliza para crear una copia del arbol
procedure PreOrder (var arbol: tArbol);
begin
    if (arbol <> nil) then begin
        Tratar(arbol);
        InOrder(arbol^.izq);
        InOrder(arbol^.der);
    end;
end;

// PostOrder: imprime primero los hijos menores, luego los hijos mayores, y luego el nodo
// Se utiliza para eliminar un arbol por completo
procedure PostOrder (var arbol: tArbol);
begin
    if (arbol <> nil) then begin
        InOrder(arbol^.izq);
        InOrder(arbol^.der);
        Tratar(arbol);
    end;
end;
