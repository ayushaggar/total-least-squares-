function [Err, min_param]=numerFminS(fun, p, LBa, UBa, xdata, ydata)
%
% [Err, min_param]=numerFminS(fun, p, LBa, UBa, xdata, ydata)
%
% Orthogonal non-linear regression method in 2D for model 
% defined in file 'Model.m', which is an input as a 'fun'.
%     
% This function is based on optimization algorithm created
% by John D'Errico in 2006 and named as: 'fminsearchbnd'.
% 
% Input parameters:
%  - fun: name of file where is the model defined
%  - p: number of optimized parameters (same as in the file 'fun')
%  - LBa: lower bound vector or array for parameters 
%  - UBa: upper bound vector or array for parameters 
%  - xdata: input data block -- x: axis
%  - ydata: input data block -- y: axis
% 
% Return parameters:
%  - Err: error - sum of squared orthogonal distances 
%  - min_param: vector of model parameters  
%
% Authors:
% Ivo Petras (ivo.petras@tuke.sk)
% Tomas Skovranek (tomas.skovranek@tuke.sk)
% Dagmar Bednarova (dagmar.bednarova@tuke.sk)
% Authors:
% using Matlab file exchange file of Total Least Square   
% Ivo Petras (ivo.petras@tuke.sk)
% Tomas Skovranek (tomas.skovranek@tuke.sk)
% Dagmar Bednarova (dagmar.bednarova@tuke.sk) 
% Ayush Aggarwal - Modification as per need

% Date: 07/11/2014


if ~(exist('fminsearchbnd', 'file') == 2)
    P = requireFEXpackage(8277);   % fminsearchbnd is another function inbuilt which is part of 8277 at MathWorks.com
    
end 
%
warning off all

%creates or edit optimisation options structure will use in fminsearchbnd for ordinary differential equation solvers
options1 = odeset('RelTol',1e-6,'AbsTol',1e-6);
options = optimset('MaxIter',1e+4,'MaxFunEvals',1e+4,'TolX',1e-6,'TolFun',1e-6); 

Mpoints(:,1)=xdata;  % Mpoints initial x
Mpoints(:,2)=ydata; % Mpoints initial y

sum=0;
a0=zeros(1,p);

[a,fval,exitflag,output] = fminsearchbnd(@calculation,a0,LBa,UBa,options);

[yy]=fun(xdata, a); % fun variable is assigned to a function which is model it give y output
x=xdata; y=yy;       

%some output information about the minimization:
algoritm=output.algorithm;
funcCount=output.funcCount;
iter=output.iterations;
output.message;
min_param=a;

%function for evaluating the model with optimized parameters
    function [sum] = calculation (a)
    sum=0;
    [yy]=fun(xdata, a);
    x=xdata; y=yy;      
    points(:,1)=x;
    points(:,2)=y;  % optimised y - Mpoints initial y
            for m=1:size(Mpoints,1)
            [min_dist, IP]=dist_dsearch(points,Mpoints(m,:),'off'); % For minimum distance between the points
            sum=sum+(min_dist).^2;
        end
        Err=sum;
    end
end
