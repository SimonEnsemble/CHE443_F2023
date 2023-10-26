### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 52e298ea-72d3-11ee-1e92-f74d5e35cf7b
begin
	import Pkg; Pkg.activate()
	using CairoMakie, DataFrames, Statistics
end

# ╔═╡ de7036b2-da44-498f-b4bf-a8f55fc33c0b
update_theme!(resolution=(500, 500), linewidth=3, markersize=18, fontsize=20)

# ╔═╡ 3ba68419-6a56-4222-b4d3-5d9faaaed4f9
md"
!!! note \"🤓 learning objectives\"
	* understand and apply the performance equation for a batch reactor---specifically, to find the duration $t$ for which we should allow the reaction to proceed, in order to reach a desired final concentration.
	* implement a numerical integration routine for data-driven batch reactor design; this is useful when we do not possess an explicit formula for the rate law owing to the complexity of the reaction.

## integration of a rate law for batch reactor (BR) design

a batch reactor carries out the liquid-phase reaction:

A → R

isothermally. to begin the reaction, we charge into the BR a volume of $V=6$ L of solution of A at $c_{A0}=1.3$ mol/L. 
"

# ╔═╡ 7cfb62af-4dc7-444a-be8a-0947f7e9d822
html"<img src=\"https://upload.wikimedia.org/wikipedia/commons/thumb/1/15/Batch_reactor_STR.svg/1920px-Batch_reactor_STR.svg.png\" width=150>"

# ╔═╡ 59986f69-004e-4429-b737-e800bf4c7309
md"we do not possess any information about the mechanism of the reaction; we lack an explicit form for the rate law $r_A$ [mol/(L⋅min)]. however, we _do_ possess empirical data giving the rxn rate $-r_A$ at different concentrations of A, $c_A$. the data were obtained from a previous study in a mixed flow reactor (in lecture later, you'll see how to do this). "

# ╔═╡ 0d78c607-6332-49a0-a41e-dc5b92ebccac
data = DataFrame(
	"cₐ [mol/L]" => [0.1, 0.2, 0.3, 0.4, 0.5, 0.6, 0.7, 0.8, 1.0, 1.3, 2.0],
	"-rₐ [mol/(L⋅min)]" => [0.1, 0.3, 0.5, 0.6, 0.5, 0.25, 0.1, 0.06, 0.05, 0.045, 0.042]
)

# ╔═╡ ae2afad7-9e65-4e79-9f38-102809a0c5a6
md"

!!! note \"objective in this studio\"
	recall, the performance equation for a batch reactor is:

	```math
	t = \int_{c_{A}}^{c_{A0}} \frac{1}{-r_A} dc_A
	```
	
	💡 your goal is to _numerically_ integrate the [transformed] kinetic data, using the trapezoid rule, to determine how long we should allow the reactants to react ($t$ in the performance equation) to achieve a final concentration of $c_A=0.3$ mol/L in the batch reactor. note, to terminate the reaction at this time, we will inject an inhibitor into the reactor."

# ╔═╡ 8c45a659-083d-4b68-8e52-8717e1972c03
md"🥔 add a new column to the data frame, giving the integrand in the performance equation $1/(-r_A)$ [L⋅min/mol], at each concentration of A."

# ╔═╡ 56ab1988-7a9a-4f0c-a7fa-0dc90f262cb6

# ╔═╡ a9e5325d-a423-43eb-97ac-c2a8311aa692

# ╔═╡ 5fc72ae2-7302-41e0-a9b3-5b0175f97117
md"🥔 to prepare for integration, plot the data, as inverse reaction rate $-1/r_A$ (y-axis) vs. concentration of A $c_A$ (x-axis).
* include x- and y-axis labels with units.
* plot the data as orange points.
* use `xlims!` and `ylims!` to ensure the origin $(0, 0)$ is shown, for proper perspective.
"

# ╔═╡ 2d5be322-95c1-4498-a094-c2f3d88a0afb

# ╔═╡ bd9d3700-e317-4d5c-87f6-4e49f1460ec1
md"🥔 use the trapezoid rule to perform the appropriate integration of the data to arrive at the time $t$ required to achieve $c_A=0.3$ mol/L.

!!! hint
	see the Wikipedia article [here](https://en.wikipedia.org/wiki/Trapezoidal_rule) on the trapezoid rule. pay attention to detail.


!!! warning
	the spacing between concentrations in the data is non-uniform.
"

# ╔═╡ a37d95b0-f559-4ae5-8d23-c0e01d25beb7

# ╔═╡ 91ad906f-2e3f-4a76-9ef3-30c10c11c3cf

# ╔═╡ 73cf55d4-78d8-4be2-bf71-ddc9ffe49e37
println("let the reactants brew for t [min] = ", rand()) # put ur t here.

# ╔═╡ e074e890-8e26-4484-af4e-603c3979f3eb
md"🥔 to make sure you understand the trapezoid rule, re-draw the data exactly as above, but highlight/shade the trapezoids whose areas you added up to obtain $t$. use a blue, transparent-ish color for the shading.

!!! hint
	use `band!`. docs [here](https://docs.makie.org/stable/reference/plots/band/). also, I'd add onto your axis above, instead of copying the chunk of code, which is poor practice.
"

# ╔═╡ 3cb9fdd2-8bd5-4e05-84d3-5ba8ca02249f

# ╔═╡ 12e87b14-96b7-4cc6-9558-803d94c6b7cd
md"🥔 [a written, not coding, question] what would you do if instead I had asked the same question, but with $c_A=0.32$ mol/L? note, this concentration does not exactly appear in the data.

I would [... your answer here...].
"

# ╔═╡ Cell order:
# ╠═52e298ea-72d3-11ee-1e92-f74d5e35cf7b
# ╠═de7036b2-da44-498f-b4bf-a8f55fc33c0b
# ╟─3ba68419-6a56-4222-b4d3-5d9faaaed4f9
# ╟─7cfb62af-4dc7-444a-be8a-0947f7e9d822
# ╟─59986f69-004e-4429-b737-e800bf4c7309
# ╠═0d78c607-6332-49a0-a41e-dc5b92ebccac
# ╟─ae2afad7-9e65-4e79-9f38-102809a0c5a6
# ╟─8c45a659-083d-4b68-8e52-8717e1972c03
# ╠═56ab1988-7a9a-4f0c-a7fa-0dc90f262cb6
# ╠═a9e5325d-a423-43eb-97ac-c2a8311aa692
# ╟─5fc72ae2-7302-41e0-a9b3-5b0175f97117
# ╠═2d5be322-95c1-4498-a094-c2f3d88a0afb
# ╟─bd9d3700-e317-4d5c-87f6-4e49f1460ec1
# ╠═a37d95b0-f559-4ae5-8d23-c0e01d25beb7
# ╠═91ad906f-2e3f-4a76-9ef3-30c10c11c3cf
# ╠═73cf55d4-78d8-4be2-bf71-ddc9ffe49e37
# ╟─e074e890-8e26-4484-af4e-603c3979f3eb
# ╠═3cb9fdd2-8bd5-4e05-84d3-5ba8ca02249f
# ╠═12e87b14-96b7-4cc6-9558-803d94c6b7cd
