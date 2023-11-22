### A Pluto.jl notebook ###
# v0.19.27

using Markdown
using InteractiveUtils

# ╔═╡ 706c833e-8721-11ee-1eb2-070981afb3c1
begin
	import Pkg; Pkg.activate()
	using CairoMakie, ColorSchemes, Cubature, Optim

	import AlgebraOfGraphics as AoG
	AoG.set_aog_theme!(fonts=[AoG.firasans("Light"), AoG.firasans("Light")])
	update_theme!(fontsize=20, linewidth=3, resolution=(500, 500))
end

# ╔═╡ 50cfe607-177e-4746-bee6-3d8bbcb964c3
md"# optimizing a recycle reactor

aqueous feed containing reactant A (2 mol/L) enters a plug flow reactor (10 L) which has a provision for recycling a portion of the outflowing stream. the reaction kinetics and stochiometry are:

A → P

```math
-r_A=c_Ac_P \text{ mol/(L⋅min)}.
```
we wish to achieve 96% overall conversion. should we use a recycle stream? if so, at what value should we set the recycle ratio to obtain the highest production rate of the product P, and what volumetric feed rate can we process to this conversion in the reactor?

"

# ╔═╡ f08d5d35-def5-4cf2-b5d8-71d81203919e
md"🐧 define the knowns"

# ╔═╡ aa844c66-7e92-4453-a7e9-c5cfb662fbc5

# ╔═╡ 86fcd54e-ac28-44b7-bdc9-323d8dec0bac

# ╔═╡ 9e197256-ee27-488e-9a93-afeabbaa5e7b

# ╔═╡ 403ac9f4-160d-4ebc-9d18-3f56202b3689
md"🐧 the single-pass conversion, concentrations along the PFR, and reaction rates along the PFR depend on the recycle ratio $R$. code these up as functions." 

# ╔═╡ f98ad598-affd-420d-9c66-78f219acc329
# single-pass conversion

# ╔═╡ 6b8a7739-d6e9-4127-ae4c-a526e5043797
# concentration of A along reactor, parameterized by Xₛ′

# ╔═╡ de71733e-22c7-4717-9cca-2a85cc0ec418
# concentration of P along reactor, parameterized by Xₛ′

# ╔═╡ f5b4d060-5035-4868-b0e7-2be2cfd7354a

# ╔═╡ cf03ec0f-07e2-4af4-9aa2-3492954d37d7
md"🐧 how does the reaction rate vary along the PFR, for different recycle ratios $R$?"

# ╔═╡ c7bbba84-9c4a-4699-a76b-2a5d78d01a85

# ╔═╡ 4e62c7d8-d43c-48a8-b756-f9c2ba7e221a

# ╔═╡ 7b4e8e62-b82b-4d30-9a69-7c6786cc6a88

# ╔═╡ c48eec73-bd29-42b5-9fe1-eb6ff7e8f7bf

# ╔═╡ f0d9b972-05db-4fc4-af69-96b344e07303

# ╔═╡ db416974-dfa1-4a4f-bc3b-74674908259e
md"🐧 performance eqn. for recycle reactor:
```math
\frac{V}{F_{A1}}=\int_0^{X_s}\frac{1}{-r_A}dX_s^\prime
```
but
```math
F_{A1} = F_{A0}[1+R(1-X_o)] = \nu_0 c_{A0}[1+R(1-X_o)]
```

so performance eqn. is:
```math
\frac{V}{\nu_0 c_{A0}[1+R(1-X_o)]}=\int_0^{X_s}\frac{1}{-r_A}dX_s^\prime
```

🐧 the _unknowns_ are:
1. the recycle ratio $R$
2. the incoming volumetric flow rate, $\nu_0$.

we can tune only _one_ of these independently, since the performance eqn. places a constraint on the other. thus, let's tune $R$ and find the $\nu_0$ that gives us our desired overall conversion $X_o$.

🐧 the _objective_ is to maximize production rate of the product P:
```math
F_{P3} = F_{A0}X_o = c_{A0} \nu_0 X_o
```

💡 pick recycle ratio $R$ → find incoming volumetric flow rate $\nu_0$ to achieve the desired conversion with this $R$ → look at production rate.

solving for the volumetric flow rate from the performance eqn.:

```math
\nu_0 = \frac{V}{ c_{A0}[1+R(1-X_o)]\int_0^{X_s}\frac{1}{-r_A}dX_s^\prime}

```
"

# ╔═╡ 865b65a5-ffa6-4894-9cad-ed35926a9143

# ╔═╡ 4fb4a99e-c4b4-44f6-840f-cd4603b9c038

# ╔═╡ 3cc76374-80d1-40f1-8a90-02f50749ec20

# ╔═╡ 4522c103-c92a-4b55-a8c5-c732995c3ec4

# ╔═╡ 05582e7e-83f9-499f-b09b-9c671564e2d0

# ╔═╡ Cell order:
# ╠═706c833e-8721-11ee-1eb2-070981afb3c1
# ╟─50cfe607-177e-4746-bee6-3d8bbcb964c3
# ╟─f08d5d35-def5-4cf2-b5d8-71d81203919e
# ╠═aa844c66-7e92-4453-a7e9-c5cfb662fbc5
# ╠═86fcd54e-ac28-44b7-bdc9-323d8dec0bac
# ╠═9e197256-ee27-488e-9a93-afeabbaa5e7b
# ╟─403ac9f4-160d-4ebc-9d18-3f56202b3689
# ╠═f98ad598-affd-420d-9c66-78f219acc329
# ╠═6b8a7739-d6e9-4127-ae4c-a526e5043797
# ╠═de71733e-22c7-4717-9cca-2a85cc0ec418
# ╠═f5b4d060-5035-4868-b0e7-2be2cfd7354a
# ╟─cf03ec0f-07e2-4af4-9aa2-3492954d37d7
# ╠═c7bbba84-9c4a-4699-a76b-2a5d78d01a85
# ╠═4e62c7d8-d43c-48a8-b756-f9c2ba7e221a
# ╠═7b4e8e62-b82b-4d30-9a69-7c6786cc6a88
# ╠═c48eec73-bd29-42b5-9fe1-eb6ff7e8f7bf
# ╠═f0d9b972-05db-4fc4-af69-96b344e07303
# ╟─db416974-dfa1-4a4f-bc3b-74674908259e
# ╠═865b65a5-ffa6-4894-9cad-ed35926a9143
# ╠═4fb4a99e-c4b4-44f6-840f-cd4603b9c038
# ╠═3cc76374-80d1-40f1-8a90-02f50749ec20
# ╠═4522c103-c92a-4b55-a8c5-c732995c3ec4
# ╠═05582e7e-83f9-499f-b09b-9c671564e2d0
