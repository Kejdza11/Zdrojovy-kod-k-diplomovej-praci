function [wealth_history] = Comparison_portfolio_performance(returns, weights, wealth, num_iterations, test_size, window_size)

    % Inicializácia :
    wealth_history = zeros(num_iterations + 1, 1);
    wealth_history(1) = wealth; % Poèiatoèná hodnota kapitálu
   
    for i = 1:num_iterations
        % Indexy pre klzavé okno a testovanie :
        start_idx = (i-1)*test_size + 1;
        end_idx = start_idx + window_size - 1;

        % Výber váh pre toto rebalanèné obdobie :
        weights_i = weights(i, :);
        % Inicializácia :
        cumulative_returns_product = ones(1, size(returns, 2)); 

        % Súèin denných výnosov portfólia poèas nasledujúcich 21 dní :
        for j = 1:test_size
            % Výnosy dòa j :
            current_day_returns = returns(end_idx + j, :);
            % Súèin denných výnosov (bez váh) :
            cumulative_returns_product = cumulative_returns_product .* (1 + current_day_returns);
        end

        % Použitie váh :
        cumulative_return = sum(weights_i .* cumulative_returns_product);
        % Aktualizácia kapitálu po 21 dòoch :
        wealth = wealth * cumulative_return; % nový kumulovaný kapitál po období :
        wealth_history(i+1) = wealth;
    end

end
