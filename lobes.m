clc; clear; close all

N = 41; % nombre de pings
D = 0.5; % distance ping
t = (0:N-1);
lambda = 5e-3;
L = 1; % longueur antenne
pu = 10000;
u = linspace(-2, 2, pu)';

gam = D*u(1);
poids = ones(N, 1); % pings
%poids(5) = 0; % ping perdu

calculLobe(poids, 1);
title("Antenne parfaite")

calculLobe(exp(-2 * 1i * D/L * t * gam)', 1);
title("\gamma constant, = D*u_0")

gam = 2;
calculLobe(exp(-2 * 1i * D/L * t * gam)', 1);
title("\gamma constant= ", num2str(gam))

gam = randn(N, 1);
for i = 1:N
    [lobeFacteur(:,i), lobeSAS(:,i)] = calculLobe(exp(-2 * 1i * D/L * t * gam(i))', 0);
    %title("\gamma randn = ", num2str(gam(i)))
end

moyLobeFacteur = lobeFacteur/N;
moyLobeSAS = lobeSAS/N;

figure()
plot(u, 20*log(abs(sinc(u))))
hold on
plot(u, 20*log(abs(moyLobeFacteur)/max(moyLobeFacteur)))
plot(u, 20*log(abs(moyLobeSAS)/max(moyLobeSAS)))
legend("Transducteur", "Facteur d'antenne empirique", "SAS empirique")
grid()
title("Moyenne empirique des randn")
