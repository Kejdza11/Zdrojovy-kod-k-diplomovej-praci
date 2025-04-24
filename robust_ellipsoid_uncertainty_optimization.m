function [ellipsoid_weights, Vol_ellipsoid] = robust_ellipsoid_uncertainty_optimization(data_window, risk_aversion, sqrt_gamma)
   
    [m, n] = size(data_window); 
    
    % Oèakávaný výnos a kovarianènej matica :
    mu = mean(data_window)'; 
    Sigma = cov(data_window); 

    % LL' = Sigma :
    L = chol(Sigma, 'lower'); 
    
    % Elliposid optimalizácia :
    cvx_begin 
        variables w(n) delta1 
        maximize(delta1 - (1/2) * risk_aversion * quad_form(w, Sigma))
        subject to
            sum(w) == 1;
            w >= 0;
         
            -mu' * w + sqrt_gamma * norm(L' * w, 2)  <= -delta1;   
    cvx_end
    
    ellipsoid_weights = w;
    
    % Objem elipsoidu :
    Vol_ellipsoid = (2/n)*((pi^(n/2))/gamma(n/2)) * prod(sqrt(eig(Sigma)))*sqrt_gamma^n;
    
end
