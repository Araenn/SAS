function [lobeFacteur, lobeSAS] = calculLobe(poids, gam, draw)
    N = 41; % nombre de pings
    D = 0.5; % distance ping
    t = (0:N-1);
    lambda = 5e-3;
    L = 1; % longueur antenne
    pu = 10000;
    u = linspace(-2, 2, pu)';
    phi = exp(4 * 1i * pi * D/L * u * t); % antenne parfaite
   
    
    
    lobeTransducteur = sinc(u);
    lobeFacteur = phi * poids;
    lobeSAS = lobeFacteur .* lobeTransducteur;
    
    maxFacteur = max(abs(lobeFacteur));
    err = PSLR(abs(lobeSAS)/maxFacteur)
    if draw == 1
        figure()
        subplot(1,2,1)
        plot(u, 20*log10(abs(lobeTransducteur)))
        hold on
        plot(u, 20*log10(abs(lobeFacteur)/maxFacteur))
        plot(u, 20*log10(abs(lobeSAS)/maxFacteur))
        legend("Transducteur", "Facteur d'antenne", "SAS")
        ylabel("dB")
        grid()
        ylim([-50, 0])
        subplot(1,2,2)
        plot(gam)
        xlabel("Nombre de pings")
        grid()
    end
end