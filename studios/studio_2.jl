### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 87c97592-671d-11ee-3393-b9a010d572b3
begin
	import Pkg; Pkg.activate()
	using CairoMakie, DataFrames, MultivariateStats, CSV
	update_theme!(fontsize=20, resolution=(500, 500), linewidth=3, markersize=15)
end

# ╔═╡ 2292b430-7250-40a9-bfe7-4135008b111c
md"## quick Julia tidbits

!!! example \"learn by example\"
	let's
	* create fake data with a relationship $y=m x + b + \epsilon$ where $\epsilon$ is normally-distributed noise, $m=3$ is the slope, and $b=1$ is the intercept. 
	* fit a line to this data.
	* plot to assess fit.
"

# ╔═╡ a2e2ac98-f639-4ea3-940e-82cb8debeef5
fake_data = DataFrame(
	x = [0, 1, 1.5, 2, 5, 7.5, 10]
)

# ╔═╡ 932967cb-b3cd-4178-bafb-c3adcfbc1676
# generate noise
ϵs = 0.3 * randn(nrow(fake_data))

# ╔═╡ e81107c4-335e-46bb-aca8-385a5f4214aa
# add new column, y, by transforming x column
fake_data[:, "y"] = 3 * fake_data[:, "x"] .+ 1 .+ ϵs

# ╔═╡ a67f6833-b321-451f-b4e5-057b3603653a
# lookit the data frame now
fake_data

# ╔═╡ 60114b54-3031-4efd-ab73-1b6fb5c5d3fc
# fit line
m, b = llsq(fake_data[:, "x"], fake_data[:, "y"])

# ╔═╡ 136d4199-1679-41be-a613-0b44fae33dbc
begin
	local fig = Figure()
	local ax = Axis(
		fig[1, 1], 
		xlabel="x", 
		ylabel="y"
	)
	# plot data as points
	scatter!(fake_data[:, "x"], fake_data[:, "y"], label="data")
	# plot linear line as a line
	lines!([0, 10], m * [0, 10] .+ b, label="fit")
	# add legend (uses the label attribute)
	axislegend(position=:rb)
	fig
end

# ╔═╡ faefbf08-b191-4dc7-9414-ffc13ff3eb7d
md"## inferring the activation energy of a [an elementary] reaction from rate data

!!! background
	see [this open textbook](https://chem.libretexts.org/Bookshelves/Physical_and_Theoretical_Chemistry_Textbook_Maps/Supplemental_Modules_(Physical_and_Theoretical_Chemistry)/Kinetics/06%3A_Modeling_Reaction_Kinetics/6.02%3A_Temperature_Dependence_of_Reaction_Rates/6.2.03%3A_The_Arrhenius_Law/6.2.3.01%3A_Arrhenius_Equation) for an article on the Arrhenius equation.
	> chemical reactions occur more rapidly at higher temperatures.
	> the reason for this is not hard to understand. as the temperature rises, molecules move faster and collide more vigorously, greatly increasing the likelihood of bond cleavages and rearrangements. whether it is through the collision theory, transition state theory, or just common sense, chemical reactions are typically expected to proceed faster at higher temperatures and slower at lower temperatures.

for the isomerization of cyclopropane to propene
"

# ╔═╡ 251e0c7f-c5dc-4392-a5a2-f29d5416c8fd
html"<img src=\"https://chem.libretexts.org/@api/deki/files/17851/cyclopropisom_eqn.png\">"

# ╔═╡ 8ce71abb-757c-4c12-b204-20e6e1fa191f
md"we measured the first-order rate constant $k$ for this isomerization reaction at various temperatures. the data are below."

# ╔═╡ 4d18b312-671b-41b2-90d6-024244a3b787
data = DataFrame(
	"T [°C]"  => [477, 523, 577, 623],
	"k [s⁻¹]" => [0.00018, 0.0027, 0.030, 0.26]
)

# ╔═╡ c30e992f-b3b4-4165-b3a2-4fe182f17f8f
md"🏂 
* make the appropriate nonlinear transformations of $T$ and $k$ to give a linear relationship. store these transformations as new columns in `data`.
* fit a line to the transformed data to identify the $E/R$ [K], the activation energy divided by the universal gas constant.
* plot the data as a scatter where we expect a linear relationship and draw the line of best fit in the same panel
* report your value of the activation energy $E$ in units [kJ/mol] clearly

!!! hint
	add new (transformed) columns to a data frame like eg.:
	```
	data[:, \"new_col\"] = sin.(data[:, \"T [°C]\"]) # sine of the temp. column
	```

!!! hint
	to fit a line to data, use the `llsq` function [here](https://juliastats.org/MultivariateStats.jl/dev/lreg/#Linear-Least-Square). it takes the list of `x` values (more generally a matrix, but this is single-variable regression), the list of `y` values, and returns the slope and intercept.
"

# ╔═╡ ea7e93ec-f01d-4389-8bb0-4fec6a13a1a8


# ╔═╡ 1a70e8aa-1ac9-47ef-a0ab-6f8444b0f6de


# ╔═╡ d77cd704-d3b3-469d-958e-c6e71d4b8af1


# ╔═╡ 4ab3300a-47f5-443e-bf65-a58f5f08478c
println("value of E [kJ/mol] = ", rand())

# ╔═╡ d21a63dc-8180-4462-887e-2750b92efd95
md"🏂 write a function `k(T)` that uses the Arrhenius model to predict the rate constant $k$ [s⁻¹] at the temperature `T` [°C] passed to it.

!!! hint
	your linear fitting routine should give you a slope and intercept. I would use that.
 "

# ╔═╡ 8dc7e96b-bf63-4dd7-b6a6-6ac37e6b19c3


# ╔═╡ 1fef9340-7fdf-4778-a7a9-a903bad678be
md"🏂 to test your function, call `k(T)` for `T=477` °C. we have a data point at this temperature, so your function should return a value for $k$ that is somewhat close to the experimentally measured $k$."

# ╔═╡ 4752ea12-f026-45b0-a0a2-46f9a336dc2b


# ╔═╡ 990ccad2-c293-4895-85ac-5567e03bf6ad
md"🏂 predict what $k(T)$ would be at a temperature not in the data set, `T=600` °C.

!!! note
	this is the practical value of our fitting procedure: not just confirming the rate data adheres to the Arrhenius theory, but using the fit to predict what the rate will be at other temperatures, for reactor design.
"

# ╔═╡ 070ff46d-d8cc-4ffd-8ae2-d7bd190cb74e


# ╔═╡ fce32a04-befb-4170-9552-1eabe87ac7fd
md"🏂 generally, _the rate of rxn is more temperature-sensitive at low temperatures than higher temperatures_. 

to discover this yourself for this isomerization rxn, consider two temperatures `T_lo` and `T_hi`. suppose, starting at each temperature, the temperature increases by `ΔT`. use your function `k(T)` to calculate the ratios `k(T_hi + ΔT) / k(T_hi)` and the same for `T_lo`. this is the ratio of the rate constant after the temperature change to before it. which is larger?
"

# ╔═╡ 7017dcde-100e-4f1a-9c5d-3d375d42f3ff
begin
	T_lo = 400.0 # °C
	T_hi = 700.0 # °C
	ΔT = 10.0    # °C
end

# ╔═╡ e1344dcb-9897-407b-bed7-614834572e0c


# ╔═╡ f89cd236-ba1d-4624-9d85-0e34e20a447f


# ╔═╡ 312836d1-14d6-44d5-b550-16696eb5a602
md"## inferring a rate constant from kinetic data

sulfuric acid reacts with diethylsulfate in aqueous solution at 22.9°C:

H₂SO₄ + (C₂H₅)₂SO₄ $\rightarrow$ 2C₂H₅SO₄H

the initial concentrations of reactants are:
[H₂SO₄]₀ = [(C₂H₅)₂SO₄]₀ = 5.5 mol/L
with no product, ie. [C₂H₅SO₄H]₀ = 0 mol/L.

assume this reaction is elementary ie. has rate law $r_{\text{C}_2\text{H}_5\text{SO}_4\text{H}}=\kappa [\text{H}_2\text{SO}_4][(\text{C}_2\text{H}_5)_2\text{SO}_4]$.

our task is to use kinetic data to infer the value of $\kappa$.

🏂 define the initial concentrations of reactants as variables `c_H₂SO₄_₀` and `c__C₂H₅_₂SO₄_₀`.
"

# ╔═╡ 1900e4a6-1743-4972-8c27-4fb05819c2d2
begin
	c_H₂SO₄_₀      = 5.5 # mol/L
	c__C₂H₅_₂SO₄_₀ = 5.5 # mol/L
end

# ╔═╡ 861095f6-4cec-4a74-9014-ee48f4256395
md"🏂 the kinetic data in `kinetic_data.csv` gives the concentration of the product [C₂H₅SO₄H] over time in a well-mixed, isothermal (constant-volume) batch reactor. read this data into Julia as a data frame assigned to variable `kinetic_data`.

!!! hint
	see `CSV.read` [docs](https://csv.juliadata.org/stable/reading.html#CSV.read)."

# ╔═╡ f037972f-e1e8-4758-908d-6bc906260727


# ╔═╡ 36c93779-6f83-4b51-a56f-5b50b237c357
md"🏂 add new columns to the data frame:
* `\"[H₂SO₄] [mol/L]\"` giving the concentration of H₂SO₄ at each time.
* `\"X H₂SO₄\"` giving the fractional conversion of H₂SO₄ at each time.
* the appropriate linear transformation `f(X H₂SO₄)` of the conversion that gives a linear relationship between it and time, to facilitate identifying $\kappa$ via a linear fit.
"

# ╔═╡ 935ed283-d2f0-4e17-82c8-e70ea82f5d40


# ╔═╡ 2ec86fe5-2ef3-4921-ab77-14ba9a6be1ba
md"🏂 fit a line to the appropriate nonlinear transformation of the conversion vs. time data. what is the value of $k$? print the value, with units, too.

!!! hint
	note, the intercept theoretically should be zero. so we should force this in the fitting routine. to do this, look at the docs of `llsq` and read about the `bias` argument.
"

# ╔═╡ 69a5aabd-4206-4826-ab57-8e9fbb2d8508


# ╔═╡ 102381e9-596b-436b-85dc-2eb71859afa7
println("κ [units?] = ", rand())

# ╔═╡ 39d737c4-6b05-4d12-bdeb-b8c5230dff6c
md"🏂 plot the nonlinearly-transformed conversion against time, which should yield a linear-ish[^1] relationship. include x- and y-axis labels with units indicated (unless unitless). in the same panel, plot your line fit to make sure the `κ` you identified fits the data reasonably.

[^1]: in reality, data do not always fit theory perfectly, owing to the approximate nature of the measurements of concentration, inadequate theory, or uncontrolled variables during the experiment (eg., ill-mixing, poor heat management) unaccounted for in the model. we _may_ judge that this fit is inadequate, reject the hypothesis that this is a bimolecular reaction, and hypothesize a different rate law."

# ╔═╡ 8e0e3115-e819-43c8-99c2-848a65d5416e


# ╔═╡ 4f143b08-bdc9-4bd1-8f43-98d7c771a2fa
md"🏂 the reason we sought the value of $\kappa$ is that we can now predict how a reaction will progress with different initial conditions (but the same temperature of 22.9°C). suppose now instead:

* [H₂SO₄]₀ = 1 mol/L
* [(C₂H₅)₂SO₄]₀ = 3 mol/L
* [C₂H₅SO₄H]₀ = 0 mol/L

plot the predicted conversion of H₂SO₄ vs. time for $t \in [0, 4000]$ min.
"

# ╔═╡ 34a2d705-90ba-4adb-af13-6d2792a47471


# ╔═╡ Cell order:
# ╠═87c97592-671d-11ee-3393-b9a010d572b3
# ╟─2292b430-7250-40a9-bfe7-4135008b111c
# ╠═a2e2ac98-f639-4ea3-940e-82cb8debeef5
# ╠═932967cb-b3cd-4178-bafb-c3adcfbc1676
# ╠═e81107c4-335e-46bb-aca8-385a5f4214aa
# ╠═a67f6833-b321-451f-b4e5-057b3603653a
# ╠═60114b54-3031-4efd-ab73-1b6fb5c5d3fc
# ╠═136d4199-1679-41be-a613-0b44fae33dbc
# ╟─faefbf08-b191-4dc7-9414-ffc13ff3eb7d
# ╟─251e0c7f-c5dc-4392-a5a2-f29d5416c8fd
# ╟─8ce71abb-757c-4c12-b204-20e6e1fa191f
# ╠═4d18b312-671b-41b2-90d6-024244a3b787
# ╟─c30e992f-b3b4-4165-b3a2-4fe182f17f8f
# ╠═ea7e93ec-f01d-4389-8bb0-4fec6a13a1a8
# ╠═1a70e8aa-1ac9-47ef-a0ab-6f8444b0f6de
# ╠═d77cd704-d3b3-469d-958e-c6e71d4b8af1
# ╠═4ab3300a-47f5-443e-bf65-a58f5f08478c
# ╟─d21a63dc-8180-4462-887e-2750b92efd95
# ╠═8dc7e96b-bf63-4dd7-b6a6-6ac37e6b19c3
# ╟─1fef9340-7fdf-4778-a7a9-a903bad678be
# ╠═4752ea12-f026-45b0-a0a2-46f9a336dc2b
# ╟─990ccad2-c293-4895-85ac-5567e03bf6ad
# ╠═070ff46d-d8cc-4ffd-8ae2-d7bd190cb74e
# ╟─fce32a04-befb-4170-9552-1eabe87ac7fd
# ╠═7017dcde-100e-4f1a-9c5d-3d375d42f3ff
# ╠═e1344dcb-9897-407b-bed7-614834572e0c
# ╠═f89cd236-ba1d-4624-9d85-0e34e20a447f
# ╟─312836d1-14d6-44d5-b550-16696eb5a602
# ╠═1900e4a6-1743-4972-8c27-4fb05819c2d2
# ╟─861095f6-4cec-4a74-9014-ee48f4256395
# ╠═f037972f-e1e8-4758-908d-6bc906260727
# ╟─36c93779-6f83-4b51-a56f-5b50b237c357
# ╠═935ed283-d2f0-4e17-82c8-e70ea82f5d40
# ╟─2ec86fe5-2ef3-4921-ab77-14ba9a6be1ba
# ╠═69a5aabd-4206-4826-ab57-8e9fbb2d8508
# ╠═102381e9-596b-436b-85dc-2eb71859afa7
# ╟─39d737c4-6b05-4d12-bdeb-b8c5230dff6c
# ╠═8e0e3115-e819-43c8-99c2-848a65d5416e
# ╟─4f143b08-bdc9-4bd1-8f43-98d7c771a2fa
# ╠═34a2d705-90ba-4adb-af13-6d2792a47471
