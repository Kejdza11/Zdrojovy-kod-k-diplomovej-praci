function [wealth_history] = Comparison_portfolio_performance(returns, weights, wealth, num_iterations, test_size, window_size)

    % Inicializ�cia :
    wealth_history = zeros(num_iterations + 1, 1);
    wealth_history(1) = wealth; % Po�iato�n� hodnota kapit�lu
   
    for i = 1:num_iterations
        % Indexy pre klzav� okno a testovanie :
        start_idx = (i-1)*test_size + 1;
        end_idx = start_idx + window_size - 1;

        % V�ber v�h pre toto rebalan�n� obdobie :
        weights_i = weights(i, :);
        % Inicializ�cia :
        cumulative_returns_product = ones(1, size(returns, 2)); 

        % S��in denn�ch v�nosov portf�lia po�as nasleduj�cich 21 dn� :
        for j = 1:test_size
            % V�nosy d�a j :
            current_day_returns = returns(end_idx + j, :);
            % S��in denn�ch v�nosov (bez v�h) :
            cumulative_returns_product = cumulative_returns_product .* (1 + current_day_returns);
        end

        % Pou�itie v�h :
        cumulative_return = sum(weights_i .* cumulative_returns_product);
        % Aktualiz�cia kapit�lu po 21 d�och :
        wealth = wealth * cumulative_return; % nov� kumulovan� kapit�l po obdob� :
        wealth_history(i+1) = wealth;
    end

end
