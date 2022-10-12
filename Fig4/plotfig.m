
function plotfig(data,color,linestyle, startTime,endTime)
%Plot the temporal evolution of some of the model variables 
%data:  output data from 'model.m'
%color: specify color of the plot.
%linestyle: specify line style of the plot.
%starTime and endTime: specify the start and ending times to show in the
%plots.

set(groot, 'defaultAxesTickLabelInterpreter','tex'); 
set(groot, 'defaultLegendInterpreter','tex');
set(groot,'defaultTextInterpreter','tex');
set(groot,'defaultAxesFontSize',12)
set(groot,'defaultLegendFontSize',12)
set(groot,'defaultUicontrolFontName','Arial');
set(groot,'defaultUitableFontName','Arial');
set(groot,'defaultAxesFontName','Arial');
set(groot,'defaultTextFontName','Arial');
set(groot,'defaultUipanelFontName','Arial');

%plot temporal evolution of the total membrane potential
figure(1);
subplot(4,2,1)
hold on;
plot(data.time(2:end),data.psi(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel('\Delta\Psi [mV]')
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

%legend('V_ATP KO')

%plot temporal evolution of the luminal pH.
subplot(4,2,3)
hold on;
plot(data.time(2:end),data.pH(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel('pH_L')
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

%plot temporal evolution of the luminal chloride.
subplot(4,2,5)
hold on;
plot(data.time(2:end),data.Cl(2:end)*1000,'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel('[Cl^-]_L [mM]')
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

%plot temporal evolution of the luminal glutamate.
subplot(4,2,7)
hold on;
plot(data.time(2:end),data.NGlu(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel('Number of Glu')
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

% 

%plot temporal evolution of the turnorver rate of the JVATPASE.
subplot(4,2,2)
hold on;
plot(data.time(2:end), data.J_VATPASE(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel({'J_{VATPASE} [H^+/s]'})
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

% 

%plot temporal evolution of J_VGlut.
subplot(4,2,4)
hold on;
plot(data.time(2:end),data.J_VGluT(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel('J_{VGluT Glu} [Glu^-/s]')
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

% %plot temporal evolution of the turnorver rate of the ClC-7 antiporter.
% subplot(5,2,6)
% hold on;
% plot(data.time(2:end), data.J_CLC(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
% ylabel({'J_{ClC-7} [Cl^-/s]'})
% xlabel('Time [s]')
% xlim ([startTime endTime])
% ax = gca;
% ax.XRuler.Exponent = 0;
% axis tight   % set tight range

% 
% %plot temporal evolution of the turnorver rate of the JCl_leak.
subplot(4,2,6)
hold on;
plot(data.time(2:end), data.J_Cl(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel({'J_{VGluT Cl} [Cl^-/s]'})
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

% %plot temporal evolution of the turnorver rate of the JK.
% subplot(5,2,9)
% hold on;
% plot(data.time(2:end), data.J_K(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
% ylabel({'J_K [K^+/s]'})
% xlabel('Time [s]')
% xlim ([startTime endTime])
% ax = gca;
% ax.XRuler.Exponent = 0;
% axis tight   % set tight range

% %plot temporal evolution of the turnorver rate of the JH.
subplot(4,2,8)
hold on;
plot(data.time(2:end), data.J_H(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
ylabel({'J_{H} [H^+/s]'})
xlabel('Time [s]')
xlim ([startTime endTime])
ax = gca;
ax.XRuler.Exponent = 0;
axis tight   % set tight range

% figure(2);
% hold on;
% plot(data.time(2:end), data.psi(2:end)/max(data.psi(2:end)),'k','LineWidth',2.5,'LineStyle',linestyle);
% plot(data.time(2:end), data.pH(2:end)/max(data.pH(2:end)),'r','LineWidth',2.5,'LineStyle',linestyle);
% plot(data.time(2:end), data.Cl(2:end)/max(data.Cl(2:end)),'b','LineWidth',2.5,'LineStyle',linestyle);
% plot(data.time(2:end), data.Glu(2:end)/max(data.Glu(2:end)),'m','LineWidth',2.5,'LineStyle',linestyle);
% legend('\Delta \psi','pH_L','Cl_L','Glu_L')
% xlabel('Time [s]')
% xlim ([startTime endTime])
% ax = gca;
% ax.XRuler.Exponent = 0;
% axis tight   % set tight range


% %plot temporal evolution of the luminal sodium.
% subplot(3,2,5)
% hold on;
% plot(data.time(2:end),data.Na(2:end)*1000,'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
% ylabel('[Na^+]_L [mM]')
% xlabel('Time [s]')
% xlim ([startTime endTime])
% ax = gca;
% ax.XRuler.Exponent = 0;

% %plot temporal evolution of the turnorver rate of the JNa.
% subplot(6,2,11)
% hold on;
% plot(data.time(2:end), data.psi1(2:end),'Color',color,'LineWidth',2.5,'LineStyle',linestyle);
% ylabel('\Delta\Psi [mV]')
% xlabel('Time [s]')
% xlim ([startTime endTime])
% ax = gca;
% ax.XRuler.Exponent = 0;
% axis tight   % set tight range
end
