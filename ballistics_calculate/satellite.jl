struct Satellite
    height::Real
    velocity::Vector{<:Real}
    position_0_vector::Vector{<:Real}

    function Satellite(Ω::Real, i::Real, height::Real)
        # Вектор нормали к плоскости орбиты
        norm_orbit = [sin(Ω) * sin(i), -cos(Ω) * sin(i), cos(i)]
        # Единичный радиус-вектор проведенный в точку перицентра орбиты
        position_0_vector = rotate_z(Ω) * rotate_x(i) * [0.0, 1.0, 0.0]
        # Вектор скорости в точке орбиты
        velocity = cross(norm_orbit, position_0_vector) .* sqrt(G * M / (R_earth + height))
        new(height, velocity, position_0_vector .* (R_earth + height))
    end
end

function rotate_x(φ::Real)
    return [
        1.0  0.0     0.0;
        0.0  cos(φ)  -sin(φ);
        0.0  sin(φ)  cos(φ);
    ]
end

function rotate_y(φ::Real)
    return [
        cos(φ)   0.0  sin(φ);
        0.0      1.0  0.0;
        -sin(φ)  0.0  cos(φ);
    ]
end

function rotate_z(φ::Real)
    return [
        cos(φ)  -sin(φ)  0.0;
        sin(φ)  cos(φ)   0.0;
        0.0     0.0      1.0;
    ]
end
