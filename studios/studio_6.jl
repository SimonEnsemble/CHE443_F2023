### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ e1ade37e-7b61-11ee-0ec3-013625b64d2b
begin
	import Pkg; Pkg.activate()
	using DataFrames, CairoMakie, Interpolations, Cubature, Roots
end

# ╔═╡ 6089fbdb-d84b-446e-9c48-679fa7204e05
update_theme!(resolution=(500, 500), linewidth=3, markersize=18, fontsize=20)

# ╔═╡ 26e8e5c7-b87f-4ab6-b20f-a3146abf4bdb
md"
!!! warning \"learning objectives\"
	* apply the performance equation of a plug flow reactor for design
	* practice numerical integration of data (use `Cubature.jl`)
	* practice numerically finding the zero of a function (use `Roots.jl`)
	* practice linear interpolation (use `Interpolations.jl`)
	* practice reading docs to learn how to eg. construct a linear interpolator.

!!! note \"problem statement\"
	we wish to carry out a liquid-phase reaction A → R in a plug flow reactor. the volume of the reactor is 10 L. the inlet feed comes in at 50 L/min and has 1.75 mol/L A. calculate the final concentration in the reactor.

	note, we do not possess any information about the mechanism of the reaction; we lack an explicit form for the rate law $r_A$ [mol/(L⋅min)]. however, we _do_ possess empirical data giving the rxn rate $-r_A$ at different concentrations of A, $c_A$ in a mixed flow reactor from a previous study (see below).

the data characterizing the rxn rate kinetics are below. you will need to build a linear interpolator of the data to integrate it properly.
"

# ╔═╡ a47bf67c-c117-48cc-83ee-1327e18e5979
data = DataFrame(
	"cₐ [mol/L]" 
		=> [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0, 1.3, 2.0],
	"-rₐ [mol/(L⋅min)" 
		=> [0.1, 0.3, 0.5, 0.6, 0.5, 0.25, 0.1, 0.06, 0.05, 0.045, 0.042]
)

# ╔═╡ 720d197f-4711-4b82-87af-064b3dbf1239
begin
	fig = Figure()
	ax = Axis(fig[1, 1], xlabel="cₐ [mol/L]", ylabel="-rₐ [mol/(L⋅min)]")
	scatter!(data[:, "cₐ [mol/L]"], data[:, "-rₐ [mol/(L⋅min)"])
	fig
end

# ╔═╡ Cell order:
# ╠═e1ade37e-7b61-11ee-0ec3-013625b64d2b
# ╠═6089fbdb-d84b-446e-9c48-679fa7204e05
# ╟─26e8e5c7-b87f-4ab6-b20f-a3146abf4bdb
# ╠═a47bf67c-c117-48cc-83ee-1327e18e5979
# ╠═720d197f-4711-4b82-87af-064b3dbf1239
