clc
clear
close all

% Parámetros Zhou R≠0


R = 0.2;                           % Ohm, case that the superconductor material has zero resistance (R = 0)
L = 0.5;                            % H
V_in = 100;                         % V
E_max = 62500;                       % Joules

%% Gráfica de i(t) carga/descarga para la EDO del modelo circuital

%% CARGA

t = linspace(0,20,200);
v_c = [V_in*ones(1,200)]';

sys_i = tf([1],[L R]);
i_c = lsim(sys_i, v_c, t);

%% DESCARGA

RL = 1;
k = -((R+RL)/L);
i0 = 499.832268686048;
i_d = i0*exp(k.*t);
i_d = i_d';
t1 = linspace(0,40,400);
i = [i_c ; i_d ];
v_d = RL*i_d;
v = [v_c ; v_d];

p_c = i_c.*v_c;
p_d = i_d.*v_d;

p = [p_c ; p_d];

E_c = 0.5*L.*i_c.*i_c;
E_d = 0.5*L.*i_d.*i_d;

E = [E_c ; E_d];


%% COMPORTAMIENTO POTENCIA ciclo con carga

subplot(4,1,1)

hold on
plot(t1,p,'LineWidth',1.2);
title('Potencia SMES');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P(t)');
legend('Location','east');

grid on

%% COMPORTAMIENTO DE LA ENERGIA CARGA / STORAGE MODE

subplot(4,1,2)

hold on
plot(t1,E,'LineWidth',1.2)
title('Energía SMES');
xlabel('t [s]'); 
ylabel('E [J]');
legend('E (t)');
legend('Location','east');

grid on

%% COMPORTAMIENTO DE Corriente

subplot(4,1,3)

hold on
plot(t1,i,'LineWidth',1.2)

title('Corriente SMES');
xlabel('t [s]'); 
ylabel('i [A]');
legend('i (t)');
legend('Location','east');

grid on

%% COMPORTAMIENTO DE LA TENSIÓN

subplot(4,1,4)

hold on
plot(t1,v,'LineWidth',1.2);
title('Tensión SMES');
xlabel('t [s]'); 
ylabel('V [V]');
legend('V(t)');
legend('Location','east');

grid on
