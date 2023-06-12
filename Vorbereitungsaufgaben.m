close all
clear all

%Defintion Parameter Werte
k_val = 7.2e-3;
ms_val = 0.8;
l_val = 1;
r_val = 0.041;
g_val = 9.81;



% Definition Variablen
syms k ml ms l M r g t phi(t) x(t) u
syms z(t) [4 1]
dphi = diff(phi,t);
dx = diff(x,t);
% Definition Zustandsraum
z = [phi(t); dphi(t); x(t); dx(t)];
% u=M/r;

dz = [z(2);
    (-cos(z(1))*(-k*z(3)+u+l*ml*sin(z(1))*z(2)^2+g*ml*sin(z(1))*cos(z(1)))/(ml+ms-ml*cos(z(1))^2)-g*sin(z(1)))/l;
      z(4);
    (-k*z(3)+u+l*ml*sin(z(1))*z(2)^2+g*ml*sin(z(1))*cos(z(1)))/(ml+ms-ml*cos(z(1))^2)]

% physikalische Beschränkungen
% -2.5 <= z(3) <= 2.5
% -pi/4 <= z(1) <= pi/4

%% Berechnung Fixpunkte
%

%% Linearisierung
syms z10 z20 z30 z40 u0 
z0 = [z10; z20; z30; z40];

dz_lin = subs(dz, [z(2), z(4), z(1), z(3)], [z0(2), z0(4), z0(1), z0(3)]) + subs(jacobian(dz, z), [z(2), z(4), z(1), z(3)], [z0(2), z0(4), z0(1), z0(3)])*(z-z0)
%% Linearisierung um den stationären Punkt
A = jacobian(dz, z);
A = subs(A, [z(2), z(4)], [z0(2), z0(4)]);
A = subs(A, [z(1), z(3)], [z0(1), z0(3)]);
A = subs(A, u, u0);

B = subs(jacobian(dz, u), u, u0);
B = subs(B, [z(2), z(4)], [z0(2), z0(4)]);
B = subs(B, [z(1), z(3)], [z0(1), z0(3)]);

C = [[1 0 0 0];
     [0 0 1 0]];

D = [0; 0];

dz_lin = A*(z-z0) + B*(u-u0)

A = subs(A, z0, [0;0;0;0]);
B = subs(B, z0, [0;0;0;0]);

dz_lin = A*z + B*(u-u0)
y = C*z 

%% Eigenwerte, Steuerbarkeitsmatrix und Beobachtbarkeitsmatrix
Eigenwerte = eig(A);
subs(Eigenwerte, [k, ms, r, l, g], [k_val, ms_val, r_val, l_val, g_val])
disp(Eigenwerte)

A1 = A*B;
A2 = A*A1;
A3 = A*A2;
S=[B, A1, A2, A3];
% S = ctrb(A,B)
det(S)
rank(S)

C1 = C*A;
C2 = C1*A;
C3 = C2*A;
P=[C;C1;C2;C3];
% P = obsv(A,C)
rank(P)

%% Übertragungsfunktinonen
syms s
% s = tf('s');    %falls Toolbox installiert das benutzen


G1 = [1, 0, 0, 0]*((s*eye(4)-A)\B) + D(1)
G2 = [0, 0, 1, 0]*((s*eye(4)-A)\B) + D(2)









