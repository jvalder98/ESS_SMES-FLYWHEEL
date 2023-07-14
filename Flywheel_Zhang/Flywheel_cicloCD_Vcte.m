
clc
clear 
close all

%% EMULACION FLYWHEEL CON PMDCM - CICLO COMPLETO con descarga Vout constante 48 V

load('Data_cicloCD_Vcte.mat');

i = dataVcte.i;
v = dataVcte.v;
w = dataVcte.w;
Pe = dataVcte.Pe;
Pm = dataVcte.Pm;
E = dataVcte.E;
t = dataVcte.t;

J = 0.123;
P_ss = 56;
w_ss = 7296.67611231985;
E_max = 0.5*J*w_ss*w_ss;

Fig_ciclo_Vte = figure;
figure (Fig_ciclo_Vte);

%% COMPORTAMIENTO DE LA POTENCIA CARGA / STORAGE MODE

subplot(4,1,1)

hold on
plot(t,Pm,t,Pe,'LineWidth',1.2);
yline(P_ss,'-.','LineWidth',1.2)           % Potencia en estado estable
title('Comportamiento Potencia');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P_{mec}','P_{elec}','P_{ss}');
legend('Location','southeast');

text(50,-7500,'P_{ss} \cong 56 W')

grid on

%% COMPORTAMIENTO DE LA ENERGIA CARGA / STORAGE MODE

subplot(4,1,2)

hold on
plot(t,E,'LineWidth',1.2)
yline(E_max,'-.','LineWidth',1.2)           % Energía máxima
title('Energía de la Flywheel');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E (t)','E_{max}' );
legend('Location','east');

text(50,2643000,'E_{max} \cong 3.27 MJ')

grid on

%% COMPORTAMIENTO DE VELOCIDAD ANGULAR CARGA STORORING MODE

subplot(4,1,3)

hold on
plot(t,w,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
title('Velocidad angular \omega(t)');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}' );
legend('Location','east');

text(50,6000,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA POTENCIA CORRIENTE Y LA TENSIÓN

subplot(4,1,4)

hold on
plot(t,v,t,i,'LineWidth',1.2);

title('Comportamiento Tensión y Corriente');
xlabel('t [s]'); 
ylabel('V[V] i[A]');
legend('V(t)','i(t)');
legend('Location','southeast');

grid on


