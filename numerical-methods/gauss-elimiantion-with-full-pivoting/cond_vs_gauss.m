function createGaussTable(n)
% n - rozmiar macierzy kwadratowej A

table = zeros(n, 2);

for i = 1:n
    % Generowanie losowej macierzy kwadratowej o rozmiarze i x i
    A = rand(n);
    
    % Obliczanie wskaźnika uwarunkowania macierzy A
    cond_A = cond(A);
    
    % Pomiar czasu działania funkcji eliminacji Gaussa
    tic;
    Gauss_elimnation(A);
    t = toc;
    
    % Dodanie wartości do tabeli
    table(i, 1) = cond_A;
    table(i, 2) = t;
end

table(cond_A', t, 'VariableNames', {'condA', 'GaussTime'})
end
