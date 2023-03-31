## DANE
param liczba_satelit; # liczba satelit (w naszym przypadku jest ich 5)
param w_npm; # wysoko�� ka�dego z satelit nad poziomem morza
param R_Ziemi; # promie� Ziemi
param c; # pr�dko�� �wiat�a w pr�ni
param dlugosc_fi_deg {1..liczba_satelit};  # d�ugo�� geograficzna satelit�w w stopniach
param szerokosc_teta_deg {1..liczba_satelit}; # szeroko�� geograficzna w stopniach
param t{1..liczba_satelit}; # czas nadej�cia sygna�u od ka�dego z satelit�w
param R=w_npm + R_Ziemi; # odleg�o�� staelit�w od �rodka Ziemi
param pi; # watyo�� PI
param n; # liczba parametr�w warto�ci pocz�tkowe
set J := {1..n};
param pkt_start {J} >= 0; # punkt startowy =[0,0,0]
param x0=pkt_start[1]; # punkt startowy - x0
param y0=pkt_start[2]; # punkt startowy - x0
param z0=pkt_start[3]; # punkt startowy - x0
param w; # parametr przeskalowania zadania

## Stopnie -> Radiany
param dlugosc_fi_rad{i in 1..liczba_satelit} = dlugosc_fi_deg[i] * (pi/180); # d�ugo�� geograficzna satelit�w w radianach
param szerokosc_teta_rad{i in 1..liczba_satelit} = szerokosc_teta_deg[i] * (pi/180); # szeroko�� geograficzna w radianach

## Po�o�enie satelit�w w uk�adzie kartezja�skim
param x_i{i in 1..liczba_satelit}=R*cos(szerokosc_teta_rad[i])*cos(dlugosc_fi_rad[i]);
param y_i{i in 1..liczba_satelit}=R*cos(szerokosc_teta_rad[i])*sin(dlugosc_fi_rad[i]);
param z_i{i in 1..liczba_satelit}=R*sin(szerokosc_teta_rad[i]);
param ct{i in 1..liczba_satelit}=c*t[i]; # odleg�o�� poszczeg�lnych satelit od odbiornika

## Wspo�rz�dne [x,y,z] szukanego punktu 
var X;
var Y;
var Z;

## Metoda najmniejszych kwadrat�w
minimize MNK:  sum {i in 1..liczba_satelit} (w*(X-x_i[i])^2+w*(Y-y_i[i])^2+w*(Z-z_i[i])^2-w*ct[i]^2)^2;

## Warto�� szeroko�ci i d�ugo�ci geograficznej szukanego puktu w uk�adzie sferycznym
var r=sqrt(X^2+Y^2+Z^2);
var szerokosc=asin(Z/r)*(180/pi); # szeroko�� geograficzna
var dlugosc=atan(Y/X)*(180/pi);# d�ugo�� geograficzna