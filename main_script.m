% HLAVN› SKRIPT

% NaËÌtanie vstupn˝ch parametrov :
input_params;  % (Treba odkomentovaù buÔ norm·lne alebo krÌzovÈ d·ta)

% Spustenie CYKLU REBALANSOVANIA :
for i = 1:num_iterations
    % Definovanie indexov pre kÂzavÈ okno :
    start_idx = (i-1)*test_size + 1;
    end_idx = start_idx + window_size - 1;
    
    % V˝ber d·t pre optimaliz·ciu :
    data_window = returns(start_idx:end_idx, :);
    
    % Mnoûina neistoty oËak·van˝ch v˝nosov z Ëasov˝ch ˙sekov :
    rolling_mean_vectors = rolling_mean_uncertainty(data_window, test_size);
    
    % Optimaliz·cia na v˝poËet v·h :
    cvx_quiet(true); % StÌöenie zobrazovania v˝stupov CVX
    mv_weights = mean_variance_optimization(data_window, risk_aversion);
    [diag_weights,d, mu_diag, diagonal_Corr] = robust_diagonal_uncertainty_optimization(data_window, risk_aversion);
    roll_mean_weights = robust_rolling_mean_optimization(data_window, risk_aversion, rolling_mean_vectors);
    [ellip_weights, Vol_ellipsoid] = robust_ellipsoid_uncertainty_optimization(data_window, risk_aversion, sqrt_gamma);
    [b_weights, Vol_box, beta] = robust_box_uncertainty_optimization(data_window, risk_aversion, Vol_ellipsoid);
    [b_const_weights, Vol_box_const, beta_const] = robust_box_const_uncertainty_optimization(data_window, risk_aversion, beta_constant);
    %     unif_weights = ones(30,1)*(1/30);
    
    % V˝ber nov˝ch 21 d·t pre testovanie v·h :
    test_start_idx = end_idx + 1;
    test_end_idx = test_start_idx + test_size - 1;
    test_data = returns(test_start_idx:test_end_idx, :);
    
    % V˝poËet nadv˝nosu portfÛlia a v·h pre turnover na testovacÌch d·tach :
    [mv_portfolio_excess_return, mv_weights_before_reb, mv_daily_portfolio_return,mv_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, mv_weights, matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    [diag_portfolio_excess_return, diag_weights_before_reb, diag_daily_portfolio_return,diag_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, diag_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    [roll_mean_portfolio_excess_return, roll_mean_weights_before_reb, roll_mean_daily_portfolio_return,roll_mean_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, roll_mean_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    [ellipsoid_portfolio_excess_return, ellip_weights_before_reb, ellip_daily_portfolio_return,ellipsoid_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, ellip_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    [box_portfolio_excess_return, b_weights_before_reb, box_daily_portfolio_return,box_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, b_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    [box_const_portfolio_excess_return, b_const_weights_before_reb, box_const_daily_portfolio_return,box_const_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, b_const_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));
    %     [uniform_portfolio_excess_return, unif_weights_before_reb, uniform_daily_portfolio_return,uniform_portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, unif_weights,matica_adjusted_prices(end_idx,:), matica_adjusted_prices(test_end_idx,:));

    % Uloûenie v·h a v˝nosov :
    mean_variance_weights = [mean_variance_weights; mv_weights']; % v·hy sa mi tu ukladaj˙ ako riadky
    mean_variance_weights_before_reb = [mean_variance_weights_before_reb; mv_weights_before_reb'];
    mean_variance_excess_returns = [mean_variance_excess_returns; mv_portfolio_excess_return'];
    mean_variance_daily_portfolio_returns = [mean_variance_daily_portfolio_returns; mv_daily_portfolio_return];
    mean_variance_returns = [mean_variance_returns; mv_portfolio_return'];

    diagonal_weights = [diagonal_weights; diag_weights'];  
    diagonal_weights_before_reb = [diagonal_weights_before_reb; diag_weights_before_reb'];  
    diagonal_excess_returns = [diagonal_excess_returns; diag_portfolio_excess_return'];
    diagonal_daily_portfolio_returns = [diagonal_daily_portfolio_returns; diag_daily_portfolio_return];
    diagonal_returns = [diagonal_returns; diag_portfolio_return'];
    % Na overenie, Ëi diagonal portfÛlio investovalo vûdy do akcie s najlepöÌm Sharpe pomerom :
    matice_kovariancie = [matice_kovariancie; d];
    matice_vynosu = [matice_vynosu; mu_diag];
    diagonal_Corrs = [diagonal_Corrs; diagonal_Corr];
        
    rolling_mean_weights = [rolling_mean_weights; roll_mean_weights'];  
    rolling_mean_weights_before_reb = [rolling_mean_weights_before_reb; roll_mean_weights_before_reb'];
    rolling_mean_excess_returns = [rolling_mean_excess_returns; roll_mean_portfolio_excess_return'];
    rolling_mean_returns = [rolling_mean_returns; roll_mean_portfolio_return'];
    rolling_mean_daily_portfolio_returns = [rolling_mean_daily_portfolio_returns; roll_mean_daily_portfolio_return];
      
    ellipsoid_weights = [ellipsoid_weights; ellip_weights'];  
    ellipsoid_weights_before_reb = [ellipsoid_weights_before_reb; ellip_weights_before_reb'];
    ellipsoid_excess_returns = [ellipsoid_excess_returns; ellipsoid_portfolio_excess_return']; 
    ellipsoid_returns = [ellipsoid_returns; ellipsoid_portfolio_return']; 
    ellipsoid_daily_portfolio_returns = [ellipsoid_daily_portfolio_returns; ellip_daily_portfolio_return]; 
    Volume_ellipsoid = [Volume_ellipsoid; Vol_ellipsoid];
 
    box_weights = [box_weights; b_weights']; 
    box_weights_before_reb = [box_weights_before_reb; b_weights_before_reb'];  
    box_excess_returns = [box_excess_returns; box_portfolio_excess_return']; 
    box_returns = [box_returns; box_portfolio_return']; 
    box_daily_portfolio_returns = [box_daily_portfolio_returns; box_daily_portfolio_return]; 
    Volume_box = [Volume_box; Vol_box];
    betas = [betas; beta];
    
    box_const_weights = [box_const_weights; b_const_weights'];
    box_const_weights_before_reb = [box_const_weights_before_reb; b_const_weights_before_reb'];
    box_const_excess_returns = [box_const_excess_returns; box_const_portfolio_excess_return']; 
    box_const_returns = [box_const_returns; box_const_portfolio_return']; 
    box_const_daily_portfolio_returns = [box_const_daily_portfolio_returns; box_const_daily_portfolio_return]; 
    Volume_box_const = [Volume_box_const; Vol_box_const];
    betas_const = [betas_const; beta_const];

%     uniform_weights = [uniform_weights; unif_weights'];  
%     uniform_weights_before_reb = [uniform_weights_before_reb; unif_weights_before_reb'];  
%     uniform_excess_returns = [uniform_excess_returns; uniform_portfolio_excess_return'];
%     uniform_returns = [uniform_returns; uniform_portfolio_return'];
%     uniform_daily_portfolio_returns = [uniform_daily_portfolio_returns; uniform_daily_portfolio_return]; 
  
end

% TABUºKY A GRAFY :

if true  % <--- schovanie kodu Kontrola Diagonal
% V˝ber akcie pri Diagonal portfÛliu podæa max. ˙Ëelovej funkcie :
% matica = reshape(matice_vynosu - (risk_aversion/2)*matice_kovariancie.^2, 30, 12);
% matica_SR = reshape(matice_vynosu./matice_kovariancie, 30, 12);
%[max_matica, idx_akcie_max] = max(matica);
% [max_matica_SR', idx_akcie_max_SR'] = sort(matica_SR);
end

if true  % <--- schovanie kodu calculate_metrics
% Funkcia calculate_metrics:
[mv_mean_excess_return, mv_sqrt_variance_return, mv_sharpe_ratio, mv_turnover, mv_sortino_ratio,mv_mean_return] = calculate_metrics(mean_variance_excess_returns,num_iterations,mean_variance_weights, mean_variance_weights_before_reb, mean_variance_daily_portfolio_returns,mean_variance_returns);
[diagonal_mean_excess_return, diagonal_sqrt_variance_return, diagonal_sharpe_ratio,diagonal_turnover, diagonal_sortino_ratio,diagonal_mean_return] = calculate_metrics(diagonal_excess_returns,num_iterations,diagonal_weights, diagonal_weights_before_reb, diagonal_daily_portfolio_returns,diagonal_returns);
[rolling_mean_mean_excess_return, rolling_mean_sqrt_variance_return, rolling_mean_sharpe_ratio,rolling_mean_turnover, rolling_mean_sortino_ratio,rolling_mean_mean_return] = calculate_metrics(rolling_mean_excess_returns,num_iterations,rolling_mean_weights, rolling_mean_weights_before_reb, rolling_mean_daily_portfolio_returns,rolling_mean_returns);
[ellipsoid_mean_excess_return, ellipsoid_sqrt_variance_return, ellipsoid_sharpe_ratio, ellipsoid_turnover, ellipsoid_sortino_ratio,ellipsoid_mean_return] = calculate_metrics(ellipsoid_excess_returns,num_iterations,ellipsoid_weights, ellipsoid_weights_before_reb, ellipsoid_daily_portfolio_returns,ellipsoid_returns);
[box_mean_excess_return, box_sqrt_variance_return, box_sharpe_ratio, box_turnover, box_sortino_ratio,box_mean_return] = calculate_metrics(box_excess_returns,num_iterations,box_weights, box_weights_before_reb, box_daily_portfolio_returns,box_returns);
[box_const_mean_excess_return, box_const_sqrt_variance_return, box_const_sharpe_ratio, box_const_turnover, box_const_sortino_ratio,box_const_mean_return] = calculate_metrics(box_const_excess_returns,num_iterations,box_const_weights, box_const_weights_before_reb, box_const_daily_portfolio_returns,box_const_returns);
% [uniform_mean_excess_return, uniform_sqrt_variance_return, uniform_sharpe_ratio,uniform_turnover, uniform_sortino_ratio,uniform_mean_return] = calculate_metrics(uniform_excess_returns,num_iterations,uniform_weights, uniform_weights_before_reb, uniform_daily_portfolio_returns,uniform_returns);

% NumerickÈ v˝sledky :
mv_data = [mv_mean_excess_return, mv_sqrt_variance_return, mv_sharpe_ratio, mv_turnover, mv_sortino_ratio, 1];
diagonal_data = [diagonal_mean_excess_return, diagonal_sqrt_variance_return, diagonal_sharpe_ratio,diagonal_turnover, diagonal_sortino_ratio, diagonal_turnover/mv_turnover];
rolling_mean_data = [rolling_mean_mean_excess_return, rolling_mean_sqrt_variance_return, rolling_mean_sharpe_ratio,rolling_mean_turnover, rolling_mean_sortino_ratio, rolling_mean_turnover/mv_turnover];
ellipsoid_data = [ellipsoid_mean_excess_return, ellipsoid_sqrt_variance_return, ellipsoid_sharpe_ratio, ellipsoid_turnover, ellipsoid_sortino_ratio, ellipsoid_turnover/mv_turnover];
box_data = [box_mean_excess_return, box_sqrt_variance_return, box_sharpe_ratio, box_turnover, box_sortino_ratio, box_turnover/mv_turnover];
box_const_data = [box_const_mean_excess_return, box_const_sqrt_variance_return, box_const_sharpe_ratio, box_const_turnover, box_const_sortino_ratio, box_const_turnover/mv_turnover];
% uniform_data = [uniform_mean_excess_return, uniform_sqrt_variance_return, uniform_sharpe_ratio, uniform_turnover, uniform_sortino_ratio, uniform_turnover/mv_turnover];
%%%%%%%%%%%%%%%%%%%%%%%%%%
end

if true  % <--- schovanie kodu Comparison_portfolio_performance
% Absol˙tny v˝voj kapit·lu - v˝poËet kumulatÌvneho kapit·lu:
mv_wealth_history = Comparison_portfolio_performance(returns, mean_variance_weights, wealth, num_iterations, test_size, window_size);
diagonal_cov_wealth_history = Comparison_portfolio_performance(returns, diagonal_weights, wealth, num_iterations, test_size, window_size);
rolling_mean_wealth_history = Comparison_portfolio_performance(returns, rolling_mean_weights, wealth, num_iterations, test_size, window_size);
ellipsoid_mean_wealth_history = Comparison_portfolio_performance(returns, ellipsoid_weights, wealth, num_iterations, test_size, window_size);
box_mean_wealth_history = Comparison_portfolio_performance(returns, box_weights, wealth, num_iterations, test_size, window_size);
box_const_mean_wealth_history = Comparison_portfolio_performance(returns, box_const_weights, wealth, num_iterations, test_size, window_size);
% uniform_wealth_history,mv_wealth_history] = Comparison_portfolio_performance(returns, uniform_weights, wealth, num_iterations, test_size, window_size);
%%%%%%%%%%%%%%%%%%%
end

if true  % <--- schovanie kodu calculate_maximum_drawdown
% Maximum drawdown (MDD) A Ulcer index (UI):

[MDD_MV, index_MDD_MV, peak_trough_MDD_MV, UI_mv] =calculate_max_drawdown(mv_wealth_history);
[MDD_Diagonal_Cov, index_MDD_Diagonal_Cov, peak_trough_MDD_Diagonal_Cov,UI_Diagonal_Cov] = calculate_max_drawdown(diagonal_cov_wealth_history);
[MDD_Rolling_Mean, index_MDD_Rolling_Mean, peak_trough_MDD_Rolling_Mean,UI_Rolling_Mean] = calculate_max_drawdown(rolling_mean_wealth_history);
[MDD_Ellipsoid_Mean, index_MDD_Ellipsoid_Mean,peak_trough_MDD_Ellipsoid_Mean, UI_Ellipsoid_Mean] = calculate_max_drawdown(ellipsoid_mean_wealth_history);
[MDD_Box_Mean, index_MDD_Box_Mean, peak_trough_MDD_Box_Mean, UI_Box_Mean] = calculate_max_drawdown(box_mean_wealth_history);
[MDD_Box_const_Mean, index_MDD_Box_const_Mean, peak_trough_MDD_Box_const_Mean, UI_Box_const_Mean] = calculate_max_drawdown(box_const_mean_wealth_history);
% [MDD_Uniform, index_MDD_Uniform, peak_trough_MDD_Uniform,UI_Uniform] = calculate_max_drawdown(uniform_wealth_history);
%%%%%%%%%%%%%%%%%%%
end

if true  % <--- schovanie kodu calculate CVaR
% CVaR :

alpha = 0.05; % hranica
returns_last_year = returns(505:756, :); % Vyberieme posledn˝ch 252 dnÌ
CVaR_MV = calculate_CVaR(returns_last_year, mean_variance_weights, alpha);
CVaR_Diagonal_Cov = calculate_CVaR(returns_last_year, diagonal_weights, alpha);
CVaR_Rolling_Mean = calculate_CVaR(returns_last_year, rolling_mean_weights, alpha);
CVaR_Ellipsoid_Mean = calculate_CVaR(returns_last_year, ellipsoid_weights, alpha);
CVaR_Box_Mean = calculate_CVaR(returns_last_year, box_weights, alpha);
CVaR_Box_const_Mean = calculate_CVaR(returns_last_year, box_const_weights, alpha);
% CVaR_uniform = calculate_CVaR(returns_last_year, uniform_weights, alpha);
%%%%%%%%%%%%%%%%%%%
end

% Tabuæky numerick˝ch v˝sledkov metrÌk : 
Tables_of_metrics_results; % (Treba odkomentovaù tabuæku buÔ pre norm·lne alebo krÌzovÈ d·ta)

% GrafickÈ v˝stupy :
graphical_outcomes; % (Treba odkomentovaù tabuæku buÔ pre norm·lne alebo krÌzovÈ d·ta)

