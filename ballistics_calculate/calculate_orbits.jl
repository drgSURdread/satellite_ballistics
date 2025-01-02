# Расчет траектории
function calculate_trajectory(initial_velocity_vector, initial_position_vector, time, dt)
    position = [initial_position_vector[1] initial_position_vector[2] initial_position_vector[3]]
    
    # Инициализация массива для хранения абсолютной скорости
    absolute_velocity = []
    absolute_altitude = []
    velocities = []
    accelerations = []
    v = initial_velocity_vector

    for t in 0:dt:time
        last_position_vector = [position[end, 1], position[end, 2], position[end, 3]]
        r = norm(last_position_vector)
        a = -G * M / r^3 * last_position_vector
        
        v += a * dt
        
        position = vcat(
            position,
            transpose(
                [
                    last_position_vector[1] + v[1] * dt;
                    last_position_vector[2] + v[2] * dt;
                    last_position_vector[3] + v[3] * dt;
                ]
            )
        )
        
        push!(absolute_velocity, norm(v))
        
        push!(absolute_altitude, norm(r) - R_earth)

        push!(velocities, v)
        push!(accelerations, a)
    end

    return position[:, 1], position[:, 2], position[:, 3], velocities, accelerations, absolute_velocity, absolute_altitude
end

## Получение точек сферы земли
function spherical_to_cartesian(phi::Float64, theta::Float64)
    x = R_earth * sin(theta) * cos(phi)
    y = R_earth * sin(theta) * sin(phi)
    z = R_earth * cos(theta)
    return (x, y, z)
end

# Визуализация Земли
function get_earth_sphere()
    phi = range(0, stop=2*pi, length=100)
    theta = range(0, stop=pi, length=50)

    x_earth = zeros(length(phi), length(theta))
    y_earth = zeros(length(phi), length(theta))
    z_earth = zeros(length(phi), length(theta));

    for i in 1:length(phi)
        for j in 1:length(theta)
            result = spherical_to_cartesian(phi[i], theta[j])
            x_earth[i,j] = result[1]
            y_earth[i,j] = result[2]
            z_earth[i,j] = result[3]
        end
    end
    
    return surface(x=x_earth, y=y_earth, z=z_earth, color=:blue, labels="Земля", alpha=0.9)
end
