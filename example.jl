using DifferentialEquations
using Plots

function continuousFriction()

    g = 9810;    # mm/s^2

    # Base parameters
    f = 20.0;    # Hz
    Γ = 10.0;    # g
    ϕ = 0.5*pi;  # rad

    # Derived base parameters
    ω = 2*pi*f;    # rad/S
    V = Γ * g / ω; # mm/s

    # Base velocity
    v_b = t -> - V * (cos(ω*t)); # + 0.5*cos(2ω*t + ϕ)); 

    # Friction parameters
    μ_d =  0.16;    # 1
    Δv  = 200.0;     # mm/s
    μ_dg = μ_d * g; # mm/s^2

    # Friction model
    function frictionModel(v, v_b, t)
        - μ_dg * tanh((v - v_b(t))/Δv)
    end

    # Integration conditions
    v0 = 0.0 
    t_end = 5.0/f
    tspan = (0.0, t_end)

    # Define problem type and solve
    prob = ODEProblem(frictionModel, v0, tspan, v_b)
    sol = solve(prob, Rodas5P(), reltol = 1e-8, abstol = 1e-8)

    #plot(sol.t, t -> v_b(t), label = "v_b")
    plot(sol, xaxis = "t", yaxis = "v", label = "v_w")   

end