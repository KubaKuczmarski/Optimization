%% Metoda najmniejszyc kwadratów
function [w_min,Jacobian] = MNK(x) % x - punkt startowy [x0 y0 z0]
    global x_i y_i z_i s_satelita_odbiornik 

    % Wartoœæ minimalna funkcji najmniejszych kwadratów
    w_min = (x(1)-x_i).^2 + (x(2)-y_i).^2 + (x(3)-z_i).^2 - s_satelita_odbiornik.^2;
    
    if nargout > 1 
        Jacobian = [2*x(1)-2.*x_i; 2*x(2)-2.*y_i; 2*x(3)-2.*z_i].';
    end
end
