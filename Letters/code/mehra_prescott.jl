using Plots, LaTeXStrings
pgfplotsx()
default(legend_font_halign=:left)

@kwdef struct MehraPrescott
    γ::Float64 = 1.0
    β::Float64 = 0.99
    ρ::Float64 = -0.14
    xH::Float64 = 1 + 0.018 + 0.036
    xL::Float64 = 1 + 0.018 - 0.036
    pHH::Float64 = (1+ρ)/2
    pHL::Float64 = 1- pHH
    pLL::Float64 = (1+ρ)/2
    pLH::Float64 = 1- pLL
end

m = MehraPrescott(γ = 0.5,)

function solveMP(m::MehraPrescott)  
    A = [1-m.β * m.pHH * m.xH^(1-m.γ) -m.β * m.pHL * m.xL^(1-m.γ);
         -m.β * m.pLH * m.xH^(1-m.γ) 1-m.β * m.pLL * m.xL^(1-m.γ)]
    b = [m.β * (m.pHH * m.xH^(1-m.γ) + m.pHL * m.xL^(1-m.γ));
         m.β * (m.pLH * m.xH^(1-m.γ) + m.pLL * m.xL^(1-m.γ))]
    q = A \ b
    x = [m.xH, m.xL]
    Rs = ones(2,1) * x' .* (1 .+ q')./q
    ΔRs = Rs[:,1] - Rs[:,2]
    return (;q, Rs, ΔRs)
end

γ_range = range(0.01, 10.0, length = 100)
ΔRs_H = [solveMP(MehraPrescott(γ = γ, ρ = 0.15)).ΔRs[1] for γ in γ_range]
ΔRs_L = [solveMP(MehraPrescott(γ = γ, ρ = 0.15)).ΔRs[2] for γ in γ_range]

plot(γ_range, ΔRs_H, label = L"\Delta R_s(X,H)", l = 3.0, xlabel = L"\gamma", ylabel = L"\Delta R_s(X,s)", legend = :topright, 
    background_color_legend = :transparent, foreground_color_legend = :transparent)
plot!(γ_range, ΔRs_L, label = L"\Delta R_s(X,L)", l = 3.0)
hline!([0], label = "", l = :dash, color = :black)
savefig("submissions/JFE/Letters/figures/mehra_prescott.pdf")
