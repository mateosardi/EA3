% FUNCION DE TRANSFERENCIA DEL PLL
% Detector de fase utilizado: AD9901
% VCO utilizado: CVCO55CL-0925-0970

clear all; close all;clc;

% Frecuencias
f_min = 935e6; % Frecuencia mínima de 935 MHz
f_max = 960e6; % Frecuencia máxima de 960 MHz
f_r = 0.2e6; % Paso de 200 kHz

% Definición de constantes
kd = 0.2865; % Ganancia del detector de fase [V/rad]
kv = (990.784-901.632)*1e6*2*pi/(4.5-.2); % Ganancia del VCO [rad/s/V]
N = 4800; % Divisor de frecuencia
kn = 1/N; % Ganancia de realimentación

D_min = f_min/f_r; % Minima división
D_max = f_max/f_r; % Máxima división

% Variables del filtro
C = 1e-6; 

% Parámetros
tn = 1e-3; % Lock-up time
wn = 4.5/tn; % Frecuencia natural
dseta = 0.8; % Factor de amortiguamiento

T2 = 2*dseta/wn - N/(kd*kv); % Constante de tiempo 1
T1 = (kd*kv)/(wn^2*N) - T2; % Constante de tiempo 2
R2 = T2/C;
R1 = T1/C;

% Funciones de transferencia
s = tf('s');

VCO_s = kv/s; % FT del VCO
Df_s = kd; % FT del detector de fase
F_s = (1+s*T2)/(1+s*(T1+T2)); % FT del filtro
H_s = 1/D_max; % Lazo de realimentación (divisor de frecuencia)

G_s = Df_s*F_s*VCO_s; % FT a lazo abierto

T_s = f_r/D_min*G_s /(1 + G_s*H_s); % FT a lazo cerrado

step(T_s); % Respuesta al escalón
