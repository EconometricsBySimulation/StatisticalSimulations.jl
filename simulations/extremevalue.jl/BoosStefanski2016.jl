# Exploration of Boos Stanski Chapter 1 - consulting example

# You are trying to model maximum flooding level Q
# while A is floodplane
# and k and η are parameters to be estimated

# literature suggests over 100 years the maximum level is:
Q(k, A, η) = k * A^(η - 1)

# Take the log to linearlize
logQ(k, A, η) = log(k) + (η - 1)*log(A)

# Verify
round(logQ(5, 100, .5), digits=5) == round(log(Q(5, 100, .5)), digits=5)

# The problem is that we don't actually see any observation which spans 100 years

# Example is of 140 gauging stations - 140 areas
# Stations have between 6 and 83 years of observations.

# The expected value E for subset of observations X₁ which is smaller than subset
# X₂ which is smaller than the full set X₁₀₀ is going to have the following property:
# E(max(X₁)) < E(max(X₂)) < E(max(X₁₀₀))

# What we would like to know is max(X₁₀₀)

# But the maximum of any of our observed values will be biased downwards since we
# never observe 100 years.

# Authors suggest using an estimate of the the joint likelihood that any observation
# will be below the median using the following identity allowing unobserved and observed
# X_i through X_100 to be ordered
# P(X_100 ≤ t) = P(X_1 ≤, ... X_100 ≤ t) = Π P(X_i < t) = [F(t)]^100
# by iid P(X_100 ≤ t) => [F(t)]^100

# P(X_100 ≤ t) = [F(t)]^100 = 1/2
# → P(X_100 ≤ t) = F(t₀) = (1/2)^.01 → t₀ = .993


# Using Extreme value function
# P(X_i <= t) = exp(-exp(-(t-μ)/σ))

Q993(μ, σ) = σ*(-log(-log(.993))) + μ

# The Authors suggest that we can estimate μ and σ then plug them into the function
# to get the solution.

# lets try it

using Random, Distributions

waterlevel = rand(Poisson(50), 100)
observe = rand(Binomial(1, .25), 100)

μhat = mean(waterlevel[observe .== 1])
σhat = var(waterlevel[observe .== 1])^.5

Q993(μhat, σhat)
maximum(waterlevel)
