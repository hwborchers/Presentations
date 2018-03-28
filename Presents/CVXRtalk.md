% The CVXR Package
% Hans W Borchers
% 12/15/2017


## What is CVX* ?

CVX\* is a family of implementations of **Disciplined Convex Programming** (DCP), invented an initialized by Stephen Boyd and collaborators at Stanford University:

* CVX       (MATLAB, ~2005)
* CVXPY     (Python, 2013)
* convex.jl (Julia, 2015)
* CVXR      (R, 2017)

Disciplined convex programming imposes a set of conventions to follow when constructing convex problems.

## What is "Convex Optimization" ?

## What is DCP ?

Euler: In integers, $x^3 + y^3 = z^3$ is impossible if $x, y, z \ne 0$.

## Example: Linear Regression


```r
library(CVXR, warn.conflicts=FALSE)

set.seed(123)
n = 100; p = 10
X = matrix(rnorm(n * p), nrow=n)
x = 1:p

Y = X %*% x + rnorm(n)
ls.model = lm(Y ~ 0 + X)
sol1 = unname(ls.model$coefficients); sol1
```

```
##  [1]  1.080311  1.988295  2.875176  4.133395  5.091466  5.949045  7.076470
##  [8]  8.127228  8.960957 10.134885
```


```r
y = Variable(p)                             # define the varables
objective = Minimize(sum((Y - X %*% y)^2))  # define the objective
problem =   Problem(objective)              # create the problem
result =    solve(problem)                  # solve the problem
values =    result$getValue(y)              # extract the solution
sol2 = c(values); sol2
```

```
##  [1]  1.080311  1.988296  2.875174  4.133395  5.091465  5.949045  7.076469
##  [8]  8.127227  8.960956 10.134885
```
