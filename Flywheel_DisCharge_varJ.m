clc
clear 
close all

%% EMULACION FLYWHEEL CON PMDCM - carga variación J

load('VAR_INER_D.mat');

w1 = VARJ_D.w1;
v1 = VARJ_D.v1;
E1 = VARJ_D.E1;

w2 = VARJ_D.w2;
v2 = VARJ_D.v2;
E2 = VARJ_D.E2;

w3 = VARJ_D.w3;
v3 = VARJ_D.v3;
E3 = VARJ_D.E3;

w4 = VARJ_D.w4;
v4 = VARJ_D.v4;
E4 = VARJ_D.E4;

t = VARJ_D.t;

Fig_Jd = figure;
figure (Fig_Jd);


%% COMPORTAMIENTO DE LA ENERGIA CARGA 

subplot(3,1,1)

hold on
plot(t,E1,t,E2,t,E3,t,E4,'LineWidth',1.2)
title('Energía de la Flywheel a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E_1(J= 0.4)','E_2(J= 0.123)','E_3(J= 0.08)','E_4(J= 0.02)');
legend('Location','east');
xlim([0,155]);

grid on

%% COMPORTAMIENTO DE VELOCIDAD ANGULAR

subplot(3,1,2)

hold on
plot(t,w1,t,w2,t,w3,t,w4,'LineWidth',1.2)
title('Velocidad angular \omega(t) a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega_1(J= 0.4)','\omega_2(J= 0.123)','\omega_3(J= 0.08)','\omega_4(J= 0.02)');
legend('Location',['east']);
ylim([0,7500]);
xlim([0,155]);

grid on

%% COMPORTAMIENTO DE LA CORRIENTE

subplot(3,1,3)

hold on
plot(t,v1,t,v2,t,v3,t,v4,'LineWidth',1.2)
title('Tensión de la Flywheel a diferentes J[kgm^{2}]');
xlabel('t [s]'); 
ylabel('V [V]');
legend('V_1(J= 0.4)','V_2(J= 0.123)','V_3(J= 0.08)','V_4(J= 0.02)');
legend('Location','east');
xlim([0,155]);

grid on