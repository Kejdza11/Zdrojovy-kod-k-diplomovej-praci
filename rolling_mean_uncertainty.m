function rolling_mean_vectors = rolling_mean_uncertainty(data_window, test_size)
    
    % Poèet vektorov oèakávaných výnosov :
    num_matrices = floor(size(data_window, 1) / test_size); %24

    % Inicializácia matice pre uloženie vektorov oèakávaných výnosov :
    rolling_mean_vectors = cell(1, num_matrices);

    % Iterácia cez returns s krokom ve¾kosti okna :
    for i = 1:num_matrices
        % Indexy pre aktuálne okno dát :
        start_idx = (i-1)*test_size + 1;
        end_idx = i*test_size;
        
        % Výber podmnožiny dát(21 dní, 30 akcií) :
        data_subset = data_window(start_idx:end_idx, :);
        
        % Výpoèet vektora výnosu pre toto okno :
        mean_vector = mean(data_subset); %30x1
        rolling_mean_vectors{i} = mean_vector;
    end
end
