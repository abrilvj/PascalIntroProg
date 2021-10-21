Procedure recorrer_entre_cotas(árbol:parbol; cotamin,cotamax:integer);
begin
    if (árbol <> NIL) then
        if (árbol^.dato < cotamax) then begin
           recorrer_entre_cotas(árbol^.der, cotamin,cotamax);
           if (árbol^.dato > cotamin) then begin
               Tratar(arbol);
               recorrer_entre_cotas(árbol^.izq, cotamin,cotamax);
            end;
        end else
            if (árbol^.dato > cotamin) then
               recorrer_entre_cotas(árbol^.izq, cotamin,cotamax);
end;

// RECORRER EL ARBOL CON COTA MAXIMA:

Procedure recorrer_menor_a_cota_preorden(árbol:parbol; cota:integer);
Begin
    if (árbol <> NIL) then
        if (árbol^.dato < cota) then begin
            Tratar(arbol);
            recorrer_menor_a_cota_preorden(árbol^.der, cota);
        end;
     recorrer_menor_a_cota_preorden(árbol^.izq, cota);
End;

Procedure recorrer_menor_a_cota_inorden(árbol:parbol; cota:integer);
Begin
    if (árbol <> NIL) then
        if (árbol^.dato < cota) then begin
            recorrer_menor_a_cota_inorden(árbol^.der, cota);
            Tratar(arbol);
        end;
    recorrer_menor_a_cota_inorden(árbol^.izq, cota);
End;

Procedure recorrer_menor_a_cota_inorden(árbol:parbol; cota:integer);
Begin
    if (árbol <> NIL) then
        recorrer_menor_a_cota_inorden(árbol^.izq, cota);
    if (árbol^.dato < cota) then begin
        Tratar(arbol);
        recorrer_menor_a_cota_inorden(árbol^.der, cota);
    end;
End;

