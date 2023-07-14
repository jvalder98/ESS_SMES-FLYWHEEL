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

%% CARGA

v_c = [Vin*ones(1,250) zeros(1,250)] ;               % Tensión de Entrada Flywheel. Modo motor

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

FigE = figure;
figure (FigE);

%% COMPORTAMIENTO DE TENSION CARGA / STORAGE MODE

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

%% COMPORTAMIENTO DE LA VELOCIDAD ANGULAR CARGA / STORAGE MODE

subplot(3,1,2)

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

%% COMPORTAMIENTO DE LA CORRIENTE CARGA / STORAGE MODE
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

