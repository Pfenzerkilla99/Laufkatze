function [u] = relativePower(M, wmVal)
% Gibt Motorleistung u bei gegebenem Motormoment M und Motordrehzahl wm
% zurück
%   Berechnung anhand der Vorgaben und Kennlinie aus Skript S.7

% Fehlt delta Beschränkung Betrag < 3
syms P delta Mcalc wmknick wm
Mmax = sqrt(abs(P))/9.434;     % Nm
wmmax = 17.9; % rad/s
Pmax = 3.56; % W

eqn= sign(wm)*(abs(P)/wm-Mmax)==Mmax;
wmknick = solve(eqn,wm)

if M >= 0 & M >= 2/9.434^2*wm
    P = (M*9.434)^2; % muss kleiner < Pmax
elseif    
eqn = M
u = P*100/Pmax-delta;
end
end