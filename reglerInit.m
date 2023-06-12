%% Initialisierung des Reglers
tSim = 1;

% k_Position aus sisotool Trim: 6.92e-7
k_Position = 6.92;


%Zustandsregler
ml=1.0000000;
A =[0 1 0 0;
    -9.81*(1+ml/0.8) 0 0 0.009;
    0 0 0 1;
    12.26*ml 0 0 -0.009];
B = [0;
     -30.49;
     0;
     30.49];

P = [-1, -1.001, -1.0002, -0.999];

k_zust = place(A, B, P);

C = [1 0 0 0;
    0 0 0 0;
    0 0 1 0;
    0 0 0 0];

P_Beobachter = [-10, -10.0001, -10.0002, -9.999];

E = place(A', C', P_Beobachter)';

