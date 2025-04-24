% VSTUPY A PARAMETRE

% Matica dennıch vınosov :
returns = readtable('matica_vynosov.csv');
returns = table2array(returns(2:757,2:31));

% Matica adjusted close prices :
matica_adjusted_prices = readtable('matica_adjclose.csv');
matica_adjusted_prices = table2array(matica_adjusted_prices(:,2:31));

% Bezrizikovı päroènı americkı štátny dlhopis (^FVX) :
 rf_rate = 0.04619/252; %  prevedenı na dennı vınos -> 10.10.2023 (505 deò)
%  rf_rate = 0.0341/252; % Pre krízové dáta -> 2008-05-29 

% Rozmery :
window_size = 504; % ve¾kos jedného rebalanèného obdobia
test_size = 21; % Poèet dní pre testovanie váh
num_iterations = (size(returns, 1) - window_size) / test_size;  % Poèet posunov okna

% Parametre optimalizácie :
risk_aversion = 10;  % parameter averzie voèi riziku - hodnoty :10, 5, 1

% Škálovací parameter elipsoidovej optimalizácie :
% T štatistika:
F_stat = finv(0.95,30,474);
sqrt_gamma = sqrt(30*F_stat/(504-30)); % = 0.3064

% Parametre boxovej optimalizácie s konštantnou betou :
beta_constant = 1; 

% Parameter skriptu Comparison_portfolio_performance - investovanı poèiatoènı kapitál :
wealth = 1;

% Inicializácia pre uchovanie vısledkov :
mean_variance_weights = [];
mean_variance_weights_before_reb = [];
mean_variance_returns = [];  
mean_variance_daily_portfolio_returns = [];
mean_variance_excess_returns = [];

diagonal_weights = [];  
diagonal_weights_before_reb = [];  
diagonal_returns = [];
diagonal_daily_portfolio_returns = [];
diagonal_excess_returns = [];
diagonal_Corrs = [];

rolling_mean_weights = [];  
rolling_mean_weights_before_reb = [];  
rolling_mean_returns = [];
rolling_mean_daily_portfolio_returns = [];
rolling_mean_excess_returns = [];

ellipsoid_weights = [];  
ellipsoid_weights_before_reb = [];
ellipsoid_returns = [];  
ellipsoid_daily_portfolio_returns = [];
ellipsoid_excess_returns = [];  
Volume_ellipsoid = [];

box_weights = [];  
box_weights_before_reb = [];  
box_returns = [];
box_daily_portfolio_returns = [];
box_excess_returns = [];
Volume_box = [];
betas = [];

box_const_weights = [];  
box_const_weights_before_reb = [];  
box_const_returns = [];
box_const_daily_portfolio_returns = [];
box_const_excess_returns = [];
Volume_box_const = [];
betas_const = [];

matice_kovariancie = [];
matice_vynosu = [];

% uniform_weights = [];  
% uniform_weights_before_reb = [];  
% uniform_returns = [];
% uniform_daily_portfolio_returns = [];
% uniform_excess_returns = [];



