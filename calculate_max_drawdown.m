function [MDD, x_vals, y_vals, UI] = calculate_max_drawdown(wealth_history)
    
    % Vektor maximálnych hodnôt kapitálu do èasu t :
    peak_values = cummax(wealth_history);
    
    % Drawdown pre kadı èasovı bod :
    drawdowns = (peak_values - wealth_history) ./ peak_values;
    
    % Maximum Drawdown :
    [MDD, trough_index] = max(drawdowns);
    
    % Kde bolo historické maximum pred MDD :
    peak_index = find(wealth_history(1:trough_index) == peak_values(trough_index), 1, 'last');
    
    % Kvôli indexom zaèínajúcim od 1 a nie od 0 sa treba posunú o 1 dozadu v indexoch peak a trough :
    trough_index = trough_index - 1;
    peak_index = peak_index - 1;
    x_vals = [peak_index, trough_index];
    
    peak_value = wealth_history(peak_index + 1);
    trough_value = wealth_history(trough_index + 1);
    y_vals = [peak_value, trough_value];
    
    % Ulcer Index (UI) :
    UI = sqrt(mean(drawdowns.^2));
    
    
end
