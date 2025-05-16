function [A_gauss] = Gauss_elimnation(A)
[m,n] = size(A);
    if m ~= n
        error('Macierz nie jest kwadratowa');
    end
[n,n] = size(A);
M = [A eye(n)];
for i = 1:n 
    %znajdujemy indeksu wiersza z maksymalną wartością bezwzględną w określonej kolumnie macierzy M
    [~,maxrow] = max(abs(M(i:n,i)));
    %(ponieważ funkcja max zwraca indeks odniesienia do podmacierzy, która zaczyna się od i-tego wiersza
    maxrow = maxrow + i - 1;
    if maxrow ~= i
        %, aby maksymalna wartość bezwzględna znajdowała się na diagonali macierzy.
        M([i,maxrow],:) = M([maxrow,i],:);
    end
    %wykonujemy eliminację Gaussa
    for j = i+1:n
        %W każdej iteracji odejmujemy odpowiednią wielokrotność wiersza i od wiersza j
        M(j,:) = M(j,:) - M(i,:) * (M(j,i) / M(i,i));
    end
end
for i = n:-1:1
    %odejmujemy odpowiednią wielokrotność wiersza i od wiersza j, aby wyzerować element j,i macierzy M.
    for j = i-1:-1:1
        M(j,:) = M(j,:) - M(i,:) * (M(j,i) / M(i,i));
    end
    %dzielimy wiersz i przez wartość M(i,i)
    M(i,:) = M(i,:) / M(i,i);
end
A_gauss = M(:, n+1:end);
end