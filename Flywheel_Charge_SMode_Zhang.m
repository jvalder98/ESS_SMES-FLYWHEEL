clc
clear 
close all

%% EMULACION FLYWHEEL CON PMDCM - CHARGE - STORING MODE

%% Parámetros Zhang

L = 3.6e-3;
R = 0.5;
J = 0.123;
kb = 0.062070427805750; % V/rad/s
ki = 0.066845076098500;
B = 1e-4;
Vin = 48;
w_ss = 7296.67611231985;                           % velocidad angular en estado estable
i_ss = 1.14321362082603;                           % corriente en estado estable

t = linspace(0,120,500);                          % Se define el tiempo

%% CARGA STORORING MODE

v_c = Vin*ones(1,500);               % Tensión de Entrada Flywheel. Modo motor

% Modelo Espacios de Estado CHARGE - STORING MODE

A = [-R/L , -kb/L ; ki/J , -B/J ];
B = [ 1/L ; 0 ];
C = [0 , 1; 1 , 0];
D = 0;
sys = ss(A,B,C,D);
u = v_c;
w = lsim(sys,u,t);

w_c = 9.5492965855*w(:,1);          % velocidad angular / conversión rad/s a rpm
i_c = w(:,end);                      % corriente

Figc = figure;
figure (Figc);

%% COMPORTAMIENTO DE TENSION CHARGE - STORING MODE

subplot(3,1,1)

hold on
plot(t,v_c,'LineWidth',1.2)
title('Tensión V(t)');
xlabel('t[s]'); 
ylabel('V [V]');
ylim([0 60])
legend('V (t)');
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA VELOCIDAD ANGULAR CHARGE - STORING MODE

subplot(3,1,2)

hold on
plot(t,w_c,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
title('Velocidad angular \omega(t)');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}' );
legend('Location','southeast');

text(80,6500,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA CORRIENTE CHARGE - STORING MODE
subplot(3,1,3)

hold on
plot(t,i_c,'LineWidth',1.2)
yline(i_ss,'-.','LineWidth',1.2)                    % corriente en estado estable
title('Corriente i(t)');
xlabel('t[s]'); 
ylabel('i [A]');
legend({'i (t)', 'i_{ss}'});
legend('Location' ,'northeast');

text(80,20,'i_{ss} \cong 1.1432 A')

grid on

%% ANALISIS POTENCIA Y ENERGÍA CHARGE - STORING MODE

B1 = 1e-4;                      %definir nuevamente constante de fricción
tao_F = ki*i_c - B1*w_c;
P_F = (tao_F).*w_c;             %comportamiento potencia en J
tao_B = B1*w_c;
P_B = (tao_B).*w_c;             %potencia perdida por friccion B
tao_G = ki*i_c;
P_mec = (tao_G).*w_c;

P_elec = i_c.*v_c';             %potencia electrica

E_c = 0.5*J*w_c.*w_c;
E_max = 0.5*J*w_ss*w_ss;

FigPE = figure;
figure (FigPE);

%% COMPORTAMIENTO DE VELOCIDAD ANGULAR CHARGE - STORING MODE

subplot(3,1,1)

hold on
plot(t,w_c,'LineWidth',1.2)
yline(w_ss,'-.','LineWidth',1.2)           % velocidad angular en estado estable
title('Velocidad angular \omega(t)');
xlabel('t [s]'); 
ylabel('\omega [rpm]');
legend('\omega (t)','\omega_{ss}' );
legend('Location','east');

text(80,6500,'\omega_{ss} \cong 7296.6 rpm')

grid on

%% COMPORTAMIENTO DE LA POTENCIA CHARGE - STORING MODE
P_ss = 56;
subplot(3,1,2)

hold on
plot(t,P_F,t,P_B,t,P_mec,t,P_elec,'LineWidth',1.2)
yline(P_ss,'-.','LineWidth',1.2)           % Potencia en estado estable
title('Comportamiento Potencia');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P_{flywheel}','P_{loss,B}','P_{mec}','P_{elec}','P_{ss}','Orientation','horizontal');
legend('Location','northeast');

text(80,2500,'P_{ss} \cong 56 W')

grid on

%% COMPORTAMIENTO DE LA ENERGIA CHARGE - STORING MODE

subplot(3,1,3)

hold on
plot(t,E_c,'LineWidth',1.2)
yline(E_max,'-.','LineWidth',1.2)           % Energía máxima
title('Energía de la Flywheel');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E (t)','E_{max}' );
legend('Location','east');

text(80,2943000,'E_{max} \cong 3.27 MJ')

grid on
