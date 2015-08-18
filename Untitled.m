% function Untitled(j)
% Different Total Least Squares Method in 2D for Linear model and non Linear model  
%
% Input parameters:
%  - j: to choose method which user choosed

% Author:
% Ayush Aggarwal (ayushagg@iitk.ac.in)
% and using Matlab file exchange file of Total Least Square by  Ivo Petras
 
% Date: 07/11/2014

function Untitled(j)   
if j == 2                   % Linear regression models via TLS and classical LS method

load raw/dataLRM.txt;           % Loading Linear data given in txt file as points for straight line
xdata=dataLRM(1,:);         % all values in first row
ydata=dataLRM(2,:);         % all values in second row

% This function fit the data as per TLS for Linear model - Line
[ErrTLS, P1] = fit_2D_data(xdata, ydata)
YhatTLS=polyval(P1,xdata);   % For Polynomial evaluation to get Y

% different statical index described in theory
[F_TLS, Srez_TLS, Scel_TLS] = statindexes(xdata, ydata, P1(2), P1(1)) 

% For LS we can use matlab inbuilt function which is based on Least square
P2=polyfit(xdata, ydata, 1)

YhatLS=polyval(P2,xdata);
ErrLS=sum((YhatLS-ydata).^2)
[F_LS, Srez_LS, Scel_LS] = statindexes(xdata, ydata, P2(2), P2(1))

figure
plot(xdata, ydata, '*');     % Points given
hold on
plot(xdata,YhatTLS,'k');    % For Total least square
hold on
plot(xdata,YhatLS,'r');     % For least square
xlabel('x');
ylabel('y');
legend('Data','Model (TLS)', 'Model (LS)');
%  
end

if j==3

%reading the data file from excel
fname='raw/forSVD.xlsx';  

%Taking matrix A by add
x = xlsread(fname,1,'A2:A6');  
y= xlsread(fname,1,'D2:D6');
A= -[x,y] ;

%Taking matrix L
L = xlsread(fname,1,'B2:B6')  ;

%Taking weight matrix 
z= xlsread(fname,1,'C2:C6');
P=diag(z)   ;

%Values of M, N, U, X, V,aposteuri,Qx,Qv,Qlb,Qla,sigx,sigv,sigla
M=inv(P)    ;
N=A.'*P*A ;
U=A.'*P*L ;
X=-inv(N)*U 
V=A*X+L ;

% For TLS by SVD
[U,S,V] = svd([A,-L]); % as in TLS it is in AX = b form
X1 =  -V(1:end-1, end) / V(end,end)      %SOLUTION BY TLS


end
 
if j==4   % Demo on Nonlinear regression models via TLS and classical LS method
 
load raw/dataNRM.txt;
xdata=dataNRM(1,:);
ydata=dataNRM(2,:);
par_number = 3;   % assigning parameter for non linear 

[ErrTLS,P1]=numerFminS(@model,par_number,[-0.05 0.5 9.5], [-0.04 0.7 10.0], xdata, ydata)
YhatTLS=polyval(P1(1:par_number),xdata);

P2=polyfit(xdata,ydata,2)
YhatLS=polyval(P2,xdata);
ErrLS=sum((YhatLS-ydata).^2)

figure
plot(xdata, ydata, '*');
hold on
plot(xdata,YhatTLS,'k');
hold on
plot(xdata,YhatLS,'r');
xlabel('x');
ylabel('y');
legend('Data','Model (TLS)', 'Model (LS)');
%   
end
    
 end


