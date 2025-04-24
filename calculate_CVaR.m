function CVaR = calculate_CVaR(returns_last_year, weights, alpha)

    % V�po�et denn�ch v�nosov portf�lia za posledn� rok :
    portfolio_returns = zeros(252,1); 

    window_size = 21; % Po�et dn� v jednom rebalan�nom obdob�
    num_rebal_periods = 12; % Po�et rebalan�n�ch obdob�

    for i = 1:num_rebal_periods
        start_idx = (i-1) * window_size + 1;
        end_idx = min(start_idx + window_size - 1, 252); 

        % Pou�itie v�h z rebalan�n�ho obdobia i :
        portfolio_returns(start_idx:end_idx) = returns_last_year(start_idx:end_idx, :) * weights(i, :)';
    end

    % Hranica Value at Risk (VaR) na hladine alpha :
    VaR = prctile(portfolio_returns, 100 * alpha); 
    
    % Straty, ktor� prekro�ili VaR :
    extreme_losses = portfolio_returns(portfolio_returns <= VaR);
    
    % CVaR :
    CVaR = mean(extreme_losses);
end
