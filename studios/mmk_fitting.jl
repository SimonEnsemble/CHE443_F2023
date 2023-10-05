### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 8cbe2b98-622b-11ee-1a47-d1e474cf1e0b
begin
	import Pkg; Pkg.activate()
	using CairoMakie, Optim, CSV, DataFrames, PlutoUI
	
	update_theme!(fontsize=20, resolution=(500, 500))
end

# ╔═╡ 9010151c-081c-4ffd-aa2c-84e6e15cb065
TableOfContents()

# ╔═╡ 07f7edcf-0b7c-4486-ac50-5bc7ce280f86
md"# fitting parameters to kinetic rate data

> a rate equation characterizes the rate of reaction, and its form may be suggested by either theoretical considerations or simply be the result of an empirical curve-fitting procedure. - Octave Levenspiel

> With four parameters I can fit an elephant, and with five I can make him wiggle his trunk. - Von Neumann

!!! note \"the experimental kinetic rate data\"
	the file `mmk_data.csv` contains experimental kinetic rate data pertaining to an enzyme E (beta galactosidase) catalyzing the conversion of a substrate S (lactose) to an altered (hydrolyzed) form R. so, the reaction to which this data pertains is S → R where the reaction (\"→\") is driven by an enzyme (a biological catalyst).

	> Hydrolysis of lactose increases the sweetness of the [dairy] product, which in many cases provides an opportunity to lower the level of added sugar. - [source](https://www.sciencedirect.com/science/article/pii/S0958694611002251#sec2)

	each row of the data table gives the rate of conversion of the substrate for a different substrate concentration.

	_data source_: E. Selvarajan, V. Mohanasrinivasan. Kinetic studies on exploring lactose hydrolysis potential of β-galactosidase extracted from Lactobacillus plantarum HF571129. _Food Sci Technol_ (2015)
"

# ╔═╡ 22e0755f-e0f9-40ed-b74e-a0750b3208c4
md"## read in the data

🍇 read in the `mmk_data.csv` file of the data as a `DataFrame`. assign it to a variable `data` to use later.

!!! hint
	* use the function `CSV.read`. [docs](https://csv.juliadata.org/stable/reading.html#CSV.read)
	* the function `pwd()` shows your present working directory (where you need to put the file) and `readdir()` shows the contents of your pwd to ensure the file is there.
	* look at the raw text file `mmk_data.csv`. note the first line is a comment, _not_ the column names as expected. to handle this, _do not_ delete the first line but rather see the `comment` or `skipto` arguments of `CSV.read`.
"

# ╔═╡ 99e2dd08-77ff-4819-8469-d841191e849d


# ╔═╡ 297d8828-968a-4915-bb50-91ec97c3139b


# ╔═╡ 84609b05-c9d1-4373-a8e8-9da6d90eb093


# ╔═╡ eaa394e6-2a58-4e8b-b930-5a1a7d2f9d0d
md"🍇 to practice retrieving a column of the data frame as a vector (eg. for plotting), extract the column of data giving the substrate concentrations."

# ╔═╡ 3f951794-fc9d-4283-80df-890ccc88893c


# ╔═╡ 0fcb4a36-7f50-4dd6-8ae0-e12ebdf21a06
md"## viz the data
🍇 write a function `viz_data(data)` that plots the rate of conversion of the substrate vs. the concentration of the substrate as points. label the x- and y-axes and include units.
"

# ╔═╡ b30096af-1ac0-48ac-9afd-9c172f67b73e


# ╔═╡ 1024e791-7164-4ca8-b9b0-120947784307


# ╔═╡ c69a1833-88b4-49fd-844f-bffb900ed4e6
md"## assessing the fit of Michaelis-Menten kinetics"

# ╔═╡ 41b33224-2849-4eef-a53a-b0dbaa77df4e
md"

!!! note \"Michaelis-Menten kinetics\"
	based on the shape of the conversion rate vs. substrate concentration, we hypothesize that the rate at which the enzyme converts the substrate is governed by Michaelis-Menten kinetics.

	let 
	*  $s$ [mmol/L] be the substrate (lactose) concentration.
	*  $[E_0]$ [mg/L] be the concentration of enzyme (β-galactosidase).
	*  $r$ [μmol/(min-L)] be the resulting rate of conversion of the substrate.
	
	according to Michaelis-Menten kinetics, the conversion rate of the substrate is:
	```math
	r=r(s) = \frac{k_3 [E_0] s}{s^\star + s}
	```
	with $k_3$ [μmol/(min-mg)] a rate constant and $s^{\star}$ [mmol/L] the Michaelis-Menten constant.


!!! warning \"what the data gives us\"
	while the data give us $s$ directly in units mmol/L, the rate values in the data are actually $r / [E_0]$ which has units μmol/(min-mg). thus, we instead focus on the equation:
	```math
	\frac{r(s)}{[E_0] } = \frac{k_3 s}{s^\star + s}
	```
	and wish to infer the parameters $k_3$ and $s^\star$ from the data.
"

# ╔═╡ ce7db692-f743-43c7-9890-cb478ddd14ce
md"🍇 write a function `r(s, k₃, s★)` that takes as arguments the substrate concentration $s$ and two Michaelis-Menten parameters $k_3$ and $s^\star$ then returns the predicted rate of reaction $r(s)/[E_0]$."

# ╔═╡ a7aac2a7-00a7-474c-8798-f55610703b7d


# ╔═╡ 5c1085ba-dba5-4920-9250-16967dea501b
md"🍇 by visual inspection of the plot 👀, what is your rough guess for the values of the parameters $k_3$ and $s^\star$? assign them to variables below as `k₃_guess` and `s★_guess`."

# ╔═╡ 61019d64-9374-400d-8ced-e3c8c6a66356


# ╔═╡ 1693ab6e-3a28-46a6-a438-e4887b00be6d


# ╔═╡ f4836c3f-9534-4778-aaa3-9c0389fd0671
md"🍇 to assess the fit of any given parameters $(k_3, s^\star)$, write a function `viz_fit(data, k₃, s★)` that displays (i) the data as a scatter plot and (ii) the theoretical Michaelis-Menten model $r(s)/[E_0]$ with those parameters. include an axis legend to indicate the points are the data and the line is the model. include x- and y-axis labels. 

call `viz_fit(data, k₃_guess, s★_guess)` to assess how well the model, with your guessed parameters, fits the data.

!!! note
	it is poor practice to replicate code when it can be put into a function and reused. so, inside `viz_fit`, call your previously-coded function `viz_data` to retreive a figure panel with the data, _then_ modify it by adding the Michaelis-Menten curve to it.
"

# ╔═╡ 2367ae77-94aa-4d4a-aeb6-609d72f91c32


# ╔═╡ 618bde70-9fd9-4907-903a-f281859231d6


# ╔═╡ 3e5f0e13-f2b5-4d45-ab26-45e775001962
md"## optimizing the fit of Michaelis-Menten kinetics

💡 now, we will employ an optimization routine to find the parameters $(k_3, s^\star)$ that \"best\" fit the data.

🍇 to define and quantify the quality of the fit of a Michaelis-Menten model with parameters $(k_3, s^\star)$ to the data in `data`, write a function `loss(θ)` where `θ = [k₃, s⋆]` is the parameter vector that expresses the sum of square residuals between the model and the data. ie.
```math
	\ell(\mathbf{\theta})=\ell(k_3, s^\star) :=\sum_{i=1}^n\left[r(s_i)/[E_0]- r_i/[E_0] \right]^2
```
with the data viewed as (substrate-concentration, rate) pairs $\{(s_i, r_i/[E_0])\}_{i=1}^n$. the quantity inside the sum $[\cdots]$ is the residual between the model and data point $i$.

!!! note
	we _must_ code-up `loss(θ)` not `loss(k₃, s★)` because the `Optim.jl` package demands us to express our function as one that takes a vector as an input (for generalizability).

!!! hint
	see my data-fitting demo from CHE 361 [here](https://simonensemble.github.io/CHE_361_W2023/demos/html/fitting_model_to_data.jl.html).
"

# ╔═╡ ce9d0b10-403a-4819-855a-d47434dd5e87


# ╔═╡ a66b90c8-6ee0-4737-8cc3-bdb070d30a83
md"🍇 define `θ_guess` as your guess for the parameter vector using `k₃_guess` and `s★_guess`."

# ╔═╡ f23cc111-00d7-437c-ba13-56b22127c730


# ╔═╡ 151bf87b-db7f-4be7-a535-af5b7611aa81
md"🍇 to at least test if your `loss` function _runs_ (not quite a rigorous test...), call `loss(θ_guess)` to compute the loss for your guessed parameter vector. it should give you a number (that we want to be as low as possible)."

# ╔═╡ 64ccb4f5-351e-49b6-ad97-7cba6d7a34dc


# ╔═╡ 08a5e859-0628-49e9-b0c0-af7dc5eed537
md"
💡 the `optimize` function intelligently tunes `θ` until `loss(θ)` is at a minimum. these are the parameters of best fit.

🍇 use `optimize` and your `θ_guess` to minimize the loss function. extract from the result, the parameter vector that minimizes the loss. assign to variables `k₃_opt, s★_opt` the optimal parameters.

!!! hint
	see the first example in the `Optim.jl` docs [here](https://julianlsolvers.github.io/Optim.jl/stable/#user/minimization/).

"

# ╔═╡ 4991a828-c88d-4aa7-9a5d-831694136849


# ╔═╡ 302fb07d-7150-46f0-8562-1913c2fb6dc3


# ╔═╡ 8121d113-30ac-463a-a24c-fc2e6d2e1755
md"🍇 finally, call your function `viz_fit(data, k₃_opt, s★_opt)` to visualize how well the Michaelis-Menten model _with optimized parameters_ fits the data."

# ╔═╡ e416a38d-4c70-4bdc-bea7-fec009ec79c3


# ╔═╡ 14901639-d2da-47bd-bbb3-68e5ac98710a
md"💡 we can now use our expression $r(s)$, with empirically identified parameters $k_3$ and $s^\star$, for the design of a bioreactor designed to hydrolyze lactose!

> Microbial β-galactosidases have a prominent position in terms of their role in the production of various industrially relevant products like biosensor, lactose hydrolyzed milk, the production of galacto-oligosaccharides for use in probiotic foodstuffs, etc.

🚁 this studio is an example of how rate constants and kinetic model parameters are obtained for modeling chemical reactors then designing them---we use experimental data to infer them!
" 

# ╔═╡ Cell order:
# ╠═8cbe2b98-622b-11ee-1a47-d1e474cf1e0b
# ╠═9010151c-081c-4ffd-aa2c-84e6e15cb065
# ╟─07f7edcf-0b7c-4486-ac50-5bc7ce280f86
# ╟─22e0755f-e0f9-40ed-b74e-a0750b3208c4
# ╠═99e2dd08-77ff-4819-8469-d841191e849d
# ╠═297d8828-968a-4915-bb50-91ec97c3139b
# ╠═84609b05-c9d1-4373-a8e8-9da6d90eb093
# ╟─eaa394e6-2a58-4e8b-b930-5a1a7d2f9d0d
# ╠═3f951794-fc9d-4283-80df-890ccc88893c
# ╟─0fcb4a36-7f50-4dd6-8ae0-e12ebdf21a06
# ╠═b30096af-1ac0-48ac-9afd-9c172f67b73e
# ╠═1024e791-7164-4ca8-b9b0-120947784307
# ╟─c69a1833-88b4-49fd-844f-bffb900ed4e6
# ╟─41b33224-2849-4eef-a53a-b0dbaa77df4e
# ╟─ce7db692-f743-43c7-9890-cb478ddd14ce
# ╠═a7aac2a7-00a7-474c-8798-f55610703b7d
# ╟─5c1085ba-dba5-4920-9250-16967dea501b
# ╠═61019d64-9374-400d-8ced-e3c8c6a66356
# ╠═1693ab6e-3a28-46a6-a438-e4887b00be6d
# ╟─f4836c3f-9534-4778-aaa3-9c0389fd0671
# ╠═2367ae77-94aa-4d4a-aeb6-609d72f91c32
# ╠═618bde70-9fd9-4907-903a-f281859231d6
# ╟─3e5f0e13-f2b5-4d45-ab26-45e775001962
# ╠═ce9d0b10-403a-4819-855a-d47434dd5e87
# ╟─a66b90c8-6ee0-4737-8cc3-bdb070d30a83
# ╠═f23cc111-00d7-437c-ba13-56b22127c730
# ╟─151bf87b-db7f-4be7-a535-af5b7611aa81
# ╠═64ccb4f5-351e-49b6-ad97-7cba6d7a34dc
# ╟─08a5e859-0628-49e9-b0c0-af7dc5eed537
# ╠═4991a828-c88d-4aa7-9a5d-831694136849
# ╠═302fb07d-7150-46f0-8562-1913c2fb6dc3
# ╟─8121d113-30ac-463a-a24c-fc2e6d2e1755
# ╠═e416a38d-4c70-4bdc-bea7-fec009ec79c3
# ╟─14901639-d2da-47bd-bbb3-68e5ac98710a
