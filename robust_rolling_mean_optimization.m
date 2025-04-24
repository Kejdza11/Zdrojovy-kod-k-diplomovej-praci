function [rolling_mean_weights] = robust_rolling_mean_optimization(data_window, risk_aversion, rolling_mean_vectors)
    
    [m, n] = size(data_window); 

    % O�ak�van� v�nosy a kovarian�n� matica :
    Sigma = cov(data_window);  
    
    % Rolling-mean optimaliz�cia :
    cvx_begin quiet
        variable w(n)  
        variable delta
        maximize(delta - (1/2) * risk_aversion * quad_form(w, Sigma))
        subject to
            sum(w) == 1;   
            w >= 0;      
            
        % Ohrani�enia s neistotou:
        for i = 1:length(rolling_mean_vectors)
            % -mu'*w + delta <= 0  <=> delta <= mu'*w;
            -w'*rolling_mean_vectors{i}' + delta <= 0;
        end
    cvx_end
    
    rolling_mean_weights = w;
end
