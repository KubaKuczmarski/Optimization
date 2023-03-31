%% Generacja losowych dwóch zbiorów punktów w przestrzeni 5-wymiarowej, które leżą po dwóch stronach 4-wymiarowej hiperpłaszczyzny liniowej zawartej w tej przestrzeni

clear all

% Ustawienie zmiennej number na wartość, która określa liczbę generowanych punktów
number=1000;

% Ustawienie zmiennych min_number i max_number, które określają zakres danych
min_number = -10000;
max_number = 10000;

% Generowanie losowych 5-wymiarowych danych z zakresu od min do max i przypisywanie ich do klas
X = min_number + (max_number-min_number)*rand(number,5);
%X = rand(number,5)
Y = sign(X(:,1));

% Rozdzielenie danych losowych na dane uczące i testowe
sizeY = size(Y);
k = round(0.7*sizeY);

% Zbiór treningowy
TrainSetX = X(1:k,:);
TrainSetY = Y(1:k);

% Zbiór testowy
TestSetX = X((k+1):sizeY,:);
TestSetY = Y((k+1):sizeY);

% Ustawienie opcji optymalizacji dla funkcji quadprog
options = optimoptions(@quadprog,'Algorithm','interior-point-convex');

% Wywołanie funkcji svm_primal, która wykorzystuje optymalizację quadprog do znalezienia optymalnych wag i progu dla SVM
[w, b, time_p, fval_p, exitflag_p, output_p ] = svm_primal(TrainSetX, TrainSetY, options);

% Wywołanie funkcji svm_pred_primal, aby użyć wag i progu SVM do predykcji danych testowych
acc_primal = svm_pred_primal(TestSetX, TestSetY, w, b);

% Wywołanie funkcji svm_dual, która wykorzystuje optymalizację quadprog do znalezienia optymalnych wartości alfa dla SVM
[alfa, time_d, fval_d, exitflag_d, output_d ] = svm_dual(TrainSetX, TrainSetY, options);

% Wywołanie funkcji svm_pred_dual, aby użyć wartości alfa SVM do predykcji danych testowych
acc_dual = svm_pred_dual( TestSetX, TestSetY, alfa, TrainSetX, TrainSetY );

% Wyświetlenie wyników
disp('zadanie prymalne');
output_p
acc_primal

disp('zadanie dualne');
output_d
acc_dual

% Komentarz
% Kod tworzy losowy zbiór danych 5-wymiarowych, który jest podzielony na dane uczące i testowe. Następnie wykorzystywana jest funkcja optymalizacji quadprog do rozwiązania zadania prymalnego i dualnego SVM. Zadania te mają na celu znalezienie optymalnych wag i progu dla SVM. Na koniec, dokonano predykcji za pomocą zarówno zadania prymalnego, jak i dualnego, aby sprawdzić dokładność.