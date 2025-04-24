function [portfolio_excess_return, weights_t1_before_rebalancing, daily_portfolio_return,portfolio_return] = calculate_portfolio_return_turnover(test_data, rf_rate, weights, price_t0, price_t1)
    
    % Mesaèný  NADvýnos :
    excess_returns = test_data - rf_rate;
    cumul_return_excess = prod(excess_returns+1)-1; %1x30
    portfolio_excess_return = weights' * cumul_return_excess';  
     
    % Denné NADvýnosy (vektor m x 1) :
    daily_portfolio_return = excess_returns * weights;
    
    % Mesaèný výnos :
    cumul_return = prod(test_data+1)-1; %1x30
    portfolio_return = weights' * cumul_return'; 
    
    % Turnover - váhy pred rebalansovaním :
    gross_return = price_t1./price_t0; %1x30
    Portfolio_value_t1 = gross_return*weights; % hodnota portfólia v èase t+1 (1x1)
    weights_t1_before_rebalancing = ((gross_return.*weights')./Portfolio_value_t1)'; %30x1
end
