
clc
clear
close all



%% EMULACION FLYWHEEL CON PMDCM - DESCARGA A CORRIENTE CONSTANTE iout=30A

%% Parámetros Zhang

L = 3.6e-3;
R = 0.5;
J = 0.123;
kb = 0.062070427805750;                 % V/rad/s
ki = 0.066845076098500;
B = 1e-4;
w_ss = 7296.67611231985;                % velocidad angular en estado estable

t_w0 = 47.7833;
t = linspace(0,5000,14160);


iout = 0;                              % Corriente de descarga 30 A constante!!
i_out = [iout*ones(1,14160)]'; 

%% velocidad angular de descarga


w_d1 = w_ss*exp((-B/J).*t);

w_d = 9.5492965855*w_d1;                 % velocidad angular / conversión rad/s a rpm

v_d = kb*w_d;                            % tension de salida a I constante

Fig_icte = figure;
figure (Fig_icte);

%% COMPORTAMIENTO DE CORRIENTE DE DESCARGA

subplot(3,1,1)

hold on
plot(t,i_out,'LineWidth',1.2)
title('Corriente i_{out}(t)');
xlabel('t[s]');
xlim([0 60]);
ylabel('i [A]');
ylim([-34 0]);
legend('i (t)');
legend('Location' ,'northeast');
grid on


%% COMPORTAMIENTO DE LA VELOCIDAD ANGULAR DESCARGA

subplot(3,1,2)

hold on
plot(t,w_d,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
xline(t_w0,'-.r','LineWidth',1.2)           % tiempo en alcanzar w=0 
title('Velocidad angular \omega(t)');
xlabel('t [s]');
xlim([0 60]);
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}','t_{\omega=0}' );
legend('Location','east');

text(30,6000,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA TENSION DE DESCARGA
subplot(3,1,3)

hold on
plot(t,v_d,'LineWidth',1.2)
title('Tensión V(t)');
xlabel('t[s]');
xlim([0 60]);
ylabel('V [V]');
legend('V (t)');
legend('Location','east');
grid on