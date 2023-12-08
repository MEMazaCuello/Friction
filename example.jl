using DifferentialEquations
using Plots

include("FrictionModels.jl")

function example()

    g = 9810;    # mm/s^2

    # Base parameters
    f = 20.0;     # Hz
    Γ = 0.63;     # g
    ϕ = 3.0*pi/8.0;  # rad

    # Derived base parameters
    ω = 2*pi*f;    # rad/S
    V = Γ * g / ω; # mm/s

    # Base velocity
    a_b = t ->   Γ * g * (sin(ω*t) + sin(2ω*t + ϕ))
    v_b = t -> - V * (cos(ω*t) + 0.5*cos(2ω*t + ϕ)); 

    # Friction parameters
    μ_d =  0.16;    # 1
    μ_s =  0.20;    # 1
    μ_dg = μ_d * g; # mm/s^2
    μ_sg = μ_s * g; # mm/s^2

    Δv = 5.0;    # mm/s
    v0 = 0.5;    #mm/s
    v1 = 5.0;    #mm/s

    ## Friction models
    #frictionModel = (v, p, t) -> CoulombTanh(v, p, t, v_b, μ_dg, Δv)
    #frictionModel = (v, p, t) -> CoulombLinear(v, p, t, v_b, μ_dg, 1.0/Δv)
    #frictionModel = (v, p, t) -> PiecewiseLinear(v, p, t, v_b, μ_dg, μ_sg, v0, v1)
    #frictionModel = (v, p, t) -> BengisuAndAkay(v, p, t, v_b, μ_dg, μ_sg, v0, 1.0/Δv)
    frictionModel = (v, p, t) -> Ambrosio(v, p, t, v_b, μ_dg, v0, v1)

    # Integration conditions
    v0 = 0.0 
    t_end = 5.0/f
    tspan = (0.0, t_end)

    # Define problem type and solve
    prob = ODEProblem(frictionModel, v0, tspan)
    sol = solve(prob, Tsit5(), reltol = 1e-8, abstol = 1e-8)

    plot(0.0:0.0001:t_end, t -> v_b(t), label = "v_b")
    plot!(sol, xaxis = "t", yaxis = "v", label = "v_w") 
end
