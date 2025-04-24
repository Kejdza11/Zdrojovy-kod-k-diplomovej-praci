function [box_weights, Vol_box, beta] = robust_box_const_uncertainty_optimization(data_window, risk_aversion, beta)
    
    [m, n] = size(data_window);  

    % Oèakávané výnosy a kovarianèná matica :
    mu = mean(data_window)';  
    Sigma = cov(data_window);
    
    % Box-const optimalizácia :
    cvx_begin quiet
        variables w(n) delta  
        maximize(delta - (1/2) * risk_aversion * quad_form(w, Sigma)) 
        subject to
            sum(w) == 1;   
            w >= 0;       
            
        beta*abs(mu)'*w - mu'*w + delta <= 0;
    cvx_end
    
    box_weights = w;
    
    % Objem boxu :
    Vol_box = 2^n * beta^n * prod(abs(mu));
 
end
