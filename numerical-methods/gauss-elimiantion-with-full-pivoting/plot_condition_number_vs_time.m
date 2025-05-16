function plot_condition_number_vs_time(n)





% Inicjalizacja tablicy czasów wykonania eliminacji Gaussa z pełnym wyborem elementu głównego
times = zeros(n, 1);
condA = zeros(n,1);
% Wykonanie eliminacji Gaussa z pełnym wyborem elementu głównego dla coraz większych macierzy
for i = 1:n
    A = randn(n);
    condA(i) = cond(A);
    % Pomiar czasu wykonania eliminacji Gaussa z pełnym wyborem elementu głównego
    tic;
    [A_gauss] = Gauss_elimnation(A);
    t = toc;
    
    % Dodanie czasu do tablicy times
    times(i) = t;
end

% Tworzenie wykresu
plot(times, condA);
xlabel('Czas wykonania eliminacji Gaussa z pełnym wyborem elementu głównego');
ylabel('Uwarunkowanie macierzy');
title(sprintf('Uwarunkowanie macierzy vs czas dla n = %d', n));
end
