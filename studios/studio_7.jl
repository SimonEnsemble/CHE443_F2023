### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 21558ec8-8337-11ee-1eea-f703b04f269e
begin
	import Pkg; Pkg.activate()
	using CairoMakie, Optim, Statistics
	import AlgebraOfGraphics as AoG
	AoG.set_aog_theme!(fonts=[AoG.firasans("Light"), AoG.firasans("Light")])
	update_theme!(fontsize=20, linewidth=3, markersize=25, resolution=(500, 500))
end

# ╔═╡ 7432a1c6-2fc7-4fc5-b9d5-b5aa25dfb9a4
colors = AoG.wongcolors() # nice color pallette to use

# ╔═╡ ea6ff89b-1935-4f49-a515-0cb7ddd35976
md"# optimizing two MFR's in series

!!! note \"learning objectives\"
	* practice modeling two MFR's in series
	* use Levenspiel plots to visualize the volumes required of MFR's as shaded areas
	* optimize the sizes of two MFR's in series to achieve a given conversion

we wish to treat 10 L/min of liquid feed containing 1 mol substrate / L to 95% conversion with two mixed-flow reactors in series. the substrate conversion S → R obeys Michaelis-Menten kinetics:
```math
-r_S = \frac{c_S}{0.2+c_S} \text{ mol/(L⋅min)}
```
in this reactor design problem, your objective is to find the _optimal_ volume of the two mixed flow reactors.
"

# ╔═╡ 04d75c6e-c920-4b42-85db-3c1d4ddd5b0a
html"<img src=\"https://raw.githubusercontent.com/SimonEnsemble/CHE443_F2023/main/studios/mfr_series.png\" width=600>"

# ╔═╡ 5130b118-057c-481f-b427-5d0528380c5e
md"🐦 incoming volumetric flow rate"

# ╔═╡ 7011156e-f6a6-4438-a1d0-c1f92e35bdd1


# ╔═╡ efaabb6b-4814-4df3-b942-7883069d72b6
md"🐦 incoming concentration of substrate"

# ╔═╡ 116af33f-b19d-4fad-ab66-7385bdc1e7be


# ╔═╡ e3f7aa8b-3f64-4ad3-a000-a9366de704c4
md"🐦 desired conversion (the effluent of MFR #2)"

# ╔═╡ 1ec230d0-f54e-4835-9672-5c8c4db8e94a


# ╔═╡ bf73647b-7b3e-48c8-89d7-2ed8cf7b08c6
md"🐦 desired concentration out of MFR #2"

# ╔═╡ a9b029b3-ef1b-4165-b9f5-e4296a2f3c4e


# ╔═╡ b14e3801-b6f0-45db-9482-5f102c658596
md"🐦 code up the rate law $r_S(c_S)$ as a `function` in Julia."

# ╔═╡ ed25b9d3-fec1-4c84-b5a4-49c8cc427a4a


# ╔═╡ 3f541dcc-0884-4c68-9788-ad4ba34ca8cd
md"💡 in optimization, we must always clearly define our _decision variable(s)_ [one here] and our _objective function_ of the decision variable(s) we wish to maximize or minimize. usually, optimization problems have _constraints_ on the decision variables too. a trivial example of a constraint that is applicable here is positivity.

🐦 here, code up the objective function we wish to minimize, which is a function of the decision variable.
"

# ╔═╡ 8c8c9de0-a650-48bb-a562-b7261f58f1a8


# ╔═╡ d92c38ca-9a4a-431d-bfd1-7c2d7c6e4b5e


# ╔═╡ 430b2b69-0106-4844-af1d-6a9310577e04


# ╔═╡ 43c84c58-cc6c-47d4-801c-e04664e25a06
md"🐦 plot the objective function as a function of the decision variable. choose the `range` of the decision variable appropriately, so that you can clearly see a minimum. include x- and y-axis labels."

# ╔═╡ a83bcf94-bda0-4b03-9842-4ed5feef67d2


# ╔═╡ 91b8e4c0-89c9-4a8c-b1ba-adf252470f12
md"🐦 while you could \"eyeball\" the minimizer from your plot above, instead use `optimize` (docs [here](https://julianlsolvers.github.io/Optim.jl/stable/#user/minimization/#minimizing-a-univariate-function-on-a-bounded-interval)) to minimize the objective function with precision."

# ╔═╡ 2e951770-a1e0-4636-a429-2dfc1896e8f5


# ╔═╡ 449c74d5-0f18-4896-88db-f48c3d04ada8
md"🐦 below, modify the `println` statements to show the optimum (1) volume of MFR 1, (2) volume of MFR 2, and (3) concentration of substrate exiting MFR 1."

# ╔═╡ 70f09863-b090-49de-8266-d055fc8c31f1


# ╔═╡ 92bd1ce9-93cf-4b9f-b98a-0dc12e929417


# ╔═╡ ac5775d5-f2db-414f-b8a1-b1704d744609


# ╔═╡ ca935143-ecbb-41e2-bc01-d5d04c5521c5


# ╔═╡ 97a8f237-0fc0-429e-8f68-41cbda321141
begin
	println("opt. volume, MFR #1 = ", round(V_MFR₁_opt, digits=2), " L")
	println("opt. volume, MFR #1 = ", round(V_MFR₂_opt, digits=2), " L")
	println("opt. cₛ₁ = ", round(cₛ₁_opt, digits=2), " mol/L")
end

# ╔═╡ 835c29a3-4fad-4ba9-893c-b1c3e0cfab4a
md"🐦 finally, draw the Levenspiel plot for this reaction, where the relevant areas of the MFR's are shaded two different colors. include x- and y-axis labels. print text in the plot above the shaded areas, and the same color, using the `text` function. construct the `range` of $c_s$ for the x-axis to be a little above and a little below $c_{s0}$ and $c_{s2}$ respectively so that the pertinent areas are clearly visible.
"

# ╔═╡ 220a7203-78ed-47fd-adbd-41e6035d4ca9


# ╔═╡ 53d3a0ec-1db2-4e08-b367-9fed59cf4cdd


# ╔═╡ Cell order:
# ╠═21558ec8-8337-11ee-1eea-f703b04f269e
# ╠═7432a1c6-2fc7-4fc5-b9d5-b5aa25dfb9a4
# ╟─ea6ff89b-1935-4f49-a515-0cb7ddd35976
# ╟─04d75c6e-c920-4b42-85db-3c1d4ddd5b0a
# ╟─5130b118-057c-481f-b427-5d0528380c5e
# ╠═7011156e-f6a6-4438-a1d0-c1f92e35bdd1
# ╟─efaabb6b-4814-4df3-b942-7883069d72b6
# ╠═116af33f-b19d-4fad-ab66-7385bdc1e7be
# ╟─e3f7aa8b-3f64-4ad3-a000-a9366de704c4
# ╠═1ec230d0-f54e-4835-9672-5c8c4db8e94a
# ╟─bf73647b-7b3e-48c8-89d7-2ed8cf7b08c6
# ╠═a9b029b3-ef1b-4165-b9f5-e4296a2f3c4e
# ╟─b14e3801-b6f0-45db-9482-5f102c658596
# ╠═ed25b9d3-fec1-4c84-b5a4-49c8cc427a4a
# ╟─3f541dcc-0884-4c68-9788-ad4ba34ca8cd
# ╠═8c8c9de0-a650-48bb-a562-b7261f58f1a8
# ╠═d92c38ca-9a4a-431d-bfd1-7c2d7c6e4b5e
# ╠═430b2b69-0106-4844-af1d-6a9310577e04
# ╟─43c84c58-cc6c-47d4-801c-e04664e25a06
# ╠═a83bcf94-bda0-4b03-9842-4ed5feef67d2
# ╟─91b8e4c0-89c9-4a8c-b1ba-adf252470f12
# ╠═2e951770-a1e0-4636-a429-2dfc1896e8f5
# ╟─449c74d5-0f18-4896-88db-f48c3d04ada8
# ╠═70f09863-b090-49de-8266-d055fc8c31f1
# ╠═92bd1ce9-93cf-4b9f-b98a-0dc12e929417
# ╠═ac5775d5-f2db-414f-b8a1-b1704d744609
# ╠═ca935143-ecbb-41e2-bc01-d5d04c5521c5
# ╠═97a8f237-0fc0-429e-8f68-41cbda321141
# ╟─835c29a3-4fad-4ba9-893c-b1c3e0cfab4a
# ╠═220a7203-78ed-47fd-adbd-41e6035d4ca9
# ╠═53d3a0ec-1db2-4e08-b367-9fed59cf4cdd
