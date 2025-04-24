function [whisker_ranges, idx, nonzero_weights] = Boxplot_Weights(weights, portfolio_name)

% Nastavenie hranice pre nenulové váhy :
threshold = 1e-5; % Ak je váha < 0.00001, považujeme ju za nulovú

% Zistenie váh, ktoré boli niekedy nenulové :
active_assets = any(weights > threshold, 1); 
active_indices = find(active_assets);
nonzero_weights = size(active_indices);

figure;
boxplot(weights, 'Labels', arrayfun(@(x) sprintf('%d', x), 1:size(weights, 2), 'UniformOutput', false));
ylim([0 1]);
% Aby x-ová os zobrazovala iba nenulové akcie :
set(gca, 'XTick', active_indices);
set(gca, 'XTickLabel', arrayfun(@(x) sprintf('%d', x), active_indices, 'UniformOutput', false));
xtickangle(90); % Otoèenie popisov na x-vej osi o 45 stupòov
xlabel('Akcie');
ylabel('Váhy portfólia');
title(portfolio_name);
set(gca, 'FontSize', 14);
grid on;

%%%%%%
num_assets = size(weights,2); % poèet akcií
whisker_ranges = zeros(num_assets,1); % výsledný vektor rozsahov fúzov
real_upper_whiskers = zeros(num_assets,1);
real_lower_whiskers = zeros(num_assets,1);

for i = 1:num_assets
    asset_weights = weights(:, i);

    % kvartily :
    Q1 = prctile(asset_weights, 25);
    Q3 = prctile(asset_weights, 75);
    IQR = Q3 - Q1;

    % teoretické hranice fúzov :
    lower_bound = Q1 - 1.5*IQR;
    upper_bound = Q3 + 1.5*IQR;

    % konce fúzov (bez outlierov) :
    real_lower_whisker = min(asset_weights(asset_weights >= lower_bound));
    real_upper_whisker = max(asset_weights(asset_weights <= upper_bound));

    % Rozsah fúzov :
    whisker_ranges(i) = real_upper_whisker - real_lower_whisker;
    real_upper_whiskers(i) = real_upper_whisker;
    real_lower_whiskers(i) = real_lower_whisker;
end

[whisker_ranges, idx] = max(whisker_ranges);

end