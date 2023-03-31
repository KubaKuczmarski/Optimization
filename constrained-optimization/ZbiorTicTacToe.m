clear all

% Wczytanie danych tic-tac-toe.dat przydzielonych w projekcie
TicTacToe = readtable('tic-tac-toe.dat'); 
VarNames = {'TopLeft', 'TopMiddle', 'TopRight', 'MiddleLeft', 'MiddleMiddle', 'MiddleRight', 'BottomLeft', 'BottomMiddle', 'BottomRight', 'Class'};
TicTacToe.Properties.VariableNames = VarNames;

% Zmiana danych w postaci znakowej na numeryczne
cats = categorical(TicTacToe{:,:});
TicTacToe = double(cats);

% Zapisanie danych w formie liczbowej do pliku .txt 
dlmwrite('TicTacToe-numerical.txt', TicTacToe, 'delimiter', ',')

% Podziałna zbiór uczący i testowy w proporcji 70/30
[m,n] = size(TicTacToe) ;
[m,n]
division = 0.7;
idx = randperm(m);

% Losowo wybrany zbiór uczacy
Training = TicTacToe(idx(1:round(division*m)),:); 
dlmwrite('TicTacToe-numerical-Train.txt', Training, 'delimiter', ','); % zapis zbioru uczacegodo pliku .txt

% Losowo wybrany zbiór trenujący
Test= TicTacToe(idx(round(division*m)+1:end),:) ;
dlmwrite('TicTacToe-numerical-Test.txt', Test, 'delimiter', ','); % zapis zbioru testowego pliku .txt

% Wczytanie danych uczących -  podział na macierz danych i klas 
Train = dlmread('TicTacToe-numerical-Train.txt');

% Zamiana wartosci 'positive'->4->1 oraz 'negative'->2->-1
Training_labels = Train(:,10);
Training_labels( Training_labels== 2)= -1;
Training_labels( Training_labels== 4)= 1;
Train(:,10)=[];
l = length(Training_labels);

% Wczytanie danych testowych -  podział na macierz danych i klas
Test = dlmread('TicTacToe-numerical-Test.txt');

Test_labels = Test(:,10);
Test_labels( Test_labels== 2)= -1;
Test_labels( Test_labels== 4)= 1;
Test(:,10)=[];
l = length(Test_labels);

%Ustawienie opcji optymalizacji dla funkcji quadprog
options = optimoptions(@quadprog,'Algorithm','interior-point-convex');

% Wywołanie funkcji svm_primal, która wykorzystuje optymalizację quadprog do znalezienia optymalnych wag i progu dla SVM
[w, b, time_p, fval_p, exitflag_p, output_p ] = svm_primal(Train, Training_labels, options);   

% Wywołanie funkcji svm_pred_primal, aby użyć wag i progu SVM do predykcji danych testowych
acc_primal = svm_pred_primal(Test, Test_labels, w, b);

% Wywołanie funkcji svm_dual, która wykorzystuje optymalizację quadprog do znalezienia optymalnych wartości alfa dla SVM
[alfa, time_d, fval_d, exitflag_d, output_d ] = svm_dual(Train, Training_labels, options);     

% Wywołanie funkcji svm_pred_dual, aby użyć wartości alfa SVM do predykcji danych testowych
acc_dual = svm_pred_dual( Test, Test_labels, alfa, Train, Training_labels );


% Wyświetlenie wyników
disp('zadanie prymalne');
output_p
acc_primal

disp('zadanie dualne');
output_d
acc_dual


