program MergeSort;
{ 9. Merge sort: este método de ordenamiento trabaja de la siguiente manera: dada una lista se
divide en dos mitades, se ordena cada mitad (para lo cual se puede aplicar recursión) y
después se intercalan las mitades. (el procedimiento para intercalar es muy simple: se
compara las cabezas de las listas y se toma la menor). }

Type TLista = ^TNodo;
    
    TNodo = record
            num: integer;
            sig: TLista;
    end;
    
procedure CargarLista (var lista: tLista);
var cursor: tLista;
    valor:integer;
begin
    Lista := Nil; 
    Readln(Valor); 
    if (Valor <> 0) then 
    Begin
        New(Lista);
        Lista^.Sig := Nil;
        Lista^.Num := Valor;
        Cursor := Lista;
        Readln(Valor);
        While (Valor <> 0) do 
        Begin
            New(Cursor^.Sig);
            Cursor := Cursor^.Sig;
            Cursor^.Sig := Nil;
            Cursor^.Num := Valor;
            Readln(Valor);
        End;
    End;
end;
    
function CantidadElementos (var lista: tLista):integer;
begin
    if (lista <> nil) then
        CantidadElementos := 1 + CantidadElementos(lista^.sig)
    else
        CantidadElementos := 0;
end;

procedure DividirLista (var lista, mitad1, mitad2: tLista);
var i, mitad:integer;
begin
    mitad := CantidadElementos(lista) div 2;
    mitad1 := lista;
    i := 1;
    while (i < mitad) do begin
        lista := lista^.sig;
        i := i + 1;
    end;
    mitad2 := lista^.sig;
    lista^.sig := nil;
    lista := nil;
end;
    
procedure InsertarAlFinal (var lista, nuevo: tLista);
begin
    if (lista = nil) then
        lista := nuevo
    else
        InsertarAlFinal(lista^.sig, nuevo);
end;
    
procedure Intercalar (var lista, mitad1, mitad2 : tLista);
var nuevo: tLista;
begin
    nuevo := nil;
    if (mitad1 <> nil) and (mitad2 <> nil) then begin
        if (mitad1^.num < mitad2^.num) then begin
            nuevo := mitad1;
            mitad1 := mitad1^.sig;
        end else begin
            nuevo := mitad2;
            mitad2 := mitad2^.sig;
        end;
    end else if (mitad1 <> nil) then begin
        nuevo := mitad1;
        mitad1 := mitad1^.sig;
    end else if (mitad2 <> nil) then begin
        nuevo := mitad2;
        mitad2 := mitad2^.sig;
    end;
    if (nuevo <> nil) then begin
        nuevo^.sig := nil;
        InsertarAlFinal(lista, nuevo);
        Intercalar(lista, mitad1, mitad2);
    end;
end;
    
procedure MergeSort (var lista: tLista);
var mitad1, mitad2: tLista;
begin
    if (CantidadElementos(lista) > 1) then begin
        DividirLista(lista, mitad1, mitad2);
        MergeSort(mitad1);
        MergeSort(mitad2);
        Intercalar(lista, mitad1, mitad2);
    end;
end;

procedure MostrarLista (lista: tLista);
begin
    if (lista <> nil) then begin
        Write(lista^.num, ' ');
        MostrarLista(lista^.sig);
    end;
end;

var lista: tLista;
begin
    lista := nil;
    CargarLista(lista);
    MostrarLista(lista);
    MergeSort(lista);
    WriteLn('');
    MostrarLista(lista);
end.
