    function [yM] = model(xm, a)
    % Model definitions for the function numerFminS() as a 'fun'
    % Second degree polynomial (dataNRM.txt):
    yM = zeros(3,1);
    yM=a(1)*xm.^2+a(2)*xm+a(3);
       