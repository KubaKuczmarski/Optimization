# Optymalizacja bez ograniczeń - metoda najmniejszych kwadratów

Optymalizacja bez ograniczeń to problem matematyczny polegający na znalezieniu wartości zmiennej lub zbioru zmiennych, które maksymalizują lub minimalizują określoną funkcję celu, bez żadnych dodatkowych ograniczeń.

Projekt polegał na wyznaczeniu położenia osoby na podstawie sygnału odbierango od 5 stelit. Do realizacji tego zadania wykorzystano optymalizację bez ograniczeń metodą najmniejszych kwadratów. 


# Zadanie

Zadania do wykonania:
1. Sformuować układ równań określajacych położenie w układzie współrzędnych kartezjańskich.
2. Sformułować zadanie optymalizacji bez ograniczeń stosując metodę najmniejszych kwadratów.
3. Wyznaczyć położenie rozwiązujac:
   - sformułowane powyżej zadanie optymalizacji za pomocą metody optymalizacji realizującej metodę Levenberga-Marquardta do rozwiązywania zadań regresji nieliniowej z      toolbox-u Optimization programu MATLAB (lsqnonlin)
   - solvera MINOS we współpracy z AMPL
4. Sprawdzić wpływ zmiany:
   - punktu startowego
   - dokładności w teście STOP-u metody
   - zaburzeń w danych
   na uzyskane wyniki
5. Znaleźć w Google Maps wyznaczone położenie.

# Dane

Poziom morza wynosi: 6378137 m

Położenie 5 satelitów w ukłądzie sferycznym:

![image](https://user-images.githubusercontent.com/113121214/229214362-c954999c-3f6d-4adf-80b2-531907fb426d.png)

Czasy dotarcia sygnału od poszczególnych satelitów w sekundach:

![image](https://user-images.githubusercontent.com/113121214/229214385-3de8ef79-1ef9-4188-a3f8-c74e9b03581c.png)


