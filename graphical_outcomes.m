% GRAFICK� V�STUPY :

if true  % <--- schovanie kodu Heatmapa
% Heatmapa v�h :

% MV
figure;
imagesc(mean_variance_weights'); 
colorbar;  
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia MV'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false));  
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);

% Diagonal :
figure;
imagesc(diagonal_weights'); 
colorbar; 
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia Diagonal'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false)); 
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);

% Rolling
figure;
imagesc(rolling_mean_weights'); 
colorbar;  
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia Rolling'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false));  
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);

% Ellipsoid
figure;
imagesc(ellipsoid_weights'); 
colorbar;  
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia Ellipsoid'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false));  
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);

% Box-Volume
figure;
imagesc(box_weights'); 
colorbar;  
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia Box_Volume'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false));  
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);

% Box-Const
figure;
imagesc(box_const_weights'); 
colorbar;  
ylabel('Akcie');
xlabel('��slo rebalan�n�ho obdobia');
title('Heatmapa v�h portf�lia Box_Const'); 
set(gca, 'XTick', 1:12, 'XTickLabel', arrayfun(@(x) sprintf('%d',x), 1:12, 'UniformOutput', false));  
grid on;
% Nastavenie ve�kosti p�sma :
set(gca, 'FontSize', 14);
%%%%%%%%%%%%%%%%%%%%%
end

if true  % <--- schovanie kodu Boxplot_Weights
% Boxploty v�h portf�li� :
% [whisker_ranges_mv, idx_mv, nonzero_weights_mv] = Boxplot_Weights(mean_variance_weights, 'MV')
% [whisker_ranges_diagonal_cov, idx_diagonal_cov, nonzero_weights_diagonal] = Boxplot_Weights(diagonal_weights,'Diagonal')
% [whisker_ranges_rolling_mean, idx_rolling_mean, nonzero_weights_rolling] = Boxplot_Weights(rolling_mean_weights, 'Rolling')
% [whisker_ranges_ellipsoid_mean,idx_ellipsoid_mean, nonzero_weights_ellipsoid] = Boxplot_Weights(ellipsoid_weights, 'Ellipsoid')
% [whisker_ranges_box_mean,idx_box_mean, nonzero_weights_box_volume] = Boxplot_Weights(box_weights, 'Box-Volume')
% [whisker_ranges_box_const_mean,idx_box_const_mean, nonzero_weights_box_const] = Boxplot_Weights(box_const_weights, 'Box-Const')
% % [whisker_ranges_uniform,idx_uniform, nonzero_weights_uniform] = Boxplot_Weights(uniform_weights, 'Uniform');
%%%%%%%%%%
end

if true  % <--- schovanie kodu Graf v�voja kumulat�vneho kapit�lu - Norm�lne d�ta
% Graf v�voja kumulat�vneho kapit�lu portf�li� spolu s MDD - Norm�lne d�ta s Diagonal portf�liom :
figure;
    % Kumulat�vny kapit�l :
    plot(0:num_iterations, mv_wealth_history, ':o', 'LineWidth', 1.5,'MarkerSize', 5, 'MarkerFaceColor', 'k');
    hold on
%     plot(0:num_iterations, diagonal_cov_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
    plot(0:num_iterations, rolling_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
    plot(0:num_iterations, ellipsoid_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
    plot(0:num_iterations, box_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
    plot(0:num_iterations, box_const_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
    %     plot(0:num_iterations, uniform_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     ylim([0.95 1.7]); % Norm�lne d�ta s Diagonal
    ylim([0.95 1.6]); % Norm�lne d�ta bez Diagonal
    % MDD :
    plot(index_MDD_MV, peak_trough_MDD_MV, '-', 'Color', 'r', 'LineWidth', 2);
    plot(index_MDD_MV(2), peak_trough_MDD_MV(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     plot(index_MDD_Diagonal_Cov, peak_trough_MDD_Diagonal_Cov, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_Diagonal_Cov(2), peak_trough_MDD_Diagonal_Cov(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    plot(index_MDD_Rolling_Mean, peak_trough_MDD_Rolling_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
    plot(index_MDD_Rolling_Mean(2), peak_trough_MDD_Rolling_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    plot(index_MDD_Ellipsoid_Mean, peak_trough_MDD_Ellipsoid_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
    plot(index_MDD_Ellipsoid_Mean(2), peak_trough_MDD_Ellipsoid_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    plot(index_MDD_Box_Mean, peak_trough_MDD_Box_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
    plot(index_MDD_Box_Mean(2), peak_trough_MDD_Box_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    plot(index_MDD_Box_const_Mean, peak_trough_MDD_Box_const_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
    plot(index_MDD_Box_const_Mean(2), peak_trough_MDD_Box_const_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    %     plot(index_MDD_Uniform, peak_trough_MDD_Uniform, '-', 'Color', 'r', 'LineWidth', 2); 
    %     plot(index_MDD_Uniform(2), peak_trough_MDD_Uniform(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
    grid on;
    xlabel('��slo rebalan�n�ho obdobia');
    ylabel('Kumulat�vna hodnota portf�lia');
    title('V�voj kumulat�vneho kapit�lu')
    % S Diagonal :
%     legend('MV','Diagonal','Rolling','Ellipsoid','Box-Volume','Box-Const','Location','northwest')%,'Uniform'
    % Bez Diagonal :
    legend('MV','Rolling','Ellipsoid','Box-Volume','Box-Const','Location','northwest')%,'Uniform'
    set(gca, 'FontSize', 14)
%%%%%%%%
end

if true  % <--- schovanie kodu Graf v�voja kumulat�vneho kapit�lu - Kr�zov� d�ta
% % Graf v�voja kumulat�vneho v�voju kapit�lu portf�li� spolu s MDD - Kr�zov� d�ta :
% figure;
%     % Kumulat�vny kapit�l :
%     plot(0:num_iterations, mv_wealth_history, ':o', 'LineWidth', 1.5,'MarkerSize', 5, 'MarkerFaceColor', 'k');
%     hold on
% %     plot(0:num_iterations, diagonal_cov_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     plot(0:num_iterations, rolling_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     plot(0:num_iterations, ellipsoid_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     plot(0:num_iterations, box_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     plot(0:num_iterations, box_const_mean_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     %     plot(0:num_iterations, uniform_wealth_history, '-*', 'LineWidth', 1.5,'MarkerSize', 5);
%     ylim([0.3 1.1]); % Kr�zov� d�ta
%     % MDD :
%     plot(index_MDD_MV, peak_trough_MDD_MV, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_MV(2), peak_trough_MDD_MV(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
% %     plot(index_MDD_Diagonal_Cov, peak_trough_MDD_Diagonal_Cov, '-', 'Color', 'r', 'LineWidth', 2); 
% %     plot(index_MDD_Diagonal_Cov(2), peak_trough_MDD_Diagonal_Cov(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     plot(index_MDD_Rolling_Mean, peak_trough_MDD_Rolling_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_Rolling_Mean(2), peak_trough_MDD_Rolling_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     plot(index_MDD_Ellipsoid_Mean, peak_trough_MDD_Ellipsoid_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_Ellipsoid_Mean(2), peak_trough_MDD_Ellipsoid_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     plot(index_MDD_Box_Mean, peak_trough_MDD_Box_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_Box_Mean(2), peak_trough_MDD_Box_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     plot(index_MDD_Box_const_Mean, peak_trough_MDD_Box_const_Mean, '-', 'Color', 'r', 'LineWidth', 2); 
%     plot(index_MDD_Box_const_Mean(2), peak_trough_MDD_Box_const_Mean(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     %     plot(index_MDD_Uniform, peak_trough_MDD_Uniform, '-', 'Color', 'r', 'LineWidth', 2); 
%     %     plot(index_MDD_Uniform(2), peak_trough_MDD_Uniform(2), '<', 'MarkerSize', 8, 'MarkerEdgeColor', 'w', 'MarkerFaceColor', 'r');
%     grid on;
%     xlabel('��slo rebalan�n�ho obdobia');
%     ylabel('Kumulat�vna hodnota portf�lia');
%     title('V�voj kumulat�vneho kapit�lu')
%     legend('MV','Rolling','Ellipsoid','Box-Volume','Box-Const','Location','southwest') %,'Uniform','Diagonal'
%     set(gca, 'FontSize', 14)
%%%%%%%%
end

