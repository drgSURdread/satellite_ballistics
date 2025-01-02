module Ballistics

using LinearAlgebra
using PlotlyJS

# Константы
G = 6.67430e-11    # Гравитационная постоянная
M = 5.972e24       # Масса Земли, кг
R_earth = 6371.0e3 # Радиус Земли, м

include("satellite.jl")
export Satellite, rotate_x, rotate_y, rotate_z

include("calculate_orbits.jl")
export calculate_trajectory, get_earth_sphere

end