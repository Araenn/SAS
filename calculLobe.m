function [lobeFacteur, lobeSAS] = calculLobe(poids, draw)
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
    
    if draw == 1
        figure()
        plot(u, 20*log(abs(lobeTransducteur)))
        hold on
        plot(u, 20*log(abs(lobeFacteur)/maxFacteur))
        plot(u, 20*log(abs(lobeSAS)/maxFacteur))
        legend("Transducteur", "Facteur d'antenne", "SAS")
        grid()
    end
end