function [errors] = inverseMatrixErrorTable(maxSize)
% Funkcja tworząca tabelkę z wynikami oraz zwracająca błędy względne i bezwzględne dla macierzy odwrotnych
% wyznaczonych za pomocą funkcji wbudowanej oraz eliminacji Gaussa w zależności od rozmiaru macierzy.

% Inicjalizacja tabeli wynikowej
errorTable = zeros(floor(maxSize/10), 3);
count = 1;

% Iteracja po rozmiarach macierzy
for n = 1:10:maxSize
    % Generowanie losowej macierzy kwadratowej o rozmiarze n x n
    A = rand(n);
    
    % Wyznaczanie macierzy odwrotnej za pomocą funkcji wbudowanej inv()
    invA_builtin = inv(A);
    
    % Wyznaczanie macierzy odwrotnej za pomocą eliminacji Gaussa
    invA_gauss = Gauss_elimnation(A);
    
    % Obliczanie błędów względnych i bezwzględnych
    error_builtin = norm(invA_builtin - invA_gauss, 'fro') / norm(invA_builtin, 'fro');
    error_abs = norm(invA_builtin - invA_gauss, 'fro');
    errorTable(count, 1) = n;
    errorTable(count, 2) = error_builtin;
    errorTable(count, 3) = error_abs;
    count = count + 1;
end

% Tworzenie tabelki
T2 = array2table(errorTable, 'VariableNames', {'Rozmiar_macierzy', 'Blad_wzgledny', 'Blad_bezwzgledny'});

% Wyświetlenie tabelki
disp(T2);
% Rysowanie wykresu
n = 10:10:maxSize;
rel_err = errorTable(:, 2);
plot(n, rel_err, 'bo-');
xlabel('Rozmiar macierzy');
ylabel('Blad wzgledny');
title('Wykres bledu wzglednego dla macierzy odwrotnych');
grid on;


[errors] = T2
end
