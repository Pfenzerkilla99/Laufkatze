clear all
close all
%% Parameter und Modelldefinition
ml=1.0000000;
A =[0 1 0 0;
    -9.81*(1+ml/0.8) 0 0 0.009;
    0 0 0 1;
    12.26*ml 0 0 -0.009];
B = [0;
     -30.49;
     0;
     30.49];
s = tf('s');

Gy1 = (-s)/((0.8*s^3 + 0.0072*s^2 + 9.81*(0.8+ml)*s +0.071)*0.041);

Gy2 = (s^2 + 9.81)/(s*((0.8*s^3 + 0.0072*s^2)+9.81*(0.8+ml)*s + 0.071)* 0.041);




%% Regler im Frequenzbereich
%% Postionsregelung Laufkatze
figure(1)
bode(Gy2)
figure(2)
nyquistplot(Gy2)
figure(3)
poles_Gy2 = pole(Gy2)
plot(poles_Gy2,'o')

% Nyquist-Kriterium 
% a0 = 1 --> delta-phi_soll = pi/2
% Pole: 0.0000 + 0.0000i
%      -0.0025 + 4.6981i
%      -0.0025 - 4.6981i
%      -0.0040 + 0.0000i
% ohne Regler delta-phi_ist = pi/2
% jeder Regler mit k>0 stabilisiert die Strecke

%% Aktive Schwingungsdämpfung
figure(1)
bode(Gy1)
figure(2)
nyquistplot(Gy1)
figure(3)
poles_Gy1 = pole(Gy1)
plot(poles_Gy1,'o')

% Nyquist-Kriterium 
% a0 = m0 = 0 --> delta-phi_soll = 0
% Pole: 
%      -0.0025 + 4.6981i
%      -0.0025 - 4.6981i
%      -0.0040 + 0.0000i
% ohne Regler delta-phi_ist = -2*pi
% jeder Regler mit k < 0.2 stabilisiert die Strecke, k auch negativ