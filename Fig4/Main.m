function [data] = Main(name_file_par,tf)
% This code simulates the refilling of an average synaptic vessicle   
% 
%We modified the code archived with Astaburuaga et al 2019 (Cells), 
%which was written to simulate ion homeostasis in lysosomes  

% name_file_par: is a mat file with the parameters used in the model
% tf: (in seconds) is  total time for which the system of differential equations is integrated.

%To run the code type the following line in Matlab terminal
%Running the code with the following parameters will generate time traces 
%similar to those shown in Figure 6 in Kolen el al. Nat Comm. 2022

%[data] = Main('par_WT',200);


%Specify the relative and absolute error tolerance:
options = odeset('RelTol',1e-6,'AbsTol',1e-6);

%Global auxiliary variables to save model output.
global i Y Z init_Glu Glu_C S1 init_V1 cap
i=0;
Y=0;

%Load model parameters
load(name_file_par)   


R1 = 0.02;
S1 = 4*pi*R1^2*1e-8;
init_V1 = (4/3)*pi*R1^3*1e-12/1000;

S = S1;
init_V = init_V1;
cap = cap_0*S/1000;

Glu_C   = 10e-3;
init_Glu   = 1e-6;

%Initial conditions
init_NH = init_H*init_V*NA;       %H amount
init_NK = init_K*init_V*NA;       %K amount
init_NNa = init_Na*init_V*NA;     %Na amount
init_NCl = init_Cl*init_V*NA;     %Cl amount

init_NGlu = init_Glu*init_V*NA;     %Glu amount

IC = [init_NH; init_pH; init_NK; init_NNa; init_NCl; init_NGlu];

%Solve the ODE system
sol = ode15s(@(time_1,X_1) model(time_1,X_1,name_file_par),(0:1:tf),IC,options);
% % calculates X using the above defined solver (sol)

%Save the output data in a table
time= sol.x';
X1= sol.y';
X2 = reduce_Z(Z,time);
X2 = X2(:,2:end);
data = array2table([time X1 X2]);
data.Properties.VariableNames = {'time','NH', 'pH', 'NK', 'NNa', 'NCl', 'NGlu', 'Glu', 'K', 'Na',...
    'Cl', 'psi', 'V_ATPASE', 'J_VATPASE', 'CLC_mu','J_VGluT','J_CLC', ...
    'J_H', 'J_K', 'J_Na', 'J_Cl'};

%Plot the temporal evolution of some of the model variables 

plotfig(data,'k','-', 0 , tf)






