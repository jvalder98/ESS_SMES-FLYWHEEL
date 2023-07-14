clc
clear 
close all

%% EMULACION FLYWHEEL CON PMDCM - DESCARGA TENSIÓN CONSTANTE Vout

%% Parámetros Zhang

L = 3.6e-3;
R = 0.5;
J = 0.123;
kb = 0.062070427805750; % V/rad/s
ki = 0.066845076098500;
B = 1e-4;
Vout = 48;
w_ss = 7296.67611231985;                           % velocidad angular en estado estable
i_ss = 1.14321362082603;                           % corriente en estado estable

t = linspace(0,120,500);                          % Se define el tiempo


v_d = Vout*ones(1,500);               % Tensión de salida Flywheel. Modo generador

% Modelo Espacios de Estado DESCARGA

A = [-R/L , kb/L ; -ki/J , -B/J ];
B = [-1/L ; 0 ];                     
C = [0 , 1; 1 , 0];
D = 0;
sys = ss(A,B,C,D);
u = v_d;
w = lsim(sys,u,t);

w_d = 9.5492965855*w(:,1);           % velocidad angular / conversión rad/s a rpm
w_0 = [w_ss*ones(1,500)];            % Ajuste de condición inicial
w_d = -w_d + w_0';                   % Ajuste de condición inicial
i_d = w(:,end);                      % corriente

Fig_Vcte = figure;
figure (Fig_Vcte);

%% COMPORTAMIENTO DE TENSION DESCARGA

subplot(3,1,1)

hold on
plot(t,v_d,'LineWidth',1.2)
title('Tensión V_{out}(t)');
xlabel('t[s]'); 
ylabel('V [V]');
ylim([0 60])
legend('V (t)');
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA VELOCIDAD ANGULAR DESCARGA

subplot(3,1,2)

hold on
plot(t,w_d,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
title('Velocidad angular \omega(t)');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}' );
legend('Location','southeast');

text(80,6500,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA CORRIENTE DESCARGA
subplot(3,1,3)

hold on
plot(t,i_d,'LineWidth',1.2)
title('Corriente i(t)');
xlabel('t[s]'); 
ylabel('i [A]');
legend('i (t)');
legend('Location' ,'northeast');
grid on

%% ANALISIS POTENCIA Y ENERGÍA DESCARGA

B1 = 1e-4;                      %definir nuevamente constante de fricción
tao_F = ki*i_d - B1*w_d;
P_F = (tao_F).*w_d;             %comportamiento potencia en J
tao_B = B1*w_d;
P_B = (tao_B).*w_d;             %potencia perdida por friccion B
tao_G = ki*i_d;
P_mec = (tao_G).*w_d;

P_elec = i_d.*v_d';             %potencia electrica

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

text(80,6500,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA POTENCIA DESCARGA

P_ss = 56;
subplot(3,1,2)

hold on
plot(t,P_F,t,P_B,t,P_mec,t,P_elec,'LineWidth',1.2)
title('Comportamiento Potencia');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P_{flywheel}','P_{loss,B}','P_{mec}','P_{elec}','Orientation','horizontal');
legend('Location','east');

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

text(80,2943000,'E_{max} \cong 3.27 MJ')

grid on