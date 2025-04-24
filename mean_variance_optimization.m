function [mv_weights] = mean_variance_optimization(data_window, risk_aversion)
    
    [m, n] = size(data_window);

    % O�ak�van� v�nosy a kovarian�n� matica :
    mu = mean(data_window)';  
    Sigma = cov(data_window);

    % Mean-variance optimaliz�cia :
    cvx_begin quiet
        variable w(n)  
        maximize(mu' * w - (1/2) * risk_aversion * quad_form(w, Sigma)) 
        subject to
            sum(w) == 1;   
            w >= 0;     
    cvx_end
    
    mv_weights = w;
end
