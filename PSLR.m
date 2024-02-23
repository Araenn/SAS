function err = PSLR(SAS)
    [Ip, Ip_index] = max(20*log10(abs(SAS)));
    Is_peaks = findpeaks(20*log10(abs(SAS(Ip_index:Ip_index + 200)))); % Trouver les pics dans SAS à partir de Ip_index
    Is = max(Is_peaks); % Trouver le lobe secondaire le plus proche du pic

    % Calcul du PSLR
    err = Is - Ip;
end
