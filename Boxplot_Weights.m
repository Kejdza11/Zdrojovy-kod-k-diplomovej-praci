function [whisker_ranges, idx, nonzero_weights] = Boxplot_Weights(weights, portfolio_name)

% **Nastavenie prahovej hodnoty pre zanedbate¾né váhy**
threshold = 1e-5; % Ak váha < 0.0001, považujeme ju za nulovú

% Zistenie aktív, ktoré boli niekedy použité (nenulové váhy)
active_assets = any(weights > threshold, 1); % Logický vektor (1 = aktívne)
active_indices = find(active_assets); % Indexy aktívnych aktív (èísla ståpcov)
nonzero_weights = size(active_indices);

figure;
boxplot(weights, 'Labels', arrayfun(@(x) sprintf('%d', x), 1:size(weights, 2), 'UniformOutput', false));
ylim([0 1]);
% **Nastavenie x-osi tak, aby zobrazovala iba aktívne aktíva**
set(gca, 'XTick', active_indices); % Nastavenie znaèiek na x-osi len pre aktívne aktíva
set(gca, 'XTickLabel', arrayfun(@(x) sprintf('%d', x), active_indices, 'UniformOutput', false)); % Nastavenie popiskov
xtickangle(90); % Otoèenie popisov na x-osi o 45 stupòov

xlabel('Akcie');
ylabel('Váhy portfólia');
title(portfolio_name);

% Nastavenie ve¾kosti písma (funguje pre os, legendu, ticks, atï.)
set(gca, 'FontSize', 14);
grid on;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% predpoklad: W je matica (12 období x poèet akcií)
num_assets = size(weights,2); % poèet akcií
whisker_ranges = zeros(num_assets,1); % výsledný vektor rozsahov fúzov
real_upper_whiskers = zeros(num_assets,1);
real_lower_whiskers = zeros(num_assets,1);

for i = 1:num_assets
    asset_weights = weights(:, i); % váhy konkrétnej akcie cez všetky obdobia

    % kvartily
    Q1 = prctile(asset_weights, 25);
    Q3 = prctile(asset_weights, 75);
    IQR = Q3 - Q1;

    % teoretické hranice fúzov
    lower_bound = Q1 - 1.5*IQR;
    upper_bound = Q3 + 1.5*IQR;

    % reálne koncové body fúzov (z dát bez outlierov)
    real_lower_whisker = min(asset_weights(asset_weights >= lower_bound));
    real_upper_whisker = max(asset_weights(asset_weights <= upper_bound));

    % Rozsah fúzov pre túto akciu
    whisker_ranges(i) = real_upper_whisker - real_lower_whisker;
    real_upper_whiskers(i) = real_upper_whisker;
    real_lower_whiskers(i) = real_lower_whisker;
end

[whisker_ranges, idx] = max(whisker_ranges);

end