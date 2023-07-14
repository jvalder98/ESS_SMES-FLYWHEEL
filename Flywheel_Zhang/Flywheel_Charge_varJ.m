clc
clear 
close all

%% EMULACION FLYWHEEL CON PMDCM - carga variación J

load('VAR_INER.mat');

w1 = VAR_INER.w1;
i1 = VAR_INER.i1;
E1 = VAR_INER.E1;

w2 = VAR_INER.w2;
i2 = VAR_INER.i2;
E2 = VAR_INER.E2;

w3 = VAR_INER.w3;
i3 = VAR_INER.i3;
E3 = VAR_INER.E3;

w4 = VAR_INER.w4;
i4 = VAR_INER.i4;
E4 = VAR_INER.E4;

t = VAR_INER.t;

Fig_ciclo_Vte = figure;
figure (Fig_ciclo_Vte);


%% COMPORTAMIENTO DE LA ENERGIA CARGA 

subplot(3,1,1)

hold on
plot(t,E1,t,E2,t,E3,t,E4,'LineWidth',1.2)
title('Energía de la Flywheel a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E_1(J= 0.4)','E_2(J= 0.123)','E_3(J= 0.08)','E_4(J= 0.02)');
legend('Location','northwest');

grid on

%% COMPORTAMIENTO DE VELOCIDAD ANGULAR

subplot(3,1,2)

hold on
plot(t,w1,t,w2,t,w3,t,w4,'LineWidth',1.2)
title('Velocidad angular \omega(t) a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega_1(J= 0.4)','\omega_2(J= 0.123)','\omega_3(J= 0.08)','\omega_4(J= 0.02)');
legend('Location','southeast');

grid on

%% COMPORTAMIENTO DE LA CORRIENTE

subplot(3,1,3)

hold on
plot(t,i1,t,i2,t,i3,t,i4,'LineWidth',1.2)
title('Corriente de la Flywheel a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('i [A]');
legend('i_1(J= 0.4)','i_2(J= 0.123)','i_3(J= 0.08)','i_4(J= 0.02)');
legend('Location','northeast');

grid on