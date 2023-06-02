% FUNCION DE TRANSFERENCIA DEL PLL

clear all; close all;clc;
% Definición de constantes
kd = 2; % Ganancia del detector de fase
kv = 2; % Ganancia del VCO
N = 20; % Divisor de frecuencia

% Variables del filtro
R1 = 500;
R2 = 500;
C = 1e-9;

T1 = R1*C;
T2 = R2*C;

% Funciones de transferencia
s = tf('s');

VCO_s = kv/s; % FT del VCO
Df_s = kd; % FT del detector de fase
F_s = (1+s*T2)/(1+s*(T1+T2)); % FT del filtro
H_s = 1/N; % Lazo de realimentación (divisor de frecuencia)

FTLA = Df_s*F_s*VCO_s;

T_s = FTLA /(1 + FTLA*H_s);
