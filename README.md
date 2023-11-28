# Friction
Suite of friction models written in [julia](https://julialang.org/).

Requires **DifferentialEquations.jl** ([documentation](https://docs.sciml.ai/DiffEqDocs/stable/)) and **Plots.jl** ([documentation](https://docs.juliaplots.org/stable/)) packages.

To install them, run the following commands in the julia terminal:
```julia
using Pkg
Pkg.add("DifferentialEquations")
Pkg.add("Plots")
```

Note that the installation may take several minutes to complete.

To use the functions, copy the ```FrictionModels.jl``` file into your working directory, and import it like this:
```
import .FrictionModels as FM
```

The ```example.jl``` file contains an example of usage for a biharmonic base signal.
Note that some of the friction models will be unstable with current parameters.
