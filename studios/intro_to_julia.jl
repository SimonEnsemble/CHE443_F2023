### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 36a9de73-2556-4cda-a8bd-7c4f30d6ac51
begin
	import Pkg; Pkg.activate()# this means Julia will use your locally installed packages.
	using PlutoUI, CairoMakie, Unitful, PlutoTeachingTools, Optim
end

# ╔═╡ 0fc3650a-5ca8-11ee-2671-67c61e82c317
md"# studio \#1: Julia programming

## the Julia programming language
![Julia logo](https://julialang.org/assets/infra/logo.svg)

_why Julia?_
* free, open-source
* high-level, thus easy to use
* dynamic, thus feels interactive
* expressive, read-like-a-book syntax
* high-performance (fast) (design choices allow just-in-time compiler to make optimizations, resulting in fast code)
* safety (offers optional type assertion)
* designed especially for scientific computing
* easy parallelization accross cores
* multiple dispatch

> Julia: A language that walks like Python, runs like C

[link to Julia website](https://julialang.org/)

[link to _Nature_ article on Julia](https://www.nature.com/articles/d41586-019-02310-3)

_resources_:
* [Julia documentation](https://docs.julialang.org/en/v1/)
* [Learn Julia in Y minutes](https://learnxinyminutes.com/docs/julia/)
* [Julia express](http://bogumilkaminski.pl/files/julia_express.pdf)
* [list of learning resources maintained by Julia](https://julialang.org/learning/)
"

# ╔═╡ a057252d-524c-4c75-8b64-4c25f13560c2
TableOfContents()

# ╔═╡ 35e78e49-97de-4236-ac08-fb221b1ae38a
md"# 💪 some coding exercises

my Julia tutorial from CHE 361 is [here](https://simonensemble.github.io/CHE_361_W2023/demos/html/intro_to_julia.jl.html).

## unit conversion
!!! note
	use `Unitful` to allow Julia to convert units for you. its documentation is [here](https://painterqubits.github.io/Unitful.jl/latest/). special attention to [this page](https://painterqubits.github.io/Unitful.jl/latest/conversion/) to make the number non-dimensional.

### warm-up
🦫 a heat of reaction is $\Delta H_r =500$ cal/mol. convert to units kJ/mol.
"

# ╔═╡ 687b3679-7b18-4727-86c7-2364a1da7774


# ╔═╡ a4e70386-f8e5-4f04-ad11-cb308adda18e
md"
### calculating a non-dimensional number
we took a cold lime fruit out of the refrigerator and placed it on the kitchen counter. heat is now being transferred from the ambient air in our kitchen to the lime. the Biot number
```math
\text{Bi}:=hr/k
```
of the lime/air system which informs us about whether we can safely approximate the temperature in the lime as spatially uniform for a lumped analysis of its temperature.

the radius of the lime $r\approx 2.5$ cm.

the reported thermal conductivity of a lime $k \approx 156$ cal/(hr$\cdot$ft$\cdot$K).

the estimated heat transfer coefficient for natural convection through a gas, $h\approx15$ J/(s$\cdot$m$^2\cdot$ K).

🦫 calculate the nondimensional Biot number of this lime.

!!! hint
	I recommend defining `r`, `k`, and `h` in separate cells to see the output. see the \"Dimensionless quantities\" of the `Unitful.jl` docs.
"

# ╔═╡ 1274b947-ad75-4679-82ca-c93026fd4839


# ╔═╡ 9959e194-358f-4886-ac69-d203cdedf85d


# ╔═╡ e5ef9eed-d25f-4607-bdcc-20604cb7257a


# ╔═╡ a5880c7a-b734-4db4-9f7d-afcfc22dad53


# ╔═╡ 4dc95820-e0b0-49dd-9dc5-b8e0236e3464


# ╔═╡ 61fe3cf0-df63-451f-92b4-c479b787f922
md"## writing functions, plotting, and optimizing functions

a batch reactor starting with pure species $A$ at concentration $c_{A0}$ is carrying out a reaction in series $A \overset{k_1}{\rightarrow} B \overset{k_2}{\rightarrow}  C$ where the first-order reaction rates $k_1$ and $k_2$ govern the rate of the elementary reaction $A \rightarrow B$ and $B\rightarrow C$ respectively. expressions for the concentrations of $A$, $B$, and $C$ in the batch reactor as a function of time $t$ is [^1]:
```math
\begin{align}
	c_A(t) &= c_{A0} e^{-k_1t} \\
	c_B(t) &= \frac{c_{A0}}{k_2-k_1}k_1 \left(e^{-k_1t} - e^{k_2t}\right) \\
	c_C(t) &= \frac{c_{A0}}{k_2-k_1}\left[ k_2 (1- e^{-k_1t}) - k_1(1 - e^{k_2t})\right] \\
\end{align}
```

[^1]:we will study this reaction and derive this expression later. see [here](http://websites.umich.edu/~elements/course/lectures/six/index.htm#top2) if can't wait for the derivation.

suppose $c_{A0}=1$ mol/L, $k_1=2$ min$^{-1}$, and $k_2=5$ min$^{-1}$. 
"

# ╔═╡ e14b007e-d722-4d36-aa6d-3af9e2e653f5
k₁ = 2.0 # min⁻¹

# ╔═╡ b714e4b6-f292-4169-9cd0-8783bd165bb1
k₂ = 5.0 # min⁻¹

# ╔═╡ c1963c67-f103-429c-8c39-58265460a93f
c_A0 = 1.0 # mol /L

# ╔═╡ cf8c9a3c-54ba-4bf2-a685-2b295dae0f36
md"🦫 write three functions: `c_A(t)`, `c_B(t)`, and `c_C(t)` that take as an argument the time `t` [min] and return the concentration of A, B, and C, respectively, in the batch reactor at that time.

!!! note
	see the Julia docs on functions [here](https://docs.julialang.org/en/v1/manual/functions/)."

# ╔═╡ bf89492e-38be-4a5c-b54d-e556ad4206a3


# ╔═╡ d2cb7236-0082-4074-971e-f00639b218eb


# ╔═╡ 09f7baae-83a8-4cdd-91c7-02408b4cb2c6


# ╔═╡ 3a2a7764-4a36-4619-916e-3b9e0df80219
md"🦫 as a test for your functions, evaluate them at $t=0$ and for a very large time, say $t=1000$ min. ie. call `c_A(0.0)` and `c_A(100.0)` or `c_A(Inf)` etc. make sure the value makes sense. otherwise, it might be a bug."

# ╔═╡ 517d3972-a72e-490f-bca6-be91e538ae98


# ╔═╡ 97fd74c5-4ed5-4ac8-bc51-9674cd9169fd


# ╔═╡ 33f3dad7-5a1b-4e47-b67d-8409c5a31cee


# ╔═╡ fb01904c-ec45-46bd-a485-65eb8a79fd20


# ╔═╡ 66701ecc-d3a1-41dc-a892-2ab194b69aa4


# ╔═╡ 97077d13-0db7-4ffc-9d3c-e82969a2c773


# ╔═╡ 2420bbab-66d1-4fc9-aeef-85ad3fe8b1e8
md"🦫 plot the concentrations of $A$, $B$, and $C$ in the batch reactor as a function of time $t$ as lines (i) on the same concentration vs. time panel and (ii) with different colors. put in an axis legend to indicate which color corresponds to which species. plot over a time span of $[0, 4]$ min.

!!! note
	use the `CairoMakie.jl` package for plotting, whose documentation is [here](https://docs.makie.org/stable/reference/plots/).

!!! warning
	_always_ include an x- and y-axis label as well as pertinent units. title optional. make the resolution of your time discretiziation sufficient for the curves to look smooth (not jagged). if your legend overlaps with your curves, move it to a better location.

!!! hint
    * see the `range` function to discretize time [here](https://docs.julialang.org/en/v1/base/math/#Base.range).
    * use your functions `c_A(t)` etc. above. see the dot syntax for broadcasting a function over an array [here](https://docs.julialang.org/en/v1/manual/functions/#man-vectorized).
    * [here](https://docs.makie.org/stable/tutorials/basic-tutorial/#simple_legend) is a Makie example with a legend.
"

# ╔═╡ cf974525-366c-44be-a6ce-a9e8450e9f51
update_theme!(fontsize=25, linewidth=3) # Cory's eyes are bad?

# ╔═╡ f3a41826-a4c6-4e71-b17c-5d2e5db43b3c


# ╔═╡ 0a556caa-6c24-4f5f-bbd0-8b6a25d7f88f
md"clearly, the function $c_B(t)$ exhibits a maximum. [if not, check for a coding error.]

🦫 🤔 why is that? explain.

[ ... your answer here ...]
"

# ╔═╡ 300f5aed-7340-4b9b-985b-abf4660c4416
md"🦫 what is the maximum concentration of species $B$ in the reactor? at what time is the concentration of B at its peak? numerically find the optimum using (i) your function `c_B(t)` and (ii) `Optim.jl`. 

!!! note
	see [here](https://julianlsolvers.github.io/Optim.jl/stable/#user/minimization/#minimizing-a-univariate-function-on-a-bounded-interval) for how to optimize a univariate function ($c_B(t)$ is a function of only one variable, $t$).

!!! hint
	seems weird that `Optim.jl` only offers minimizers? the trick is, if we wish to find the $x$ that maximizes a function $f(x)$, that is the same as seeking to find the $x$ that minimizes $-f(x)$. so we must define a new function `negative_c_B(t)` and minimize that.

!!! hint
	check for consistency between your minimum and minimizer and your visual estimation of them from the plot.
"

# ╔═╡ 55cf629d-abad-4910-8654-43b4edc8e123


# ╔═╡ 52a35fac-1720-43c5-9d56-389c89c842c9


# ╔═╡ 350250bb-4bdd-4f87-b714-523029f7dee9


# ╔═╡ 5db4e1cc-91ef-4b16-b9af-0b96325a8044


# ╔═╡ Cell order:
# ╟─0fc3650a-5ca8-11ee-2671-67c61e82c317
# ╠═36a9de73-2556-4cda-a8bd-7c4f30d6ac51
# ╠═a057252d-524c-4c75-8b64-4c25f13560c2
# ╟─35e78e49-97de-4236-ac08-fb221b1ae38a
# ╠═687b3679-7b18-4727-86c7-2364a1da7774
# ╟─a4e70386-f8e5-4f04-ad11-cb308adda18e
# ╠═1274b947-ad75-4679-82ca-c93026fd4839
# ╠═9959e194-358f-4886-ac69-d203cdedf85d
# ╠═e5ef9eed-d25f-4607-bdcc-20604cb7257a
# ╠═a5880c7a-b734-4db4-9f7d-afcfc22dad53
# ╠═4dc95820-e0b0-49dd-9dc5-b8e0236e3464
# ╟─61fe3cf0-df63-451f-92b4-c479b787f922
# ╠═e14b007e-d722-4d36-aa6d-3af9e2e653f5
# ╠═b714e4b6-f292-4169-9cd0-8783bd165bb1
# ╠═c1963c67-f103-429c-8c39-58265460a93f
# ╟─cf8c9a3c-54ba-4bf2-a685-2b295dae0f36
# ╠═bf89492e-38be-4a5c-b54d-e556ad4206a3
# ╠═d2cb7236-0082-4074-971e-f00639b218eb
# ╠═09f7baae-83a8-4cdd-91c7-02408b4cb2c6
# ╟─3a2a7764-4a36-4619-916e-3b9e0df80219
# ╠═517d3972-a72e-490f-bca6-be91e538ae98
# ╠═97fd74c5-4ed5-4ac8-bc51-9674cd9169fd
# ╠═33f3dad7-5a1b-4e47-b67d-8409c5a31cee
# ╠═fb01904c-ec45-46bd-a485-65eb8a79fd20
# ╠═66701ecc-d3a1-41dc-a892-2ab194b69aa4
# ╠═97077d13-0db7-4ffc-9d3c-e82969a2c773
# ╟─2420bbab-66d1-4fc9-aeef-85ad3fe8b1e8
# ╠═cf974525-366c-44be-a6ce-a9e8450e9f51
# ╠═f3a41826-a4c6-4e71-b17c-5d2e5db43b3c
# ╟─0a556caa-6c24-4f5f-bbd0-8b6a25d7f88f
# ╟─300f5aed-7340-4b9b-985b-abf4660c4416
# ╠═55cf629d-abad-4910-8654-43b4edc8e123
# ╠═52a35fac-1720-43c5-9d56-389c89c842c9
# ╠═350250bb-4bdd-4f87-b714-523029f7dee9
# ╠═5db4e1cc-91ef-4b16-b9af-0b96325a8044
