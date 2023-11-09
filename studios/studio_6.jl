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
	we wish to carry out a liquid-phase reaction A → R in a plug flow reactor. the volume of the reactor is 1150 L. the inlet feed comes in at 50 L/min and has 1.75 mol/L A. calculate the final concentration in the reactor.

	note, we do not possess any information about the mechanism of the reaction; we lack an explicit form for the rate law $r_A$ [mol/(L⋅min)]. however, we _do_ possess empirical data giving the rxn rate $-r_A$ at different concentrations of A, $c_A$ in a mixed flow reactor from a previous study (see below).

the data characterizing the rxn rate kinetics are below. you will need to build a linear interpolator of the data to integrate it properly.
"

# ╔═╡ a47bf67c-c117-48cc-83ee-1327e18e5979
data = DataFrame(
	"cₐ [mol/L]" 
		=> [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0, 1.3, 2.0],
	"-rₐ [mol/(L⋅min)]" 
		=> [0.1, 0.3, 0.5, 0.6, 0.5, 0.25, 0.1, 0.06, 0.05, 0.045, 0.042]
)

# ╔═╡ 81ce1844-f377-4e95-85af-d611ec3d4b0a
md"define a new column in the data frame, giving $-1/r_A$."

# ╔═╡ 42f30193-9b1f-4ce7-932b-cfd6dc4d6cee


# ╔═╡ ee9d8e11-05e1-43ed-b989-6b050983a906
md"volumetric flow rate in"

# ╔═╡ 7fe46c92-c615-43b4-b806-167b5d68b505
 # L / min

# ╔═╡ 62245252-4c12-4b57-a617-f5d7c2b09e27
md"volume"

# ╔═╡ 3853bff2-2f10-41c1-9b87-62bc4fad8b06
 # L

# ╔═╡ 1b163392-1da3-476b-a503-d2c18cad7f47
md"space-time"

# ╔═╡ ca8ae643-5b8a-46f9-9005-53ad64b65c0c
 # min

# ╔═╡ 0434dd02-9a73-4970-8656-80b818ed82ae
md"inlet concentration of A"

# ╔═╡ 1a6e5f5d-42d1-4fae-a7ec-f6b110c9540a
# mol / L

# ╔═╡ 0341c553-e92c-4d8a-a573-1aeb046562c5
md"linear interpolator of the data to represent the function $-1/r_A(c_A)$."

# ╔═╡ e8bcfcf6-3a42-433e-be14-9348d508648e


# ╔═╡ 1ede26d6-9298-48b6-9bad-958cbbdf6f64
md"viz data"

# ╔═╡ 720d197f-4711-4b82-87af-064b3dbf1239


# ╔═╡ faa226e7-f99b-429a-b7a4-d3977d84dbaf
md"numerical evaluation of the integral 
```math
\int_{c_{Af}}^{c_{A0}} \frac{1}{-r_A}dc_A
```
"

# ╔═╡ c78f5feb-4e9a-4cbf-906b-9f4a3b714fbc


# ╔═╡ 9065afdb-5749-4ce0-8b4e-516d6fb0fb14
md"apply performance eqn.; find zero of the function:
```math
f(c_{Af}):= \tau - \int_{c_{Af}}^{c_{A0}} \frac{1}{-r_A}dc_A
```
which finds the outlet concentration $c_{Af}$ consistent with the performance eqn. of the PFR.
"

# ╔═╡ e5ac537b-e607-44a0-b211-63e0121350eb


# ╔═╡ 9b6e864e-417f-4f1f-b942-8b6627f90f62


# ╔═╡ 790a25d3-9907-45f0-bc7f-ca37440488a0
md"viz the integral (as shaded area under the curve) with the data"

# ╔═╡ 934de6aa-0136-4a65-8a3a-03c5760e6776


# ╔═╡ Cell order:
# ╠═e1ade37e-7b61-11ee-0ec3-013625b64d2b
# ╠═6089fbdb-d84b-446e-9c48-679fa7204e05
# ╟─26e8e5c7-b87f-4ab6-b20f-a3146abf4bdb
# ╠═a47bf67c-c117-48cc-83ee-1327e18e5979
# ╟─81ce1844-f377-4e95-85af-d611ec3d4b0a
# ╠═42f30193-9b1f-4ce7-932b-cfd6dc4d6cee
# ╟─ee9d8e11-05e1-43ed-b989-6b050983a906
# ╠═7fe46c92-c615-43b4-b806-167b5d68b505
# ╟─62245252-4c12-4b57-a617-f5d7c2b09e27
# ╠═3853bff2-2f10-41c1-9b87-62bc4fad8b06
# ╟─1b163392-1da3-476b-a503-d2c18cad7f47
# ╠═ca8ae643-5b8a-46f9-9005-53ad64b65c0c
# ╟─0434dd02-9a73-4970-8656-80b818ed82ae
# ╠═1a6e5f5d-42d1-4fae-a7ec-f6b110c9540a
# ╟─0341c553-e92c-4d8a-a573-1aeb046562c5
# ╠═e8bcfcf6-3a42-433e-be14-9348d508648e
# ╟─1ede26d6-9298-48b6-9bad-958cbbdf6f64
# ╠═720d197f-4711-4b82-87af-064b3dbf1239
# ╟─faa226e7-f99b-429a-b7a4-d3977d84dbaf
# ╠═c78f5feb-4e9a-4cbf-906b-9f4a3b714fbc
# ╟─9065afdb-5749-4ce0-8b4e-516d6fb0fb14
# ╠═e5ac537b-e607-44a0-b211-63e0121350eb
# ╠═9b6e864e-417f-4f1f-b942-8b6627f90f62
# ╟─790a25d3-9907-45f0-bc7f-ca37440488a0
# ╠═934de6aa-0136-4a65-8a3a-03c5760e6776
