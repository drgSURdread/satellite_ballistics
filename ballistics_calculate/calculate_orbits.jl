# Расчет траектории
function calculate_trajectory(initial_velocity, initial_position, time, dt)
    # Инициализация массивов для хранения результатов
    x = [initial_position[1]]
    y = [initial_position[2]]
    z = [initial_position[3]]
    
    # Инициализация массива для хранения абсолютной скорости
    absolute_velocity = []

    # Инициализация массива для хранения расстояния от центра Земли
    absolute_altitude = []

    # Инициализация массивов для хранения скоростей и ускорений
    velocities = []
    accelerations = []

    # Вычисление новых скоростей по формуле скорости
    v = initial_velocity

    for t in 0:dt:time
        # Вычисление ускорений по закону тяготения
        r = norm([x[end], y[end], z[end]])
        a = -G * M / r^3 * [x[end], y[end], z[end]]
        
        # Вычисление новых скоростей по формуле скорости
        v += a * dt
        
        # Вычисление абсолютной скорости
        absolute_v = norm(v)
        
        # Вычисление расстояния от поверхности Земли
        absolute_a = norm(r) - R_earth
        
        # Вычисление новых координат по формулам
        x_new = x[end] + v[1] * dt
        y_new = y[end] + v[2] * dt
        z_new = z[end] + v[3] * dt
        
        # Добавление новых координат в массивы
        push!(x, x_new)
        push!(y, y_new)
        push!(z, z_new)
        
        # Добавление новой абсолютной скорости в массив
        push!(absolute_velocity, absolute_v)
        
        # Добавление нового расстояния от центра Земли в массив
        push!(absolute_altitude, absolute_a)

        # Добавление новых скоростей и ускорений в массивы
        push!(velocities, v)
        push!(accelerations, a)
    end

    return x, y, z, velocities, accelerations, absolute_velocity, absolute_altitude
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
