clc
clear
close all

% Parámetros Gouda

R = 0;                              % Ohm, caso material superconductor resistencia nula
L = 1.8;                            % H
E_max = 270e3;                      % Joules

%% Gráfica de i(t) carga/descarga para la EDO del modelo circuital

%% CARGA

Figvar_carga = figure;
figure (Figvar_carga);

% CARGA cambio V
subplot(1,2,1)

hold on

i_max = sqrt(2*E_max./L);             % corriente máxima segun la capacidad en Joule

t = linspace(0,20,200);

V_in = 50;
i_c = (V_in./L).*t ;                     % Ecuación de Carga SMES

hold on

yline(i_max,'-.','LineWidth',1.2)
plot(t,i_c,'LineWidth',1.2)
hold on;

%%%%%
V_in = 75;          
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 100;           
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 125;            
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 150;             
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
ylim([0 i_max])
hold on;
%%%%%%

xlim([0 22])
ylim([0 600])
title('i [A], variando Vin');
xlabel('t [s]'); 
ylabel('i [A]');

legend({'i_{L,crítica}','i1(V=50V)','i2(V=75V)','i3(V=100V)','i4(V=125V)','i5(V=150V)'});
legend('Location','southeast');
grid on

%% CARGA cambio L
subplot(1,2,2)

hold on

t = linspace(0,60,200);

L=0.1;
V_in = 100;
i_c = (V_in./L).*t ;                  % Ecuación de Carga SMES

yline(i_max,'-.','LineWidth',1.2)
plot(t,i_c,'LineWidth',1.2)
hold on;

%%%%%
L=1;            
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
L= 1.8;            
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
L = 5;            
i_c = (V_in./L).*t ;                   
plot(t,i_c,'LineWidth',1.2)
hold on;
%%%%%%
L = 10;           
i_c = (V_in./L).*t ;                  
plot(t,i_c,'LineWidth',1.2)
ylim([0 i_max])
hold on;
%%%%%%

xlim([0 60])
ylim([0 600])
title('i [A], variando L');
xlabel('t [s]'); 
ylabel('i [A]');

legend({'i_{L,crítica}','i1(L=0.1)','i2(L=1)','i3(L=1.8)','i4(L=5)','i5(L=10)'});
legend('Location','southeast');
grid on

%% DESCARGA

L = 1.8;                            % H

Figvar_descarga = figure;
figure (Figvar_descarga);

% DESCARGA cambio V
subplot(1,2,1)

hold on

i_max = sqrt(2*E_max./L);             % corriente máxima segun la capacidad en Joule

t = linspace(0,20,200);

V_in = 50;
i_d = i_max - (V_in./L).*t ;          % Ecuación de desarga SMES

hold on

yline(i_max,'-.','LineWidth',1.2)
plot(t,i_d,'LineWidth',1.2)
hold on;

%%%%%
V_in = 75;
i_d = i_max - (V_in./L).*t;           % Ecuación de desarga SMES 
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 100;
i_d = i_max - (V_in./L).*t;           % Ecuación de desarga SMES 
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 125;
i_d = i_max - (V_in./L).*t ;          % Ecuación de desarga SMES
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
V_in = 150;
i_d = i_max - (V_in./L).*t ;          % Ecuación de desarga SMES
plot(t,i_d,'LineWidth',1.2)
ylim([0 i_max])
hold on;
%%%%%%

xlim([0 22])
ylim([0 600])
title('i [A], variando Vout');
xlabel('t [s]'); 
ylabel('i [A]');

legend({'i_{L,crítica}','i1(V=50V)','i2(V=75V)','i3(V=100V)','i4(V=125V)','i5(V=150V)'});
legend('Location','northeast');
grid on

%%

subplot(1,2,2)

%% DESCARGA cambio L

hold on

t = linspace(0,60,200);

L=0.1;
V_in = 100;
i_d = i_max - (V_in./L).*t;           % Ecuación de desarga SMES

yline(i_max,'-.','LineWidth',1.2)
plot(t,i_d,'LineWidth',1.2)
hold on;

%%%%%
L=1;
i_d = i_max - (V_in./L).*t ;          
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
L= 1.8;
i_d = i_max - (V_in./L).*t ;         
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
L = 5;
i_d = i_max - (V_in./L).*t ;          
plot(t,i_d,'LineWidth',1.2)
hold on;
%%%%%%
L = 10;
i_d = i_max - (V_in./L).*t;           
plot(t,i_d,'LineWidth',1.2)
ylim([0 i_max])
hold on;
%%%%%%

xlim([0 60])
ylim([0 600])
title('i [A], variando L');
xlabel('t [s]'); 
ylabel('i [A]');

legend({'i_{L,crítica}','i1(L=0.1)','i2(L=1)','i3(L=1.8)','i4(L=5)','i5(L=10)'});
legend('Location','northeast');
grid on
