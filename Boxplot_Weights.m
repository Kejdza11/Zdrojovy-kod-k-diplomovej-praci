function [whisker_ranges, idx, nonzero_weights] = Boxplot_Weights(weights, portfolio_name)

% Nastavenie hranice pre nenulov� v�hy :
threshold = 1e-5; % Ak je v�ha < 0.00001, pova�ujeme ju za nulov�

% Zistenie v�h, ktor� boli niekedy nenulov� :
active_assets = any(weights > threshold, 1); 
active_indices = find(active_assets);
nonzero_weights = size(active_indices);

figure;
boxplot(weights, 'Labels', arrayfun(@(x) sprintf('%d', x), 1:size(weights, 2), 'UniformOutput', false));
ylim([0 1]);
% Aby x-ov� os zobrazovala iba nenulov� akcie :
set(gca, 'XTick', active_indices);
set(gca, 'XTickLabel', arrayfun(@(x) sprintf('%d', x), active_indices, 'UniformOutput', false));
xtickangle(90); % Oto�enie popisov na x-vej osi o 45 stup�ov
xlabel('Akcie');
ylabel('V�hy portf�lia');
title(portfolio_name);
set(gca, 'FontSize', 14);
grid on;

%%%%%%
num_assets = size(weights,2); % po�et akci�
whisker_ranges = zeros(num_assets,1); % v�sledn� vektor rozsahov f�zov
real_upper_whiskers = zeros(num_assets,1);
real_lower_whiskers = zeros(num_assets,1);

for i = 1:num_assets
    asset_weights = weights(:, i);

    % kvartily :
    Q1 = prctile(asset_weights, 25);
    Q3 = prctile(asset_weights, 75);
    IQR = Q3 - Q1;

    % teoretick� hranice f�zov :
    lower_bound = Q1 - 1.5*IQR;
    upper_bound = Q3 + 1.5*IQR;

    % konce f�zov (bez outlierov) :
    real_lower_whisker = min(asset_weights(asset_weights >= lower_bound));
    real_upper_whisker = max(asset_weights(asset_weights <= upper_bound));

    % Rozsah f�zov :
    whisker_ranges(i) = real_upper_whisker - real_lower_whisker;
    real_upper_whiskers(i) = real_upper_whisker;
    real_lower_whiskers(i) = real_lower_whisker;
end

[whisker_ranges, idx] = max(whisker_ranges);

end