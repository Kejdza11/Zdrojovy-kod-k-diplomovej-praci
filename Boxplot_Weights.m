function [whisker_ranges, idx, nonzero_weights] = Boxplot_Weights(weights, portfolio_name)

% **Nastavenie prahovej hodnoty pre zanedbate�n� v�hy**
threshold = 1e-5; % Ak v�ha < 0.0001, pova�ujeme ju za nulov�

% Zistenie akt�v, ktor� boli niekedy pou�it� (nenulov� v�hy)
active_assets = any(weights > threshold, 1); % Logick� vektor (1 = akt�vne)
active_indices = find(active_assets); % Indexy akt�vnych akt�v (��sla st�pcov)
nonzero_weights = size(active_indices);

figure;
boxplot(weights, 'Labels', arrayfun(@(x) sprintf('%d', x), 1:size(weights, 2), 'UniformOutput', false));
ylim([0 1]);
% **Nastavenie x-osi tak, aby zobrazovala iba akt�vne akt�va**
set(gca, 'XTick', active_indices); % Nastavenie zna�iek na x-osi len pre akt�vne akt�va
set(gca, 'XTickLabel', arrayfun(@(x) sprintf('%d', x), active_indices, 'UniformOutput', false)); % Nastavenie popiskov
xtickangle(90); % Oto�enie popisov na x-osi o 45 stup�ov

xlabel('Akcie');
ylabel('V�hy portf�lia');
title(portfolio_name);

% Nastavenie ve�kosti p�sma (funguje pre os, legendu, ticks, at�.)
set(gca, 'FontSize', 14);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predpoklad: W je matica (12 obdob� x po�et akci�)
num_assets = size(weights,2); % po�et akci�
whisker_ranges = zeros(num_assets,1); % v�sledn� vektor rozsahov f�zov
real_upper_whiskers = zeros(num_assets,1);
real_lower_whiskers = zeros(num_assets,1);

for i = 1:num_assets
    asset_weights = weights(:, i); % v�hy konkr�tnej akcie cez v�etky obdobia

    % kvartily
    Q1 = prctile(asset_weights, 25);
    Q3 = prctile(asset_weights, 75);
    IQR = Q3 - Q1;

    % teoretick� hranice f�zov
    lower_bound = Q1 - 1.5*IQR;
    upper_bound = Q3 + 1.5*IQR;

    % re�lne koncov� body f�zov (z d�t bez outlierov)
    real_lower_whisker = min(asset_weights(asset_weights >= lower_bound));
    real_upper_whisker = max(asset_weights(asset_weights <= upper_bound));

    % Rozsah f�zov pre t�to akciu
    whisker_ranges(i) = real_upper_whisker - real_lower_whisker;
    real_upper_whiskers(i) = real_upper_whisker;
    real_lower_whiskers(i) = real_lower_whisker;
end

[whisker_ranges, idx] = max(whisker_ranges);

end