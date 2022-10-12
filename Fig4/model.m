function dxdt = model(time,X,name_file_par)

global i Y Z init_Glu Glu_C S1 init_V1 cap

i= i+1;

load(name_file_par)

S = S1;
init_V = init_V1;

dxdt    = zeros(size(X));

NH      = X(1); 
pH      = X(2);
NK      = X(3); 
NNa     = X(4); 
NCl     = X(5); 
NGlu    = X(6); 

%Luminal Concentrations
H       = NH/init_V/NA;
K       = NK/init_V/NA;
Na      = NNa/init_V/NA;
Cl      = NCl/init_V/NA;
Glu     = NGlu/init_V/NA;

B1 = init_K+init_Na+init_H-init_Cl - init_Glu - cap/F/init_V*(psi_in - psi_out) - init_psi_total*cap/F/init_V;

%Membrane Potential
psi     = (F/cap)*init_V*(H + K + Na - Cl - Glu - B1);

%Modified Cytoplasmic Surface Concentrations
pH_C0   = (pH_C+psi_out/(RTF*2.3)); 
K_C0    = K_C*exp(-psi_out/RTF); 
Na_C0   = Na_C*exp(-psi_out/RTF); 
Cl_C0   = Cl_C*exp(psi_out/RTF); 
Glu_C0   = Glu_C*exp(psi_out/RTF); 

%Modified Luminal Surface Concentrations
pH_L0   = (pH+psi_in/(RTF*2.3)); 
K_L0    = K*exp(-psi_in/RTF); 
Na_L0   = Na*exp(-psi_in/RTF); 
Cl_L0   = Cl*exp(psi_in/RTF); 
Glu_L0   = Glu*exp(psi_in/RTF); 

delta_pH    = pH_C0-pH_L0;

%Treatment of singular terms for passive ion flux
if abs(psi) > 0.01
    gg      =  psi / (1 - exp (- psi / RTF)) / RTF;
else 
    gg      =  1 / 1 - (psi / RTF)/2 + (psi / RTF)^2/6 - (psi / RTF)^3 / 24 + (psi / RTF) ^ 4 / 120;
end

%V-ATPase performance
V_ATPASE    = find_VATP_rate(v_flux,psi,pH);
J_VATPASE   = 0.003*N_VATP*real(V_ATPASE); 

%ClC-7 Antiporter {H out, Cl in} NOT INCLUDED IN THE MODEL
CLC_mu      = (CLC_H + CLC_Cl)*psi + RTF*(CLC_H*2.3*delta_pH + CLC_Cl*log(Cl_C0/Cl_L0)); 
%Switching function   
x           = 0.5 + 0.5*tanh((CLC_mu + 250)/75); 
%Activity
A           = 0.3*x + 1.5E-5*(1-x)*CLC_mu^2;
J_CLC    = 000*A*CLC_mu; %N_CLC


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
N_VGluT = 100;
n1  = 6.012428707847750;
Kd1 = 2.454046747592169;
n3 = 1.367158570744205;
Kd3 = 9.999017999663485;

H_C0 = 10^(-pH_C0);
H_L0 = 10^(-pH_L0);

Ion_dep = ((8-pH_L0)^n1/(Kd1^n1+(8-pH_L0)^n1)) * ((Cl_L0*1e3)^n3/(Kd3+(Cl_L0*1e3)^n3));
VGluT_mu  = Ion_dep*(psi - RTF/2*log((Glu_L0*H_C0)/(Glu_C0*H_L0)));  
%VGluT_mu  = Ion_dep*(psi - RTF*log(Glu_L0/Glu_C0));  

J_VGluT = N_VGluT*VGluT_mu;

VGluT_mu_Cl  = Ion_dep*(psi - RTF*log(Cl_L0/Cl_C0));  
J_VGluT_Cl = 1*N_VGluT*VGluT_mu_Cl;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%Passive flux
J_H    = 1000*1e-6*S*(10^(-pH_C0)*exp(-psi/RTF)-10^(-pH_L0))*gg*NA/1000; %P_H
J_K    = 0*7.1e-7*S*(K_C0*exp(-psi/RTF)-K_L0)*gg*NA/1000;  %P_K
J_Na   = 0*9.6e-7*S*(Na_C0*exp(-psi/RTF)-Na_L0)*gg*NA/1000; %P_Na
J_Cl_unc   = 0*2e-7*S*(Cl_C0-Cl_L0*exp(-psi/RTF))*gg*NA/1000; %P_Cl

%Time Dependent Quantities
dNHdt   = J_H + (J_VATPASE) - (CLC_H*J_CLC) - J_VGluT; 
dpHdt   = (-dNHdt/init_V/NA)/beta_pH;   
dNKdt   = J_K;  
dNNadt  = J_Na; 
dNCldt  = J_Cl_unc + (CLC_Cl*J_CLC) + J_VGluT_Cl;  
dNGludt = J_VGluT;  

Y = [time, Glu, K, Na, Cl, psi, ...
    V_ATPASE, J_VATPASE, CLC_mu, J_VGluT, J_CLC, ...
    J_H, J_K, J_Na, J_VGluT_Cl];

save_values (Y);

%OUTPUT

dxdt = [dNHdt; dpHdt; dNKdt; dNNadt; dNCldt; dNGludt];

