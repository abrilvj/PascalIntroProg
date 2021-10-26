Function EsCapicua(ar:arrInt; init,fin:integer):boolean;
begin
    if (init >= fin) then
        EsCapicua:= true
    else
        if (ar[init] = ar[fin]) then
            EsCapicua:= Escapicua( ar, init+1, fin-1)
        else
            EsCapicua:= false
end;
