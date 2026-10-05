# Statistical Computing, Monte Carlo Simulations, and Data Analysis in R

Statistical computing repository containing exploratory data analysis workflows with `ggplot2` alongside computational statistical inference, Monte Carlo simulations, and parametric estimation implemented in R.

Developed as part of the Probabilidade e Estatística (PE) curriculum at Instituto Superior Técnico (IST), Universidade de Lisboa.

---

## Overview

The repository covers applied statistical computing in two distinct modules:

1. **Exploratory Data Analysis (`analysis/`)**:
   - Healthcare and clinical diagnostics (HCV biomarkers).
   - Macroeconomic labor indicators in the European Union.
   - Commodity price dynamics and time series relative variation.
2. **Computational Statistical Inference (`simulations/`)**:
   - Monte Carlo integration and extreme value theory sampling.
   - Empirical verification of the Central Limit Theorem (CLT).
   - Maximum Likelihood Estimation (MLE) with non-linear numerical solving.
   - Confidence interval coverage probabilities (Exact vs Asymptotic).
   - Statistical hypothesis testing power and Type II Error ($\beta$) estimation.
   - Chi-Square goodness-of-fit testing with optimal histogram binning rules.

---

## Exploratory Data Analysis

### 1. Clinical Diagnosis Biomarkers (`analysis/clinical_diagnosis.R`)

- **Dataset:** Hepatitis C Virus (HCV) clinical laboratory measurements (`data/hcvdat0.csv`).
- **Objective:** Analyze the distribution and dispersion of Alkaline Phosphatase (`ALP`) across distinct diagnosis categories (`Blood Donor`, `Suspect Blood Donor`, `Hepatitis`, `Fibrosis`, `Cirrhosis`).
- **Visualization:** Styled `ggplot2` boxplots highlighting interquartile ranges, medians, and outliers across patient cohorts.

### 2. Commodity Price Dynamics (`analysis/energy_prices.R`)

- **Dataset:** Petroleum & Other Liquid Fuels price series (`data/Petroleum&OtherLiquidFuels.txt`).
- **Objective:** Evaluate Year-over-Year (YoY) relative price variation across crude benchmarks (`CrudeWTI`, `CrudeBrent`) against the composite market `MEAN`.
- **Visualization:** Multi-series time-series line charts with custom color palettes and date-axis formatting.

### 3. EU Food Industry Employment (`analysis/eu_food_employment.R`)

- **Dataset:** European Union Jobs and Growth database (`data/Jobs_and_Growth.csv`).
- **Objective:** Compare employment evolution in the food manufacturing sector between Croatia and Estonia across chronological reporting periods.
- **Visualization:** Grouped bar charts (`position = "dodge"`) with angled categorical axes for publication-grade layout.

---

## Statistical Inference & Simulations

### Monte Carlo Integration & Extreme Value Distributions (`simulations/monte_carlo_integrals.R`)

- **Gumbel Extreme Values:** Samples from Gumbel distributions ($\mu = 3150, \sigma = 560$) using `extraDistr` to compute conditional tail probabilities:

  $$P(X > L_E \mid X > L_A) = \frac{1 - F(L_E)}{1 - F(L_A)}$$

- **Bivariate Integration:** Solves a non-trivial bivariate domain integral through numerical quadrature (`integrate`) and validates it against 100 Monte Carlo replications of 1,400 stochastic samples.

### Central Limit Theorem Convergence (`simulations/central_limit_theorem.R`)

- Evaluates asymptotic convergence of sample means $\bar{X} \sim \text{Poisson}(\lambda = 2)$ for $n = 336$ over $M = 153$ independent replications.
- Computes the empirical coverage probability $P(|\bar{X} - \lambda| \le \epsilon)$ and compares it to the theoretical Gaussian approximation:

  $$P(|\bar{X} - \lambda| \le \epsilon) \approx 2\Phi\left(\frac{\epsilon}{\sqrt{\lambda / n}}\right) - 1$$

### Maximum Likelihood Estimation (`simulations/weibull_mle.R`)

- Formulates the profile log-likelihood score equation for the shape parameter $\alpha$ of a Weibull distribution:

  $$\frac{1}{\alpha} + \frac{1}{n}\sum_{i=1}^n \ln(x_i) - \frac{\sum_{i=1}^n x_i^\alpha \ln(x_i)}{\sum_{i=1}^n x_i^\alpha} = 0$$

- Solves numerically via `uniroot` and estimates the median lifetime $\hat{m} = \hat{\lambda}(\ln 2)^{1/\hat{\alpha}}$.

### Confidence Interval Coverage (`simulations/confidence_intervals.R`)

- Compares exact Chi-Square confidence intervals against asymptotic Normal intervals for exponential distribution mean parameters ($\lambda = 13, \gamma = 0.92$):
  - **Exact Interval:** Based on $\frac{2n\bar{X}}{\lambda} \sim \chi^2(2n)$.
  - **Asymptotic Interval:** Based on the standard normal pivot $Z = \frac{\bar{X} - \lambda}{\lambda / \sqrt{n}}$.

### Hypothesis Testing and Type II Error (`simulations/hypothesis_testing.R`)

- Conducts power analysis for a right-tailed hypothesis test under a Beta distribution model:
  - $H_0: a = 2.00$ vs $H_1: a = 2.35$ with fixed parameter $b = 3$ and sample size $n = 32$.
  - Calculates theoretical Type II error probability $\beta = P(\text{Fail to reject } H_0 \mid H_1)$ and compares against 2,000 empirical Monte Carlo simulations.

### Goodness-of-Fit Testing (`simulations/goodness_of_fit.R`)

- Implements Chi-Square goodness-of-fit testing on empirical data against $N(0, 1.96)$ using equiprobable partitioning.
- Evaluates statistical sensitivity under two standard binning criteria:
  - **Sturges' Rule:** $k = \lceil \log_2(n) + 1 \rceil$
  - **Freedman-Diaconis Rule:** $h = 2 \cdot \text{IQR} \cdot n^{-1/3}$

---

## Repository Structure

```text
probability-statistics-r/
├── analysis/
│   ├── clinical_diagnosis.R       # HCV ALP biomarker boxplots
│   ├── energy_prices.R            # Crude oil relative price variation
│   ├── eu_food_employment.R       # EU food industry employment comparison
│   └── data/
│       ├── hcvdat0.csv
│       ├── Petroleum&OtherLiquidFuels.txt
│       └── Jobs_and_Growth.csv
├── simulations/
│   ├── monte_carlo_integrals.R    # Extreme values and numerical integration
│   ├── central_limit_theorem.R    # Poisson CLT convergence simulation
│   ├── weibull_mle.R              # Weibull shape parameter estimation
│   ├── confidence_intervals.R     # Exact vs Asymptotic CI coverage
│   ├── hypothesis_testing.R       # Beta distribution Type II error analysis
│   ├── goodness_of_fit.R          # Chi-Square test with Sturges and FD binning
│   └── data/
│       └── Modular_P800.txt
├── docs/
│   └── figures/                   # Rendered publication plots
├── .gitignore
├── LICENSE                        # MIT License
└── README.md
```

---

## Running the Code

### Prerequisites

Install R (version 4.0 or later) and required packages:

```r
install.packages(c("ggplot2", "extraDistr"))
```

### Executing Scripts

Run any analysis or simulation script from the command line:

```bash
# Run exploratory data analysis
Rscript analysis/clinical_diagnosis.R
Rscript analysis/energy_prices.R
Rscript analysis/eu_food_employment.R

# Run statistical simulations
Rscript simulations/central_limit_theorem.R
Rscript simulations/monte_carlo_integrals.R
Rscript simulations/confidence_intervals.R
Rscript simulations/hypothesis_testing.R
Rscript simulations/weibull_mle.R
Rscript simulations/goodness_of_fit.R
```

---

## Author & Acknowledgments

- **David Vasques** ([@DeastV](https://github.com/DeastV))

Coursework project developed for Probabilidade e Estatística (PE), Instituto Superior Técnico, Universidade de Lisboa.

*Course-Provided Datasets & Parameters:* Reference datasets (`data/hcvdat0.csv`, `data/Petroleum&OtherLiquidFuels.txt`, `data/Jobs_and_Growth.csv`, `data/Modular_P800.txt`) and specific sampling parameters ($n = 336, M = 153$, simulation random seeds) were provided by the PE teaching faculty. The MIT License applies to the R analysis scripts, statistical transformations, ggplot2 visualizations, and Monte Carlo simulation routines.
