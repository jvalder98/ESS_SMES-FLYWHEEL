clc
clear
close all



%% EMULACION FLYWHEEL CON PMDCM - DESCARGA A CORRIENTE CONSTANTE iout=30A

%% Parámetros Zhang

L = 3.6e-3;
R = 0.5;

J = 0.4;       
% J = 0.123;
% J = 0.08;
% J = 0.02;

kb = 0.062070427805750;                 % V/rad/s
ki = 0.066845076098500;
B = 1e-4;
w_ss = 7296.67611231985;                % velocidad angular en estado estable

t_w0 = 47.7833;
t = linspace(0,200,500);


iout = -30;                              % Corriente de descarga 30 A constante!!
i_out = [iout*ones(1,500)]'; 

%% G(s) = W(s)/I(s)

sys_w_d = tf([ki],[J B]);

w_d1 = lsim(sys_w_d,i_out,t);

w_d = 9.5492965855*w_d1;                 % velocidad angular / conversión rad/s a rpm
w_0 = [w_ss*ones(1,500)]';               % Ajuste de condición inicial
w_d = w_d + w_0;                         % Ajuste de condición inicial

w_d2 = - w_d1;                           % Ajuste de condicion inicial w_0 ≠ 0  
v_d = kb*w_d2 - R*i_out;                 % tension de salida a I constante

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
v_bus=48;

hold on
plot(t,v_d,'LineWidth',1.2)
title('Tensión V(t)');
xlabel('t[s]');
xlim([0 60]);
ylabel('V [V]');
legend('V (t)');
legend('Location','east');
grid on

%% ANALISIS POTENCIA Y ENERGÍA DESCARGA

i_d = i_out;
B1 = 1e-4;                      %definir nuevamente constante de fricción
tao_F = ki*i_d - B1*w_d;
P_F = (tao_F).*w_d;             %comportamiento potencia en J
tao_B = B1*w_d;
P_B = (tao_B).*w_d;             %potencia perdida por friccion B
tao_G = ki*i_d;
P_mec = (tao_G).*w_d;

P_elec = i_d.*v_d;             %potencia electrica
P_R = R*i_d;

E_d = 0.5*J*w_d.*w_d;
E_max = 0.5*J*w_ss*w_ss;

FigPE = figure;
figure (FigPE);

%% COMPORTAMIENTO DE VELOCIDAD ANGULAR DESCARGA

subplot(3,1,1)

hold on
plot(t,w_d,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
title('Velocidad angular \omega(t)');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}' );
legend('Location','east');

%text(20,6500,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA POTENCIA DESCARGA

subplot(3,1,2)

hold on
plot(t,P_F,t,P_B,t,P_mec,t,P_elec,t,P_R,'LineWidth',1.2)
title('Comportamiento Potencia');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P_{flywheel}','P_{loss,B}','P_{mec}','P_{elec}','P_{loss,R}','Orientation','horizontal');
legend('Location','southeast');

grid on

%% COMPORTAMIENTO DE LA ENERGIA DESCARGA

subplot(3,1,3)

hold on
plot(t,E_d,'LineWidth',1.2)
yline(E_max,'-.','LineWidth',1.2)           % Energía máxima
title('Energía de la Flywheel');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E (t)','E_{max}' );
legend('Location','east');

%text(20,2943000,'E_{max} \cong 3.27 MJ')

grid on