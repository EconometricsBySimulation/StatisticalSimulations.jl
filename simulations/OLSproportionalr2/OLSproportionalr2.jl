# R2 attributed

using Distributions

n = 10000
x1 = rand(Normal(), n)
x2 = rand(Normal(), n) .+ .2 * x1
x3 = 1000*(rand(Normal(), n) .- .2 * x1 .+ .2 * x2)

x2 = rand(Normal(), n)
x3 = rand(Normal(), n)

u = rand(Normal(), n) .* 2

y = 2 .+ 1.5*x1 .+ 2.7*x2 .- .5* x3 + u

constant = fill(1,n)
X = hcat(constant, x1, x2, x3)

β = inv(X'X) * X'y

ŷ = X*β

s² = ((y-ŷ)' * (y-ŷ)) / (n-4)


seβ₁ = √(s² * inv(x1' * x1))
seβ₂ = √(s² * inv(x2' * x2))
seβ₃ = √(s² * inv(x3' * x3))

√(s² .* inv(X'X))

ccdf(Chisq(4), s²)


SS(x) = sum((x .- mean(x)).^2)

# Sum of Squares Total
SST = SS(y)

# Sum of Squares Explained
SSR = SS(ŷ)

# Sum of Squares Error
SSE = SS(y-ŷ)

# Degrees of freedom model
DFM = 4-1

# Degrees of freedom total
DFT = n-4

# Mean of squares of regression
MSR = SSR/DFM

# Mean of squares of total
MST = SSR/DFT

F = MSR/MST


R2 = SSR/SST

ŷ₁ = x1*β[2]
ŷ₂ = x2*β[3]
ŷ₃ = x3*β[4]

SSR1 = SS(ŷ₁)
SSR2 = SS(ŷ₂)
SSR3 = SS(ŷ₃)

SSR
SSRp = SSR1 + SSR2 + SSR3

SSR1p = SSR1/SSRp
SSR2p = SSR2/SSRp
SSR3p = SSR3/SSRp


##### Normalization Approach
x1 = x1/var(x1)^.5
x2 = x2/var(x2)^.5
x3 = x3/var(x3)^.5

X = hcat(constant, x1, x2, x3)

β = inv(X'X) * X'y

# Asserting Independence - generally vioated
# var(y) = β[2]^2*var(x1) + β[3]^2*var(x2) + β[4]^2*var(x3)

# Since we normalized
denom = β[2]^2 + β[3]^2 + β[4]^2

β[2]^2/denom
β[3]^2/denom
β[4]^2/denom
