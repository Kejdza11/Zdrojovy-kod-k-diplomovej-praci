function [box_weights, Vol_box, beta] = robust_box_uncertainty_optimization(data_window, risk_aversion, Vol_ellipsoid)
   
    [m, n] = size(data_window);  

    % Oèakávané výnosy a kovarianèná matica :
    mu_0 = mean(data_window)'; 
    Sigma = cov(data_window);
    
    % LL' = Sigma :
    L = chol(Sigma, 'lower');
    % Maximalna singulárna hodnota :
    sigma_max_L = norm(L, 2);
    % Parameter beta :
    beta = (Vol_ellipsoid/(prod(abs(mu_0))*2^n))^(1/n); % Vol_ellipsoid = Vol_box
    
    % Box-volume optimalizácia :
    cvx_begin quiet
        variables w(n) delta
        maximize(delta - (1/2) * risk_aversion * quad_form(w, Sigma))
        subject to
            sum(w) == 1;  
            w >= 0;        
            
            beta*abs(mu_0)'*w - mu_0'*w + delta <= 0;
    cvx_end
    
    box_weights = w;
    
    % Objem boxu :
    Vol_box = 2^n * beta^n * prod(abs(mu_0));

end
