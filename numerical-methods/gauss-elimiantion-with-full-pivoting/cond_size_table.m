function [tables] = cond_size_table()
% Tabela zależności współczynnika uwarunkowania od rozmiaru macierzy kwadratowej
% dla rozmiarów macierzy od 1 do 201 z krokiem co 10.

tables = table('Size', [40, 2], 'VariableTypes', {'double', 'double'}, 'VariableNames', {'Size', 'Cond'});

for i=1:40
    A = randn(i*10);
    cond_A = cond(A);
    tables(i,:) = {i*10, cond_A};
end

end

