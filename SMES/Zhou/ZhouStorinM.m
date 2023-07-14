clc
clear
close all

% Parámetros Zhou R≠0


R = 0.2;% Ohm, case that the superconductor material has zero resistance (R = 0)
L = 0.5;% H
V_in = 100;                         % V
E_max = 62500;                       % Joules

% Critical coil current (A) 552

i_max = 500;           % corriente máxima segun la capacidad en Joule

t_c = 9;                            % Se define un tiempo de carga menor a 9.936 segundos, formato entero.
t = linspace(0,60,1000);  
v_c = [V_in*ones(1,500) zeros(1,500)]; %perfil de tensión de carga


%% G(s) = I(s)/V(s)

sys_i = tf([1],[L R]);
i_c = lsim(sys_i, v_c, t);

FigE = figure;
figure (FigE);

subplot(3,1,1)

hold on
plot(t,i_c,'LineWidth',1.2)
plot(t,v_c,'LineWidth',1.2)
yline(i_max,'-.','LineWidth',1.2)

title('i [A], v [V]');
xlabel('t[s]'); 
ylabel('i [A], v_c [V]');
legend({'i (t)', 'v_c (t)','i_{L,crítica}'});
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA POTENCIA DEL ALMACENADOR CARGA /DESCONEXIÓN DE FUENTE

subplot(3,1,2)
p_sm=v_c'.*i_c;

hold on
plot(t,p_sm,'LineWidth',1.2)
title('P_{smes}');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P [W]');
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA ENERGÍA DEL ALMACENADOR CARGA /DESCONEXIÓN DE FUENTE
subplot(3,1,3)
E_smes = 0.5*L.*i_c.*i_c;

% Fig_i_E = figure;
% figure (Fig_i_E);


hold on
plot(t,E_smes,'color',"#D95319",'LineWidth',1.2)
yline(E_max,'-.','LineWidth',1.2)
title('E_{smes} [J]');
xlabel('t[s]'); 
ylabel('E [J]');
legend({'E_{smes} (t)', 'E_{max}'});
legend('Location' ,'east');
grid on