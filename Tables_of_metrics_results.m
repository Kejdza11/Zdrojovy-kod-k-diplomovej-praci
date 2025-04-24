% TABU¼KY NUMERICKÝCH VÝSLEDKOV :

if true  % <--- schovanie kodu Tabu¾ka všetkých metrík - Normálne dáta S Diagonal
% Tabu¾ka všetkých metrík - Normálne dáta :
% mv_data_ALL = [mv_mean_excess_return, mv_sqrt_variance_return, mv_sharpe_ratio, round(mv_sortino_ratio,2), mv_turnover, round(MDD_MV * 100, 2), round(UI_mv * 100, 2), round(CVaR_MV*100,2)];
% diagonal_data_ALL = [diagonal_mean_excess_return, diagonal_sqrt_variance_return, diagonal_sharpe_ratio, round(diagonal_sortino_ratio,2), diagonal_turnover, round([MDD_Diagonal_Cov, UI_Diagonal_Cov] * 100, 2), round(CVaR_Diagonal_Cov*100,2)];
% rolling_mean_data_ALL = [rolling_mean_mean_excess_return, rolling_mean_sqrt_variance_return, rolling_mean_sharpe_ratio, round(rolling_mean_sortino_ratio,2), rolling_mean_turnover, round(MDD_Rolling_Mean * 100, 2), round(UI_Rolling_Mean * 100, 2), round(CVaR_Rolling_Mean*100,2)];
% ellipsoid_data_ALL = [ellipsoid_mean_excess_return, ellipsoid_sqrt_variance_return, ellipsoid_sharpe_ratio, round(ellipsoid_sortino_ratio,2), ellipsoid_turnover, round(MDD_Ellipsoid_Mean * 100, 2), round(UI_Ellipsoid_Mean * 100, 2), round(CVaR_Ellipsoid_Mean*100,2)];
% box_data_ALL = [box_mean_excess_return, box_sqrt_variance_return, box_sharpe_ratio, round(box_sortino_ratio,2), box_turnover, round(MDD_Box_Mean * 100, 2), round(UI_Box_Mean * 100, 2), round(CVaR_Box_Mean*100,2)];
% box_const_data_ALL = [box_const_mean_excess_return, box_const_sqrt_variance_return, box_const_sharpe_ratio, round(box_const_sortino_ratio,2), box_const_turnover, round(MDD_Box_const_Mean * 100, 2), round(UI_Box_const_Mean * 100, 2), round(CVaR_Box_const_Mean*100,2)];
% % uniform_data_ALL = [uniform_mean_excess_return, uniform_sqrt_variance_return, uniform_sharpe_ratio, round(uniform_sortino_ratio,2), uniform_turnover, round(MDD_Uniform * 100, 2), round(UI_Uniform * 100, 2), round(CVaR_uniform*100,2)];

% % S diagonal :
% results_matrix_ALL = [mv_data_ALL; diagonal_data_ALL; rolling_mean_data_ALL; ellipsoid_data_ALL; box_data_ALL; box_const_data_ALL]; %;uniform_data_ALL
% column_names_ALL = {'MV', 'Diagonal', 'Rolling', 'Ellipsoid','Box_Volume','Box_Const'}; %,'Uniform'

% row_names_ALL = {'Nadvýnos (%)', 'Volatilita (%)', 'Sharpeov pomer', 'Sortinov pomer', 'Turnover (%)', 'MDD (%)', 'UI (%)', 'CVaR (%)'};
% results_table_ALL = array2table(results_matrix_ALL', 'RowNames', row_names_ALL, 'VariableNames', column_names_ALL);
% disp(results_table_ALL)
% %%%%%%%
end

if true  % <--- schovanie kodu Tabu¾ka všetkých metrík - Normálne dáta BEZ Diagonal
% Tabu¾ka všetkých metrík - Normálne dáta :
mv_data_ALL = [mv_mean_excess_return, mv_sqrt_variance_return, mv_sharpe_ratio, round(mv_sortino_ratio,2), mv_turnover, round(MDD_MV * 100, 2), round(UI_mv * 100, 2), round(CVaR_MV*100,2)];
rolling_mean_data_ALL = [rolling_mean_mean_excess_return, rolling_mean_sqrt_variance_return, rolling_mean_sharpe_ratio, round(rolling_mean_sortino_ratio,2), rolling_mean_turnover, round(MDD_Rolling_Mean * 100, 2), round(UI_Rolling_Mean * 100, 2), round(CVaR_Rolling_Mean*100,2)];
ellipsoid_data_ALL = [ellipsoid_mean_excess_return, ellipsoid_sqrt_variance_return, ellipsoid_sharpe_ratio, round(ellipsoid_sortino_ratio,2), ellipsoid_turnover, round(MDD_Ellipsoid_Mean * 100, 2), round(UI_Ellipsoid_Mean * 100, 2), round(CVaR_Ellipsoid_Mean*100,2)];
box_data_ALL = [box_mean_excess_return, box_sqrt_variance_return, box_sharpe_ratio, round(box_sortino_ratio,2), box_turnover, round(MDD_Box_Mean * 100, 2), round(UI_Box_Mean * 100, 2), round(CVaR_Box_Mean*100,2)];
box_const_data_ALL = [box_const_mean_excess_return, box_const_sqrt_variance_return, box_const_sharpe_ratio, round(box_const_sortino_ratio,2), box_const_turnover, round(MDD_Box_const_Mean * 100, 2), round(UI_Box_const_Mean * 100, 2), round(CVaR_Box_const_Mean*100,2)];
% uniform_data_ALL = [uniform_mean_excess_return, uniform_sqrt_variance_return, uniform_sharpe_ratio, round(uniform_sortino_ratio,2), uniform_turnover, round(MDD_Uniform * 100, 2), round(UI_Uniform * 100, 2), round(CVaR_uniform*100,2)];

% Bez diagonal pre citlivos :
results_matrix_ALL = [mv_data_ALL; rolling_mean_data_ALL; ellipsoid_data_ALL; box_data_ALL; box_const_data_ALL]; %;uniform_data_ALL
column_names_ALL = {'MV', 'Rolling', 'Ellipsoid','Box_Volume','Box_Const'}; %,'Uniform'

row_names_ALL = {'Nadvýnos (%)', 'Volatilita (%)', 'Sharpeov pomer', 'Sortinov pomer', 'Turnover (%)', 'MDD (%)', 'UI (%)', 'CVaR (%)'};
results_table_ALL = array2table(results_matrix_ALL', 'RowNames', row_names_ALL, 'VariableNames', column_names_ALL);
disp(results_table_ALL)
% %%%%%%%
end

if true  % <--- schovanie kodu Tabu¾ka všetkých metrík - Krízové dáta BEZ Diagonal
% % Tabu¾ka všetkých metrík - Krízové dáta - Bez Sortina a bez Diagonal :
% mv_data_ALL = [mv_mean_excess_return, mv_sqrt_variance_return, mv_sharpe_ratio, mv_turnover, round(MDD_MV * 100, 2), round(UI_mv * 100, 2), round(CVaR_MV*100,2)];
% % diagonal_data_ALL = [diagonal_mean_excess_return, diagonal_sqrt_variance_return, diagonal_sharpe_ratio, diagonal_turnover, round([MDD_Diagonal_Cov, UI_Diagonal_Cov] * 100, 2), round(CVaR_Diagonal_Cov*100,2)];
% rolling_mean_data_ALL = [rolling_mean_mean_excess_return, rolling_mean_sqrt_variance_return, rolling_mean_sharpe_ratio, rolling_mean_turnover, round(MDD_Rolling_Mean * 100, 2), round(UI_Rolling_Mean * 100, 2), round(CVaR_Rolling_Mean*100,2)];
% ellipsoid_data_ALL = [ellipsoid_mean_excess_return, ellipsoid_sqrt_variance_return, ellipsoid_sharpe_ratio, ellipsoid_turnover, round(MDD_Ellipsoid_Mean * 100, 2), round(UI_Ellipsoid_Mean * 100, 2), round(CVaR_Ellipsoid_Mean*100,2)];
% box_data_ALL = [box_mean_excess_return, box_sqrt_variance_return, box_sharpe_ratio, box_turnover, round(MDD_Box_Mean * 100, 2), round(UI_Box_Mean * 100, 2), round(CVaR_Box_Mean*100,2)];
% box_const_data_ALL = [box_const_mean_excess_return, box_const_sqrt_variance_return, box_const_sharpe_ratio, box_const_turnover, round(MDD_Box_const_Mean * 100, 2), round(UI_Box_const_Mean * 100, 2), round(CVaR_Box_const_Mean*100,2)];
% % uniform_data_ALL = [uniform_mean_excess_return, uniform_sqrt_variance_return, uniform_sharpe_ratio, uniform_turnover, round(MDD_Uniform * 100, 2), round(UI_Uniform * 100, 2), round(CVaR_uniform*100,2)];
% 
% results_matrix_ALL = [mv_data_ALL; rolling_mean_data_ALL; ellipsoid_data_ALL; box_data_ALL; box_const_data_ALL]; %;uniform_data_ALL; diagonal_data_ALL
% column_names_ALL = {'MV', 'Rolling', 'Ellipsoid','Box_Volume','Box_Const'}; %,'Uniform', 'Diagonal
% row_names_ALL = {'Nadvýnos (%)', 'Volatilita (%)', 'Sharpeov pomer', 'Turnover (%)', 'MDD (%)', 'UI (%)', 'CVaR (%)'};
% results_table_ALL = array2table(results_matrix_ALL', 'RowNames', row_names_ALL, 'VariableNames', column_names_ALL);
% disp(results_table_ALL)
% %%%%%%%
end

