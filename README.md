# Friction
Suite of friction models written in [julia](https://julialang.org/).

They are written to be integrated with **DifferentialEquations.jl** ([documentation](https://docs.sciml.ai/DiffEqDocs/stable/)).

To install it, run the following commands in the julia REPL:
```julia
using Pkg
Pkg.add("DifferentialEquations")
```
Note that the installation may take several minutes to complete.

To use the functions, copy the ```FrictionModels.jl``` file into your working directory, and include it like this:
```
include("FrictionModels.jl")
```

The ```example.jl``` file contains an example of usage for a biharmonic base signal.
Note that some of the friction models will be unstable with current parameters.
