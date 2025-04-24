function [mean_excess_return, sqrt_variance_return, sharpe_ratio, turnover, sortino_ratio,mean_return] = calculate_metrics(excess_returns,num_iterations,weights_after_reb, weights_before_reb,daily_portfolio_returns,returns)
    
    % Celkový priemerný MESAÈNÝ NADvýnos :
    mean_excess_return = mean(excess_returns); % mean_excess_return = 1/length(excess_returns)*sum(excess_returns);
    
    % Prevod mesaèného NADvýnosu na ROÈNÝ:
    mean_excess_return = (1 + mean_excess_return)^12 - 1;
    
    % Celkový priemerný MESAÈNÝ výnos :
    mean_return = mean(returns); % mean_return = 1/length(returns)*sum(returns); 
    
    % Prevod mesaèného výnosu na ROÈNÝ :
    mean_return = (1 + mean_return)^12 - 1;
    
    % Celková MESAÈNÁ štandardná odchýlka :
    sqrt_variance_return = sqrt(var(excess_returns, 0)); % variance_return = sqrt(1/(length(excess_returns)-1)*sum( (excess_returns - mean_excess_return).^2) )
    
    % Prevod mesaènej volatility na ROÈNÚ:
    sqrt_variance_return = sqrt_variance_return*sqrt(12);
    
    % Sortinov pomer :
    % Zoberiem denné vektory :
    downside_part = min(daily_portfolio_returns, 0); % 252x1
    % Denný downside stdev :
    downside_dev = sqrt(mean(downside_part.^2)); 
    % Roèný downside stdev :
    downside_dev = downside_dev*sqrt(252);
    sortino_ratio = round(mean_excess_return /downside_dev,2);
    
    % Sharpeov pomer :
    sharpe_ratio = round(mean_excess_return / sqrt_variance_return^(mean_excess_return/abs(mean_excess_return)),2); 
    
    % Turnover :
    total_turnover = 0;
    for t = 2:num_iterations
        period_turnover = sum(abs(weights_after_reb(t,:) - weights_before_reb(t-1,:)));
        total_turnover = total_turnover + period_turnover;
    end
    turnover = round(total_turnover/(num_iterations-1),4)*100;
    
    % Zaokrúhlenie roèného NADvýnosu :
    mean_excess_return = round(mean_excess_return,4)*100;
     % Zaokrúhlenie roènej volatility :
    sqrt_variance_return = round(sqrt_variance_return,4)*100;

end
