procedure CargarLista (var lista: tipoLista);
var cursor: tipoLista;
    valor:integer;
begin
    Lista := Nil; 
    Readln(Valor); 
    if (Valor > 0) then begin
        New(Lista);
        Lista^.Sig := Nil;
        Lista^.Num := Valor;
        Cursor := Lista;
        Readln(Valor);
        While (Valor > 0) do begin
            New(Cursor^.Sig);
            Cursor := Cursor^.Sig;
            Cursor^.Sig := Nil;
            Cursor^.Num := Valor;
            Readln(Valor);
        end;
    end;
end;
