function rolling_mean_vectors = rolling_mean_uncertainty(data_window, test_size)
    
    % Po�et vektorov o�ak�van�ch v�nosov :
    num_matrices = floor(size(data_window, 1) / test_size); %24

    % Inicializ�cia matice pre ulo�enie vektorov o�ak�van�ch v�nosov :
    rolling_mean_vectors = cell(1, num_matrices);

    % Iter�cia cez returns s krokom ve�kosti okna :
    for i = 1:num_matrices
        % Indexy pre aktu�lne okno d�t :
        start_idx = (i-1)*test_size + 1;
        end_idx = i*test_size;
        
        % V�ber podmno�iny d�t(21 dn�, 30 akci�) :
        data_subset = data_window(start_idx:end_idx, :);
        
        % V�po�et vektora v�nosu pre toto okno :
        mean_vector = mean(data_subset); %30x1
        rolling_mean_vectors{i} = mean_vector;
    end
end
