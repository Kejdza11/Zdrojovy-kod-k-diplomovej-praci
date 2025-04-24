function [diag_weights,d,mu_diag, diagonal_Corr] = robust_diagonal_uncertainty_optimization(data_window, risk_aversion)
    
    [m, n] = size(data_window); 

    % Oèakávané výnosy a kovarianèná matica :
    mu = mean(data_window)'; 
    d = sqrt(diag(cov(data_window))); % vektor volatilít kovarianènej matice
    Sigma = d*d'; % kovarianèná matica

    % Diagonal optimalizácia :
    cvx_begin quiet
        variable w(n)  
        maximize(mu' * w - (1/2) * risk_aversion * quad_form(w, Sigma))
        subject to
            sum(w) == 1;   
            w >= 0;    
    cvx_end
    
    diag_weights = w;
    mu_diag = mu;
    diagonal_Corr = corr(Sigma);
end
