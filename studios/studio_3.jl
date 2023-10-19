### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 73f60f76-6d3f-11ee-14d3-733f8f62a3a2
begin
	import Pkg; Pkg.activate()
	using CairoMakie, DataFrames, MultivariateStats, CSV

	set_theme!(theme_black())
	update_theme!(fontsize=20, markersize=20, linewidth=3, resolution=(500, 500))
end

# ╔═╡ 1c0149ac-bef1-4218-82dc-3999af3cf890
md"## differential analysis of kinetic data

!!! warning \"learning objectives\"
	by example and experience,
	* understand and implement the differential method of kinetic data analysis
	* list the advantages (direct visualization of the rate law) and disadvantages (sensitivity to noise, need for high-resolution data) of the differential method compared to the integral method
	* again, manipulate rate laws to make them amenable for extracting rate constants from using a linear line-fitting routine
a constant-volume, isothermal, well-mixed batch reactor carries out the reaction:

A → B

we do not know if the reaction is elementary, but our working hypothesis is that the rate of rxn is:
```math
-r_A = kc_A^\alpha
```
with rate constant $k$ and order $\alpha$ unknown.

🧪 to gather kinetic data that provides information about $k$ and $\alpha$, we run a reaction in the reactor, measuring the concentration of A in the reactor at different times. the resulting kinetic data $\{(t_i, c_{A,i})\}_{i=1}^N$ is in `kinetic_data_A.csv`.


our task is to use the differential method to infer $k$ and $\alpha$ from this kinetic data.

🐒 read in the kinetic data in `kinetic_data_A.csv` as a `DataFrame`; assign it to a variable `data`.

!!! hint
	use `CSV.read` [here](https://csv.juliadata.org/stable/reading.html#CSV.read).
"

# ╔═╡ 2f345ccc-168b-4cb1-87d5-7c51fb573326

# ╔═╡ 8f07340b-ecda-4dfe-b300-0c7f871319bc
md"🐒 plot the concentration of A as a function of time (each data point should be represented as a point---the data should _not_ be drawn as a line). label your x- and y-axes and include units.

!!! hint
	the concentration of A should decay over time. the reaction is A → B, after all...
"

# ╔═╡ 24162dbb-61d7-4838-a17d-469a1b9d3980

# ╔═╡ 12144b1b-5c3f-4bd7-8538-9fdd24e0deed
md"🐒 numerically differentiate the data to estimate the rate of change of the concentration of A, $\dfrac{dc_A}{dt}$, at each time point in the data (except for the initial time) using a first-order backward finite difference. assign a new column in `data` with the name
\"dcₐ/dt [mol/(L⋅min)]\" that contains the reaction rate.

!!! note
	the _first-order backward finite difference_ makes the approximation:
	```math
	\frac{dc_A}{dt}\bigg\vert_{t=t_i} \approx \frac{c_{A,i}-c_{A, i-1}}{t_i - t_{i-1}} =: \frac{(\Delta c_A)_i}{(\Delta t)_i}
	```
	see [here](https://en.wikipedia.org/wiki/Finite_difference#Basic_types) for a picture explaining this approximation (pay attention to the secant line that approximates the tanget to the function).

!!! hint
	make a new column of zeros, assign the first row of that column to be `NaN` for not a number, then loop through and fill in the rest of the entries with the numerical derivative.

"

# ╔═╡ 6103166a-9ea3-4145-ad43-5e43d5d3ba02

# ╔═╡ 6fab27ca-8f27-4e37-8a04-617d5caba261
md"🐒 add a new column in the data frame `\"-rₐ [mol/(L⋅min)]\" that gives the reaction rate of A.

!!! hint
	don't overthink it. this is a simple line of code.
"

# ╔═╡ 6442b8ae-5254-4ad3-af54-220a4327cdf5

# ╔═╡ ed9ce49d-9c32-48b9-894d-d914a187b3ac
md"
😱 some of the -rₐ values are negative, implying that A is being produced instead of consumed! this isn't really happening---it's just that our measurements of the concentration are not perfect. this is a weakness of the differential method: numerical differentiation is very sensitive to noise in the data. the data doesn't look very noisy in the cₐ vs. t plot, but in your plot below of log(-rₐ) vs. cₐ, it _will_ look noisy! numerical differentiation amplifies noise.

this noise is going to cause us trouble (if you don't believe me, proceed to the next step). log of a negative number makes no sense. after all, $y:=\log(x)$ asks the question: for what $y$ does $e^y$ give $x$? well, if $x<0$, no $y \in \mathbb{R}$ is capable of that!

🐒 remove the rows from the data frame where the -rₐ > 0 so we can proceed with our differential analysis. 

!!! hint
	see the `filter! function [here](https://dataframes.juliadata.org/stable/lib/functions/#Base.filter) for filtering rows of a data frame. 
"

# ╔═╡ 29cd1092-7f92-4c33-9de1-4e4f487b329d
log(-0.00118433) # told ya, get DomainError

# ╔═╡ 20737e79-ec75-4f2f-8884-dfe69916f8f0

# ╔═╡ 6008cc07-9c45-4e98-b371-fa38c28f2b3a
md"🐒 scatter-plot the rate of reaction -rₐ, as computed via numerical differentiation, vs. cₐ. include x- and y-axis labels with units.


🥳 _this is a data-based representation of the reaction rate law!_ pause to appreciate this. 😄
"

# ╔═╡ 19dfded3-7da4-47a0-b92b-2fda35ead311

# ╔═╡ f44b497b-3a4b-468c-a8d1-33dba73337f9
md"taking the logarithm of the hypothesized rate law yields a relationship:
```math
\log(-r_A) = \log(k) + \alpha \log(c_A)
```
that indicates we can extract both $k$ and $\alpha$ from the data, after appropriately transformed, via a linear fitting route.

🐒 create two new columns in the data frame, `\"log(cₐ)\"` and `\"log(-rₐ)\"` that give the appropriate transformations of the data.
"

# ╔═╡ b2e1c52f-da29-4827-8d31-1ebd736c1940

# ╔═╡ 8803ac37-b7ec-4224-a953-4ecefe8bcfe5
md"🐒 draw an appropriate scatter plot of your transformed -rₐ vs. your transformed cₐ data. use `llsq` to fit a linear line to the data. draw the line of best fit on the same panel to assess fit. include x- and y-axis labels.

!!! hint
	see docs for `llsq` [here](https://docs.juliahub.com/MultivariateStats/l7I74/0.9.0/lreg/) or last week's studio.

!!! hint
    `llsq` cannot handle `NaN`. your `filter!` should have removed the `NaN`. but, if you filtered a different way, only feed `llsq` rows two onwards, eg. `data[2:end, \"log(cₐ)\"]`, to skip the first row, if it has an `NaN`.
"

# ╔═╡ aab83890-7b8c-4da7-906e-37a48110a49b

# ╔═╡ 63883787-ef2f-41dc-bf0d-0e105d2c8527

# ╔═╡ cbf02cae-accb-4f29-9626-c7af725de62a
md"🐒 finally, report the value of $k$ and $\alpha$ below based on your fitting of the kinetic data via the differential method."

# ╔═╡ 9b047a94-194f-48ce-9d88-b12e1fa969d9
println("α [unitless] = ", rand())

# ╔═╡ 9c0bf693-2531-4336-80bf-c16314286f8d
println("k [min⁻¹][mol/L]^(1-α) = ", rand())

# ╔═╡ 126dfff0-f6a1-421a-b7a9-8b0953c6556d
md"# optional space for written portion
universal gas constant
"

# ╔═╡ 96674fc4-e2bc-47c6-93db-727839392743
R = 0.082057366 # L⋅atm/(K⋅mol)

# ╔═╡ 30998de6-d75b-45e9-8bbb-d5b1bad552b1
P = 1.2 # atm

# ╔═╡ c901d2f0-96e5-49b0-8827-1499fa4f6b9f
_T = 25 # °C

# ╔═╡ 0efd23ab-2581-4a05-9f7e-f996360b06a7

# ╔═╡ c0ba88e6-3780-4a9f-8fdf-77a3db648453

# ╔═╡ 3a9d601c-56dd-45bd-91de-b7f6adef418c

# ╔═╡ 66414789-e98d-4994-ba10-13c4a22104d8

# ╔═╡ ec471d2b-4343-45e5-9f5f-52a05baa7949

# ╔═╡ a2685a06-27b0-4718-9d63-02494b235b01
LHS = (1 + ϵₐ) * ΔV / (V₀ * ϵₐ - ΔV) + ϵₐ * log(1 - ΔV / (V₀ * ϵₐ))

# ╔═╡ 2f15852b-daaa-4015-afa2-a7ea69525a92

# ╔═╡ Cell order:
# ╠═73f60f76-6d3f-11ee-14d3-733f8f62a3a2
# ╟─1c0149ac-bef1-4218-82dc-3999af3cf890
# ╠═2f345ccc-168b-4cb1-87d5-7c51fb573326
# ╟─8f07340b-ecda-4dfe-b300-0c7f871319bc
# ╠═24162dbb-61d7-4838-a17d-469a1b9d3980
# ╟─12144b1b-5c3f-4bd7-8538-9fdd24e0deed
# ╠═6103166a-9ea3-4145-ad43-5e43d5d3ba02
# ╟─6fab27ca-8f27-4e37-8a04-617d5caba261
# ╠═6442b8ae-5254-4ad3-af54-220a4327cdf5
# ╟─ed9ce49d-9c32-48b9-894d-d914a187b3ac
# ╠═29cd1092-7f92-4c33-9de1-4e4f487b329d
# ╠═20737e79-ec75-4f2f-8884-dfe69916f8f0
# ╟─6008cc07-9c45-4e98-b371-fa38c28f2b3a
# ╠═19dfded3-7da4-47a0-b92b-2fda35ead311
# ╟─f44b497b-3a4b-468c-a8d1-33dba73337f9
# ╠═b2e1c52f-da29-4827-8d31-1ebd736c1940
# ╟─8803ac37-b7ec-4224-a953-4ecefe8bcfe5
# ╠═aab83890-7b8c-4da7-906e-37a48110a49b
# ╠═63883787-ef2f-41dc-bf0d-0e105d2c8527
# ╟─cbf02cae-accb-4f29-9626-c7af725de62a
# ╠═9b047a94-194f-48ce-9d88-b12e1fa969d9
# ╠═9c0bf693-2531-4336-80bf-c16314286f8d
# ╟─126dfff0-f6a1-421a-b7a9-8b0953c6556d
# ╠═96674fc4-e2bc-47c6-93db-727839392743
# ╠═30998de6-d75b-45e9-8bbb-d5b1bad552b1
# ╠═c901d2f0-96e5-49b0-8827-1499fa4f6b9f
# ╠═0efd23ab-2581-4a05-9f7e-f996360b06a7
# ╠═c0ba88e6-3780-4a9f-8fdf-77a3db648453
# ╠═3a9d601c-56dd-45bd-91de-b7f6adef418c
# ╠═66414789-e98d-4994-ba10-13c4a22104d8
# ╠═ec471d2b-4343-45e5-9f5f-52a05baa7949
# ╠═a2685a06-27b0-4718-9d63-02494b235b01
# ╠═2f15852b-daaa-4015-afa2-a7ea69525a92
