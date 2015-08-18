% function Untitled(j)
% We have to choose different Total Least Squares Method in 2D for Linear model and non Linear model  
%
% Output parameters:
%  - j: to choose method which user choosed

% Author:
% Ayush Aggarwal (ayushagg@iitk.ac.in) 
% Date: 07/11/2014


function main

figure('Toolbar','none','Menubar','none','Name','Total Least Square Application','NumberTitle','off','IntegerHandle','off','Position',[400,450,400,200]);

uicontrol('Style','text','String','Choose Total Least Square Method which you want to apply.',...
           'Position',[30,145,350,20]);                     % making text
       
       dropdown_value = uicontrol('Style','popupmenu','string',{'Choose','Simple TLS to get straight line', 'SVD for Linear regression', 'Optimization method for Second degree polynomial '},...
           'Position',[140,120,100,15],...              %making pop up menu
           'callback' , @selection);

    function selection(~,~)
        r = get(dropdown_value, 'Value');               % getting its value
                                          
        Untitled(r);                                    %calling function
        
    end
       
end