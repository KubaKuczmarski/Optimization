## DANE
param liczba_satelit; # liczba satelit (w naszym przypadku jest ich 5)
param w_npm; # wysokoœæ ka¿dego z satelit nad poziomem morza
param R_Ziemi; # promieñ Ziemi
param c; # prêdkoœæ œwiat³a w pró¿ni
param dlugosc_fi_deg {1..liczba_satelit};  # d³ugoœæ geograficzna satelitów w stopniach
param szerokosc_teta_deg {1..liczba_satelit}; # szerokoœæ geograficzna w stopniach
param t{1..liczba_satelit}; # czas nadejœcia sygna³u od ka¿dego z satelitów
param R=w_npm + R_Ziemi; # odleg³oœæ staelitów od œrodka Ziemi
param pi; # watyoœæ PI
param n; # liczba parametrów wartoœci pocz¹tkowe
set J := {1..n};
param pkt_start {J} >= 0; # punkt startowy =[0,0,0]
param x0=pkt_start[1]; # punkt startowy - x0
param y0=pkt_start[2]; # punkt startowy - x0
param z0=pkt_start[3]; # punkt startowy - x0
param w; # parametr przeskalowania zadania

## Stopnie -> Radiany
param dlugosc_fi_rad{i in 1..liczba_satelit} = dlugosc_fi_deg[i] * (pi/180); # d³ugoœæ geograficzna satelitów w radianach
param szerokosc_teta_rad{i in 1..liczba_satelit} = szerokosc_teta_deg[i] * (pi/180); # szerokoœæ geograficzna w radianach

## Po³o¿enie satelitów w uk³adzie kartezjañskim
param x_i{i in 1..liczba_satelit}=R*cos(szerokosc_teta_rad[i])*cos(dlugosc_fi_rad[i]);
param y_i{i in 1..liczba_satelit}=R*cos(szerokosc_teta_rad[i])*sin(dlugosc_fi_rad[i]);
param z_i{i in 1..liczba_satelit}=R*sin(szerokosc_teta_rad[i]);
param ct{i in 1..liczba_satelit}=c*t[i]; # odleg³oœæ poszczególnych satelit od odbiornika

## Wspo³rzêdne [x,y,z] szukanego punktu 
var X;
var Y;
var Z;

## Metoda najmniejszych kwadratów
minimize MNK:  sum {i in 1..liczba_satelit} (w*(X-x_i[i])^2+w*(Y-y_i[i])^2+w*(Z-z_i[i])^2-w*ct[i]^2)^2;

## Wartoœæ szerokoœci i d³ugoœci geograficznej szukanego puktu w uk³adzie sferycznym
var r=sqrt(X^2+Y^2+Z^2);
var szerokosc=asin(Z/r)*(180/pi); # szerokoœæ geograficzna
var dlugosc=atan(Y/X)*(180/pi);# d³ugoœæ geograficzna