include("ballistics_calculate/Ballistics.jl")
using .Ballistics
using PlotlyJS

# Построение наклоных орбит
N = 6  # Количество орбит
dΩ = deg2rad(360.0) / N  # Шаг по долготе восходящего узла, рад
i = deg2rad(50.827)      # Наклонение, рад
height = 800.0e3         # Высота орбиты, м
total_time = 11200.0     # Время движения спутника, сек
dt = 50.0                # Шаг по времени, с
times = 0:dt:total_time

traces = [get_earth_sphere()]

for j in 1:N
    satellite = Satellite(dΩ * (j - 1), i, height)
    x, y, z, velocities, accelerations, absolute_velocity, absolute_altitude = calculate_trajectory(
        satellite.velocity, 
        satellite.position_0_vector, 
        total_time,
        dt
    )
    push!(
        traces, 
        scatter(
            x=x, y=y, z=z, 
            legend=false,
            linewidth=5, color=:red, 
            type="scatter3d", mode="lines"
        )
    )
end

display(plot(traces))
readline()
