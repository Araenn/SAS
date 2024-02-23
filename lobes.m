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

%% antenne parfaite
calculLobe(poids, zeros(1,N), 1);
title("Antenne parfaite")
%% erreur constante
calculLobe(exp(-2 * 1i * D/L * t * gam)', gam*ones(1,N), 1);
title("\gamma constant, = D*u_0")

gam = 2;
calculLobe(exp(-2 * 1i * D/L * t * gam)', gam*ones(1,N), 1);
title("\gamma constant = " + num2str(gam))

%% erreur randn
n = 1;
moyGam = zeros(1, N);
for i = 1:n
    gam = randn(1, N);
    [lobeFacteur(:,i), lobeSAS(:,i)] = calculLobe(exp(-2 * 1i * D/L * t .* gam)', gam, 0);
    %title("\gamma randn = ", num2str(gam(i)))
    moyGam = gam + moyGam;
end
moyGam = moyGam / N;
moyLobeFacteur = lobeFacteur/N;
%moyLobeFacteur = mean(lobeFacteur, 2);
moyLobeSAS = lobeSAS/N;
%moyLobeSAS = mean(lobeSAS, 2);
% moyLobeFacteur = lobeFacteur;
% moyLobeSAS = lobeSAS;

figure()
subplot(1,2,1)
plot(u, 20*log10(abs(sinc(u))))
hold on
plot(u, 20*log10(abs(moyLobeFacteur)/max(moyLobeFacteur)))
plot(u, 20*log10(abs(moyLobeSAS)/max(moyLobeSAS)))
legend("Transducteur", "Facteur d'antenne empirique", "SAS empirique")
grid()
ylabel("dB")
title("Moyenne empirique des randn")
ylim([-50, 0])
subplot(1,2,2)
plot(real(moyGam))
xlabel("Nombre de pings")
grid()
%% erreur sin
f = 1; % nbre oscillations/ping
a = 2;
gam = a * sin(2*pi*f*t/N);
[l, lobeSAS] = calculLobe(exp(1i * gam)', gam, 1);

title("Erreur sinusoïdale, f = " + num2str(f) + " oscillation/ping et a = " + num2str(a) + "°")
%% affichage

