function t_observation = observation_time2(perihelion,aphelion,desired_inclination)

a = (perihelion + aphelion)/2;
e = 1 - perihelion / a;


% Constants
mu = 1.327*10^11;    % Solar Gravitational Parameter [km^3/s^2]
%%%%%

h = (mu*a*(1-e^2))^.5;
f = 0;
period = 2*pi*(a^3/mu)^.5;
period = round(period);                   % Round Period to nearest second for use in forloop

% Initialize Time of Observation
t_observation = 0;
%%%%%

for time = 1:period
    radius = a*(1-e^2)/(1+e*cosd(f));
    r_z    = radius*sind(f)*sind(desired_inclination);
    
    inc    = asind(r_z / radius);
    
    fdot   = h/radius^2*180/pi;
    f      = f+fdot;

    if abs(inc) >= 60
        t_observation = t_observation + 1;
    end
end

end