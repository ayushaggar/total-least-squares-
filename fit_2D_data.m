function [Err, P] = fit_2D_data(XData, YData)
%
% function [Err, P] = fit_2D_data(XData, YData)
%
% Orthogonal linear regression method in 2D for model: y = a + bx   
%
% Input parameters:
%  - XData: input data block -- x: axis
%  - YData: input data block -- y: axis

% Return parameters:
%  - Err: error - sum of orthogonal distances 
%  - P: vector of model parameters [b-slope, a-offset]  for figure
%
% Authors:
% Ivo Petras - using Matlab file exchange file of Total Least Square   
% Ayush Aggarwal - Modification as per need

% Date: 07/11/2014

kx=length(XData);
ky=length(YData);
if kx ~= ky
   disp('Incompatible X and Y data.');
   close all;
end
n=size(YData,2);        %size of second dimension mean total column as it will be in a row 
sy=sum(YData)./ky;      % Here ./ has been use so as to be general
sx=sum(XData)./kx;
sxy=sum(XData.*YData);
sy2=sum(YData.^2);
sx2=sum(XData.^2);
B=0.5.*(((sy2-ky.*sy.^2)-(sx2-kx.*sx.^2))./(ky.*sx.*sy-sxy));
b1=-B+(B.^2+1).^0.5;
b2=-B-(B.^2+1).^0.5;
a1=sy-b1.*sx;
a2=sy-b2.*sx;

% it will return correlation coefficients between X and Y valueit is used to see which value of a b has to be take
R=corrcoef(XData,YData);       
if R(1,2) > 0 
    P=[b1 a1];
    Yhat = XData.*b1 + a1;
    Xhat = ((YData-a1)./b1);
end
if R(1,2) < 0
    P=[b2 a2];
    Yhat = XData.*b2 + a2;
    Xhat = ((YData-a2)./b2);
end

%Taking orthogonal distance for error as should be for TLS
alpha = atan(abs((Yhat-YData)./(Xhat-XData)));
d=abs(Xhat-XData).*sin(alpha);
Err=sum(d.^2);  
         
