%% Hover 5-min 4000ft 95deg (ISA+20K) 

% Constants
P0 = 101325;           % SL std pressure [Pa]
T0 = 288.15;           % SL std temp [K]
L = 0.0065;            % Temperature lapse rate [K/m]
g = 9.81;              % [m/s^2]
R = 287.058;           % Specific gas const [J/(kg·K)]
h_ft = 4000;           % Altitude [ft]
delta_ISA = 293.15;        % Temperature deviation [K]


h = h_ft * 0.3048;     % [m] Convert altitude to meters
T_ISA = T0 - L * h;    % [K] ISA temperature at altitude
T_actual = T_ISA + delta_ISA;  % [K] Actual temperature (ISA + deviation)
P = P0 * (1 - (L * h) / T0)^(g / (R * L)); % Pressure at altitude using barometric formula
rho = P / (R * T_actual);  % [kg/m^3]  Air density using ideal gas law

% Power required (Profile + Induced)
cd_rotor = 0.01;
k_downloading = 0.1;
k_ideal = 1.1;
N_b = 6
omega= 589 % [rmp]
c= 1.6002 % [m] chord main rotor
R = 3.81 % [m] rotor blade radius

P_o = (1/8)*rho*N_b*(omega)^3*c*cd_rotor*R^4
