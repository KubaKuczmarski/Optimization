%%  DANE Z ZADANIE I STAŁE FIZYCZNE  

% Promień Ziemi
R_Ziemi = 6378137;  % [m]   

% Wysokość satelitów nad poziomem morza
w_npm = 20e6;    % [m]   

% Współrzędne geograficzne satelitów 
szerokosc_geograficzna_satelit = [52.885907 50.312052 47.796902 50.619584 55.488272]; % teta
dlugosc_geograficzna_satelit = [13.395837 12.373351 19.381854 26.244260 28.787526]; % fi

% Czas  nadejścia sygnału od satelity 
t = [6.681942096329203e-02 6.685485794155749e-02 6.678159811857652e-02 6.675754177119679e-02 6.685983402652426e-02]; % [s]
% Likwidacja 4 liczb
%t = [6.68194209632e-02 6.68548579415e-02 6.67815981185e-02 6.67575417711e-02 6.68598340265e-02];  
% Likwidcja 8 liczb
%t = [6.6819420e-02 6.6854857e-02 6.6781598e-02 6.6757541e-02 6.6859834e-02];
% Likwidacja 12 liczb
%t = [6.681e-02 6.685e-02 6.678e-02 6.675e-02 6.685e-02];

% Prędkość światła w próżni
c = 299792458;  % [m/s] 

% Odległość satelity od powierzchniZiemi
R_satelity = w_npm + R_Ziemi; % [m]   

%% OBLICZNIA ZWĄZANE Z POŁOŻENIEM SZUKANEGO PUNKTU 

% Współrzędne satelitów i odległość od odbiornika
global x_i y_i z_i s_satelita_odbiornik
%global x_i2 y_i2 z_i2 s_satelita_odbiornik
%global x_i3 y_i3 z_i3 s_satelita_odbiornik
%global  x_i4 y_i4 z_i4 s_satelita_odbiornik
%global x_i5 y_i5 z_i5 s_satelita_odbiornik

% Punkt startowy
x0=[0 0 0];
%x0=[x_i2 y_i2 z_i2]; 
%x0=[x_i3 y_i3 z_i3]; 
%x0=[x_i4(4), y_i4(4), z_i4(4)]; % współrzędne [x,y,z]  czwartego satelity
%x0=[x_i5(4), y_i5(4), z_i5(4)];

% Odległość satelity od odbiornika
s_satelita_odbiornik = c .* t;    % [m]   

%% KONWERSJA UKŁADU WSPÓŁRZĘDNYCH SFERYCZNYCH NA WSPÓŁRZĘDNE KARTEZIJAŃSKIE

% 1. Punkt startowy znajdujący się w środku układu współrzednych 
x_i = R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* cos(deg2rad(dlugosc_geograficzna_satelit));
y_i = R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* sin(deg2rad(dlugosc_geograficzna_satelit));
z_i = R_satelity .* sin(deg2rad(szerokosc_geograficzna_satelit));

% 2. Punty startowy znajdujący się na powierzchni Ziemi – Pałac Kultury i Nauki

% Współrzędne Pałacu Kultury i Nauki (52.231718736894, 21.006047888954)
 
%szerokosc_PKiN = 52.231718736894;
%dlugosc_PKiN = 21.006047888954;
%x_i2 = R_Ziemi .* cos(deg2rad(szerokosc_PKiNTeta)) .* cos(deg2rad(dlugosc_PKiN));
%y_i2 = R_Ziemi .* cos(deg2rad(szerokosc_PKiNTeta)) .* sin(deg2rad(dlugosc_PKiN));
%z_i2 = R_Ziemi .* sin(deg2rad(szerokosc_PKiNTeta));
 
% 3. Punty startowy znajdujący się w pobliżu kuli ziemskiej 

%szerokosc_PKiN = 52.231718736894;
%dlugosc_PKiN = 21.006047888954;
%x_i3=(R_Ziemi+40000).*cos(deg2rad(szerokosc_PKiN)) .* cos(deg2rad(dlugosc_PKiN));
%y_i3=(R_Ziemi+40000).*cos(deg2rad(szerokosc_PKiN)) .* sin(deg2rad(dlugosc_PKiN));
%z_i3=(R_Ziemi+40000).*sin(deg2rad(szerokosc_PKiN));

% 4. Punkt startowy znajdujący się w pobliży satelity numer 4

%x_i4 = R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* cos(deg2rad(dlugosc_geograficzna_satelit));
%y_i4 = R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* sin(deg2rad(dlugosc_geograficzna_satelit));
%z_i4 = R_satelity .* sin(deg2rad(szerokosc_geograficzna_satelit));


% 5. Punkt startowy znacznie oddalony od kuli ziemskie

%x_i5 = 5000*R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* cos(deg2rad(dlugosc_geograficzna_satelit));
%y_i5 = 5000*R_satelity .* cos(deg2rad(szerokosc_geograficzna_satelit)) .* sin(deg2rad(dlugosc_geograficzna_satelit));
%z_i5 = 5000*R_satelity .* sin(deg2rad(szerokosc_geograficzna_satelit));

%% PARAMETRY SOLVERA  - metoda Levenberga-Marquardta 

% Opcje solvera korzystającego z metody Levenberga-Marquardta
options=optimoptions(@lsqnonlin,'Algorithm','levenberg-marquardt');
%options.MaxIter=400;                   % wartość domyślna: 400
%options.MaxFunctionEvaluations=200;    % wartość domyślna: 200
%options.TolFun=1e-24;                  % wartość domyślna: 1e-6
%options.StepTolerance=1e-16;           % wartość domyślna: 1e-6
%options.OptimalityTolerance=1e-16;     % wartość domyślna: 1e-6
%options.SpecifyObjectiveGradient=false; % wartość domyslna: false (solver przybliża jakobian przy użyciu różnic skończonych)

% Prezentacja części parametrów w postaci tabeli
options.Display='iter-detailed';

% Wywołanie solvera
[x, resnorm, residual, exitflag, output, lambda, jacobian] = lsqnonlin(@MNK, x0, [], [], options); %MNK - Metoda najmnijszych kwadratów

%% Do wywalenia-Test wartosci
%w = (x0(1)-x_i).^2 + (x0(2)-y_i).^2 + (x0(3)-z_i).^2 - s_satelita_odbiornik.^2;
%J = [2*x(1)-2.*x_i; 2*x(2)-2.*y_i; 2*x(3)-2.*z_i].'

% Wspołrzędne [x,y,z] szukanego punktu
X = x(1);
Y = x(2);
Z = x(3);

%% KONWERSJA UKŁADU WSPÓŁRZĘDNYCH KARTEZJAŃSKICH NA WSPÓŁRZĘDNE SFERYCZNE
r = sqrt(X^2 + Y^2 + Z^2);
szerokosc_geograficzna = rad2deg(asin(Z / r));
dlugosc_geograficzna = rad2deg(atan(Y / X));

