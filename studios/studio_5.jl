### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 96845a6b-7c5c-42c0-ac24-a2672b362974
begin
	import Pkg; Pkg.activate()
	using DataFrames, CairoMakie, MultivariateStats
end

# ╔═╡ 26187802-f2a1-478a-bcf0-5617e757c5c9
update_theme!(fontsize=20, resolution=(500, 500), markersize=18)

# ╔═╡ 471779b2-78e4-11ee-2e36-31610f90b948
md"# studio 5: inferring a rxn rate law from multiple MFR runs

MFR = mixed flow reactor

!!! note \"learning objectives\"
	* calculate conversion from concentration in the exit stream of an MFR
	* apply the performance eqn. of the MFR to calculate the rxn rate in an MFR
	* infer the rxn rate law from data giving exit concentrations in multiple steady-state runs in an MFR with eg. different volumetric feed rates

📖 check out Example 5.2 in the Levenspiel textbook for a similar problem.

!!! warning \"problem statement\"
	pure gaseous A at 3 atm and 30°C is fed into a MFR at various flow rates over multiple runs. the volume of the MFR is 3 L. inside the MFR, A decomposes according to the rxn A → 3R. for each run of the MFR with a different flow rate, we wait for it to reach steady state, then measure the concentration of A in the outlet stream. from the kinetic data we collected (below), find a rate equation that governs the kinetics of the decomposition of A. assume that A alone affects the rxn rate. the MFR is run isothermally and isobarically (30°C, 3 atm). treat the gas as ideal.

the score for this computational portion constitutes:
* the correct order of the rxn, $\alpha$, calculated by a linear fitting routine
* the correct value of $k$ [with units], calculated by a linear fitting routine
* a plot of the rxn rate $-r_A$ [mol/(min⋅L)] vs. concentration of A $c_A$ [mol/L] including (i) the data as points, (ii) the rate law you obtained as a line, and (iii) proper x- and y-axis labels with units.

!!! hint
	you will need a line-fitting routine. see `llsq` as part of the `MultivariateStats` package. 
"

# ╔═╡ 51d7a22f-2bdd-47aa-a164-164d923a55ac
data = DataFrame(
	"run #"       => [1, 2, 3, 4],
	"ν₀ [L/min]"  => [0.06, 0.48, 1.5, 8.1],
	"cₐ [mmol/L]" => [30.0, 60.0, 80.0, 105.0]
)

# ╔═╡ Cell order:
# ╠═96845a6b-7c5c-42c0-ac24-a2672b362974
# ╠═26187802-f2a1-478a-bcf0-5617e757c5c9
# ╟─471779b2-78e4-11ee-2e36-31610f90b948
# ╠═51d7a22f-2bdd-47aa-a164-164d923a55ac
