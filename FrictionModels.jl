module FrictionModels

    export CoulombTanh
    export CoulombLinear
    export PiecewiseLinear
    export BengisuAndAkay
    export Ambrosio

    function CoulombTanh(v, p, t, vb, fc, Δv)
        @. fc * tanh( (vb(t) - v) / Δv )
    end

    function CoulombLinear(v, p, t, vb, fc, k)
        vT = vb(t) - v
        @. fc * min( k * vT, sign(vT) )
    end

    function PiecewiseLinear(v, p, t, vb, fc, fs, v0, v1)
        # Unstable for stick condition
        vT = vb(t) - v
        sT = sign(vT)
        vT = abs(vT)
        if v1 < vT
            return fc * sT
        elseif vT < v0
            return fs * ( vT / v0 ) * sT
        else
            return (fs - (fs - fc) * (vT - v0) / (v1 - v0) ) * sT
        end
    end

    function BengisuAndAkay(v, p, t, vb, fc, fs, v0, ξ)
        # Unstable for stick condition
        vT = vb(t) - v
        sT = sign(vT)
        vT = abs(vT)
        if vT < v0
            return fs * ( 1.0 - (vT - v0)^2/v0^2 ) * sT
        else
            return (fc + (fs - fc) * exp( -ξ * (vT - v0) )) * sT
        end
    end

    function Ambrosio(v, p, t, vb, fc, v0, v1)
        # Unstable for stick condition
        vT = vb(t) - v
        sT = sign(vT)
        vT = abs(vT)
        if v1 < vT
            return fc * sT
        elseif vT < v0
            return 0.0
        else
            return fc * (vT - v0) / (v1 - v0)  * sT
        end        
    end

end