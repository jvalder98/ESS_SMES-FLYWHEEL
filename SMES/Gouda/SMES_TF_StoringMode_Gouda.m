clc
clear
close all

%% Parámetros Gouda

R = 0;                              % Ohm, caso material superconductor resistencia nula
L = 1.8;                            % H
V_in = 100;                         % V
E_max = 270e3;                      % Emax en Joules

i_max = sqrt(2*E_max./L);           % corriente máxima depende de la Emax
t_c_max = L*i_max/V_in;             % tiempo en alcanzar la carga máxima
t_c = 9;                            % Se define un tiempo de carga menor a 9.936 segundos, formato entero.
t = linspace(0,20,200);  
v_c = [V_in*ones(1,(t_c*200/20)) zeros(1,200-(t_c*200/20))]; %perfil de tensión de carga


%% G(s) = I(s)/V(s)

sys_i = tf([1],[L R]);
i = lsim(sys_i, v_c, t);

FigE = figure;
figure (FigE);

%% COMPORTAMIENTO DE TENSION Y CORRIENTE CARGA / STORAGE MODE

subplot(3,1,1)

hold on
plot(t,i,'LineWidth',1.2)
plot(t,v_c,'LineWidth',1.2)
yline(i_max,'-.','LineWidth',1.2)
xline(t_c_max,'-.','color', 'r', 'LineWidth',1.2)
title('i [A], v [V]');
xlabel('t[s]'); 
ylabel('i [A], v_c [V]');
legend({'i (t)', 'v_c (t)','i_{L,crítica}','t_{carga máx}'});
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA POTENCIA CARGA / STORAGE MODE

subplot(3,1,2)
p_sm=v_c'.*i;

hold on
plot(t,p_sm,'LineWidth',1.2)
title('P_{smes}');
xlabel('t [s]'); 
ylabel('P [W]');
legend('P [W]');
legend('Location','east');
grid on

%% COMPORTAMIENTO DE LA ENERGÍA CARGA / STORAGE MODE
subplot(3,1,3)
E_smes = 0.5*L.*i.*i;

hold on
plot(t,E_smes,'color',"#D95319",'LineWidth',1.2)
yline(E_max,'-.','LineWidth',1.2)
title('E_{smes} [J]');
xlabel('t[s]'); 
ylabel('E [J]');
legend({'E_{smes} (t)', 'E_{max}'});
legend('Location' ,'east');
grid on