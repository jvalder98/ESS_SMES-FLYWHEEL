clc
clear
close all

% Parámetros Gouda

R = 0;                              % Ohm, caso material superconductor resistencia nula
L = 1.8;                            % H
V_in = 100;                         % V
E_max = 270e3;                      % Joules

%% Gráfica de i(t) carga/descarga para la EDO del modelo circuital

%% CARGA

i_max = sqrt(2*E_max./L);           % corriente máxima segun la capacidad en Joule
t_c_max = L*i_max/V_in;             % tiempo en alcanzar la carga maxima

t = linspace(0,t_c_max,200);
v_c = [V_in*ones(1,200)];

i_c = (V_in./L).*t ;                % Ecuación de Carga SMES

% Potencia carga
p_c = v_c.*i_c;

%%%%%
Fig_i = figure;
figure (Fig_i);
title("Carga y descarga SMES, R=0")
hold on
plot(t,i_c,'LineWidth',1.2)
plot(t,v_c,'LineWidth',1.2)
xlim([0 (t_c_max+6)])
yline(i_max,'-.','LineWidth',1.2)
xline(t_c_max,'-.','color', 'r','LineWidth',1.2)
title('i [A], v_c [V]');
xlabel('t[s]'); 
ylabel('i [A], v_c [V]');
legend({'i (t)', 'v_c (t)','i_{L,crítica}','t_{carga máx}'});
legend('Location','east');
grid on
%%%%%%%%
title("Carga SMES, R=0")




%% DESCARGA

v_d = [V_in*ones(1,200)];
i_d = i_max - (V_in./L).*t ; % Ecuación de Descarga SMES

% Potencia descarga
p_d = v_d.*i_d;

%%%%%%%%%%%
Fig_i_d = figure;
figure (Fig_i_d);

hold on
plot(t,i_d,'LineWidth',1.2)
plot(t,v_d,'LineWidth',1.2)
xlim([0 (t_c_max+6)])
yline(i_max,'-.','LineWidth',1.2)
title('i [A], v_d [V]');
xlabel('t[s]'); 
ylabel('i [A], v_d [V]');
legend({'i (t)', 'v_d (t)','i_{L,crítica}'});
legend('Location','east');
grid on
%%%%%%%%%%%%%
title("Descarga SMES, R=0")

p_comp = [p_c zeros(1,100) p_d];
t_comp = linspace(0,2.5*t_c_max,500);
v_comp = [v_c zeros(1,100) v_d];
i_comp = [i_c i_max*ones(1,100) i_d];
E_comp = 0.5*L.*i_comp.*i_comp;

FigP = figure;
figure (FigP);

subplot(4,1,1)
plot(t_comp,p_comp,'LineWidth',1.2) 
xlim([0 2.5*t_c_max])
%xlabel('t [s]')
ylabel('P [W]')
title('P_{SMES}')
grid on

subplot(4,1,2)
plot(t_comp,E_comp,'LineWidth',1.2) 
xlim([0 2.5*t_c_max])
%xlabel('t [s]')
ylabel('E [J]')
title('E_{SMES}')
grid on

subplot(4,1,3)
plot(t_comp,i_comp,'LineWidth',1.2)
xlim([0 2.5*t_c_max])
%xlabel('t [s]')
ylabel('i [A]')
title('i_{SMES}')
grid on

subplot(4,1,4)
plot(t_comp,v_comp,'LineWidth',1.2)
xlim([0 2.5*t_c_max])
xlabel('t [s]')
ylabel('V [V]')
title('V_{SMES}')
grid on
