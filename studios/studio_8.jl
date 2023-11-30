### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ fa7d2658-8c80-11ee-3fcd-f306dbae13a1
begin
	import Pkg; Pkg.activate()
	using CairoMakie, DataFrames, Interpolations, Cubature, Optim

	set_theme!(theme_light())
	update_theme!(fontsize=20, resolution=(450, 450), markersize=15, linewidth=3)
end

# ╔═╡ dd015146-c327-45f2-b100-625499012257
md"
# optimizing a recycle reactor for an enzymatic reaction

!!! note \"learning objectives\"
	* gain intuition about when a recycle stream is beneficial.
	* optimize the recycle ratio for a recycle reactor

!!! warning \"problem statement\"
	in the presence of a specific enzyme E, which acts as a homogeneous catalyst, a harmful organic species A, present in industrial waste water, degrades into harmless chemicals. 

	at a given enzyme concentration $c_E$ [mmol/m³], seven experiments in a laboratory mixed-flow reactor (MFR) at various feed concentrations and flow rates gave the results below, reported in terms of the concentration of the harmful organic species A in the feed (cₐ₀) and product stream (cₐ) and the space time (τ) of the fluid in the MFR.
	
	using this data, we now wish to design a recycle reactor---a plug flow reactor (PFR) with a recycle stream---to treat a stream of 20 m³/hr of waste water, containing 8.0 mmol/m³ of the harmful organic species A, to achive 80% conversion with this enzyme at the same concentration $c_E$ used in the experiments with the MFR. specifically, we wish to tune the recycle ratio $R$ to minimize the volume $V$ [m³] of the recycle reactor required for this duty.

"

# ╔═╡ 798c0af3-3688-4541-9169-0b3200a6b057
data = DataFrame(
	"cₐ₀ [mmol/m³]" => [2.0, 5.0, 6.0, 8.0, 11.0, 16.0, 24.0],
	"cₐ [mmol/m³]"  => [0.5, 3.0, 1.0, 2.0, 6.0, 8.0, 4.00],
	"τ [hr]"        => [30.0, 1.0, 50.0, 8.0, 4.0, 20.0, 4.0]
)

# ╔═╡ 39b97e04-c235-4a17-bd32-07dcb2432af9
md"## characterizing the rxn rate law

here, we analyze the MFR data to characterize the reaction rate law for our later design of the recycle reactor.

🐧 add a new column to the data frame, giving the reaction rate $r_A$ [mmol/(m³⋅hr)] in the MFR during each experiment.
"

# ╔═╡ 943146a4-8ff6-4532-a33f-51c82a76bebb

# ╔═╡ e13abbbf-1233-4394-8c00-e3074f379cf9

# ╔═╡ e140d031-a9c3-4f05-8234-1c90377684fa
md"🐧 plot the negative reaction rate of A $-r_A$ as a function of the concentration of A $c_A$.

!!! note
	experimental _data_ should almost always be drawn as individual points, so a `scatter` not `lines`.

"

# ╔═╡ 65485524-397f-49fc-bf5e-2d5f511b5fdf

# ╔═╡ c52f88d1-64d2-4f29-b795-3c2f4dc3a65c
md"🐧 based on the qualitative shape of the data, describe intuitively why a recycle stream can enhance the performance of a PFR.

[installing a recycle stream on a PFR will improve the performance of an ordinary PFR because ... ]
"

# ╔═╡ 38a21076-273d-4b08-b1da-d15110d728eb
md"🐧 for our design of the recycle reactor, we will need to predict the reaction rate, $r_A$, at different concentrations of A, $c_A$. construct a linear interpolator of the data to allow us to model the function $r_A(c_A)$. 

!!! hint
	use the `linear_interp` function documented [here](https://juliamath.github.io/Interpolations.jl/stable/#Example-Usage).
	* the $c_A$ values must be sorted for this linear interpolator function. see the `sort!` function documented [here](https://dataframes.juliadata.org/stable/man/sorting/).
	* if you try to extrapolate beyond concentrations of A seen in the data, the linear interpolator will throw an error, unless you inform the interpolator how to extrapolate. note, you shouldn't need to extrapolate in this assignment (that would be dangerous!).
"

# ╔═╡ ea093970-dbe2-4886-a0dc-b028cbcc2148

# ╔═╡ a83a4536-399f-4868-b298-d37b9d77350a

# ╔═╡ 1f833730-237f-46b9-9cda-044bbbcd3737
md"🐧 to check your linear interpolator, use `lines!` to draw a curve (dashed line style) on top of your plot of $-r_A$ vs $c_A$, visualizing the $-r_A(c_A)$ function the interpolator represents."

# ╔═╡ adeb8b4b-b881-47fd-a27f-1f2c36ccb513

# ╔═╡ 25e372e5-0cd7-4bd7-82cc-902f20de6a99
md"## designing the recycle reactor

now, let us exploit our data-driven linear interpolator model of the reaction rate law $r_A(c_A)$ to design the recycle reactor.

!!! note
	see my notes based on [Fogler's textbook](http://websites.umich.edu/~elements/04chap/html/04prof2.htm) for a mathematical model of the recycle reactor.
	
🐧 define the three knowns as variables below: the incoming volumetric flow rate, the concentration of A in the feed, and the desired overall conversion.
"

# ╔═╡ 4055c897-122e-46f4-8b4b-5e485d01835d

# ╔═╡ 3589e122-c724-4d90-95fa-521b117ac7b4

# ╔═╡ 0061f8f2-55ba-4672-8ee8-e8eca9167ccf

# ╔═╡ 5bc0834b-8daa-41aa-86aa-b0af905446ad
md"we need to analyze the performace of the recycle reactor as a function of the recycle ratio $R$.

🐧 write a function `Xₛ(R)` that outputs the single-pass conversion given an input recycle ratio `R`."

# ╔═╡ 43a1b624-a38c-48b6-b3cc-3ce0db0d2676

# ╔═╡ b59aa9f8-68c3-4e54-8934-26512cb93016
md"🐧 apply the design equation for a recycle reactor to write a function `V(R)` that outputs the required volume `V` of PFR for the duty, given an input recycle ratio `R`.

!!! hint
	numerical integration is required here... use your linear interpolator.
"

# ╔═╡ 34026eaa-1ebc-4cf2-9b81-118ba7f70cee

# ╔═╡ 60d9fb2f-90ee-48bc-b538-10985fafb288

# ╔═╡ f9b07788-da5e-46b8-bf47-fd62607850d1
md"🐧 plot the volume `V` of the PFR required for the duty against the recycle ratio `R`, over a span $R\in[0, 2]$."

# ╔═╡ 3fa2812e-b6a8-4be8-abd3-793e2b337c5c

# ╔═╡ 13384d70-1888-4069-a032-e7cb78133f51

# ╔═╡ 2e38d0f1-2df2-4b09-9f2e-6041cf6a961d
md"🐧 what is the optimal recycle ratio $R^*$ and associated minimal volume $V^*$ of the PFR required for the duty? what is the flow rate of the optimal recycle stream?

[🚀 this constitutes your \"design\" of the recycle reactor!]
"

# ╔═╡ 399d4582-6fd1-445b-bac6-f1d8ce12e1b9

# ╔═╡ 0984d275-5e5d-4f00-aa6c-a11119204e5d

# ╔═╡ 9751e501-6725-4cbf-9230-a48096ff85ae

# ╔═╡ fb5322f5-0017-48ce-8a26-0917050c1db5

# ╔═╡ ecdf1099-6efe-4f38-bf3d-787d99245bf8
begin
	println("optimal recycle ratio: ", 
		round(R_opt, digits=2)
	)
	println("optimal flow rate of recycle stream [m³/hr]: ", 
		round(ν_r_opt, digits=1)
	)
	println("minimal volume of PFR [m³]: ", 
		round(V_opt, digits=1)
	)
end

# ╔═╡ 60e259ae-a77d-4fb3-9481-20d8e29afdd8
md"
❗ ❗ ❗ extra credit point!

🐧 on a plot with two panels and a shared x-axis, plot 
(top panel) the reaction rate $-r_A$ and 
(bottom) the concentration of A $c_A$
as a function of (x-axis) the volume along the PFR.
"

# ╔═╡ 6b24890d-c263-461c-b42a-97aa8e137101

# ╔═╡ a67499b5-06ad-4d65-87af-911f437e9e46

# ╔═╡ 6a842d80-e891-42d0-9019-92ef90c25acb

# ╔═╡ c3dc4f0f-33fa-4d97-853e-9730a8451bc1

# ╔═╡ 7055be41-2416-415f-8f9e-61b26d2af3be

# ╔═╡ 436c50fd-73f9-483a-b880-744faadda669

# ╔═╡ 64b7140b-f2ac-4d3c-a2c5-f78dbef73b30

# ╔═╡ Cell order:
# ╠═fa7d2658-8c80-11ee-3fcd-f306dbae13a1
# ╟─dd015146-c327-45f2-b100-625499012257
# ╠═798c0af3-3688-4541-9169-0b3200a6b057
# ╟─39b97e04-c235-4a17-bd32-07dcb2432af9
# ╠═943146a4-8ff6-4532-a33f-51c82a76bebb
# ╠═e13abbbf-1233-4394-8c00-e3074f379cf9
# ╟─e140d031-a9c3-4f05-8234-1c90377684fa
# ╠═65485524-397f-49fc-bf5e-2d5f511b5fdf
# ╠═c52f88d1-64d2-4f29-b795-3c2f4dc3a65c
# ╟─38a21076-273d-4b08-b1da-d15110d728eb
# ╠═ea093970-dbe2-4886-a0dc-b028cbcc2148
# ╠═a83a4536-399f-4868-b298-d37b9d77350a
# ╟─1f833730-237f-46b9-9cda-044bbbcd3737
# ╠═adeb8b4b-b881-47fd-a27f-1f2c36ccb513
# ╟─25e372e5-0cd7-4bd7-82cc-902f20de6a99
# ╠═4055c897-122e-46f4-8b4b-5e485d01835d
# ╠═3589e122-c724-4d90-95fa-521b117ac7b4
# ╠═0061f8f2-55ba-4672-8ee8-e8eca9167ccf
# ╟─5bc0834b-8daa-41aa-86aa-b0af905446ad
# ╠═43a1b624-a38c-48b6-b3cc-3ce0db0d2676
# ╟─b59aa9f8-68c3-4e54-8934-26512cb93016
# ╠═34026eaa-1ebc-4cf2-9b81-118ba7f70cee
# ╠═60d9fb2f-90ee-48bc-b538-10985fafb288
# ╟─f9b07788-da5e-46b8-bf47-fd62607850d1
# ╠═3fa2812e-b6a8-4be8-abd3-793e2b337c5c
# ╠═13384d70-1888-4069-a032-e7cb78133f51
# ╟─2e38d0f1-2df2-4b09-9f2e-6041cf6a961d
# ╠═399d4582-6fd1-445b-bac6-f1d8ce12e1b9
# ╠═0984d275-5e5d-4f00-aa6c-a11119204e5d
# ╠═9751e501-6725-4cbf-9230-a48096ff85ae
# ╠═fb5322f5-0017-48ce-8a26-0917050c1db5
# ╠═ecdf1099-6efe-4f38-bf3d-787d99245bf8
# ╟─60e259ae-a77d-4fb3-9481-20d8e29afdd8
# ╠═6b24890d-c263-461c-b42a-97aa8e137101
# ╠═a67499b5-06ad-4d65-87af-911f437e9e46
# ╠═6a842d80-e891-42d0-9019-92ef90c25acb
# ╠═c3dc4f0f-33fa-4d97-853e-9730a8451bc1
# ╠═7055be41-2416-415f-8f9e-61b26d2af3be
# ╠═436c50fd-73f9-483a-b880-744faadda669
# ╠═64b7140b-f2ac-4d3c-a2c5-f78dbef73b30
