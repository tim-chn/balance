# Balance centiles for individuals with intellectual disability
This is a project for the Keck Data Science Undergraduate Research at Pepperdine University overseen by [Dr. Adam Pennell](https://seaver.pepperdine.edu/academics/faculty/adam-pennell/) with collaboration from [Dr. Robert Rigby](https://www.londonmet.ac.uk/profiles/staff/robert-rigby/) and [Professor Mikis Stasinopoulos](https://scholar.google.com/citations?user=n9OHjHYAAAAJ&hl=en). It aims to create precise centile curves using the GAMLSS framework in R for various balance related variables from a Special Olympics dataset.

### Table of Contents
- [Background](#background)
- [Methods](#methods)
  - [Data Access and Prepping](#data-access-and-prepping)
  - [Test](#test)
  - [Analysis](#analysis)
- [Results](#results)
- [Discussion/conclusion](#discussionconclusion)
- [References](#references)

## Background
There is a dire need for high quality, population-level research relating to the health of individuals with intellectual disabilities (ID). For around two decades, Special Olympics International has been conducting “Healthy Athletes” screenings at (inter)national and regional events. “Healthy Athletes” is the largest known international database related to health outcomes and ID. However, the database is under-utilized from a research perspective. 

One “Healthy Athlete” domain of evaluation is FUNfitness (e.g., cardiovascular fitness, strength, balance, flexibility). Given the large-scale nature of FUNfitness, deriving ID-specific, norm-referenced centiles from its respective tests seems timely and practical. Norm-referenced scores have various advantages (e.g., relative performance, screening, inform interventions). Balance, which has been posited to (in)directly influence movement behaviors and health outcomes, has been found to be impaired in individuals with ID. The forward functional reach test, which assesses stability limits, is a common clinical balance test also found within the FUNfitness battery. 

Therefore, the purpose of this study was to develop North American sex and age specific centiles for right and left functional reaches in individuals with ID (aged 8-21 years) from the FUNfitness dataset. If developed, these results could directly translate to, and immediately benefit, clinical practice (i.e., aid score interpretation and subsequent decision-making). 


## Methods
### Data Access and Prepping
- Received study approval as well as access to the FUNfitness dataset from Special Olympics
- The dataset underwent various cleaning and prepping procedures. The final step was [imputation](https://academic.oup.com/bioinformatics/article/28/1/112/219101).
  - N=12,932, Mean age=15.87y (SD=3.51); 62% boys

### Test
- Right and left forward functional reaches (see figure) 
- Distance scored in centimeters (cm).
<img width="210" alt="image" src="https://user-images.githubusercontent.com/100978347/181093649-8e8e046d-236e-4027-a87a-a6dfaf576408.png">

### Analysis
We utilize generalized additive models for location, scale and shape (GAMLSS), a cutting edge statistical modelling technique that models four parameters, location, scale, skewness, and kurtosis, to fit the data to a GAMLSS family distribution. gamlss.dist includes over 50 different continuous distributions, one of which is chosen by the choosedist() function using minimum generalized akaike information criterion (GAIC).

For both male and female, choosedist() calculates the Generalized Gamma (GG) distribution as the best fit. However, the s shaped [worm plot](https://pubmed.ncbi.nlm.nih.gov/11304741/) indicates a failure to adequately fit kurtosis. This is expected for data with kurtosis, since the GG distribution does not fit the tau kurtosis parameter.

The data is then fit using a log transformation. The function choosedist() chooses a distribution for the log transformed values for reach. A log family of the chosen distribution is generated and fitted with the non transformed reach data. The function gen.Family() generates a log distribution for the chosen family, and the data is then fit to the distribution. The data is then compared using model diagnostics (i.e. worm plots, quantile residual visuals and coefficients, minimum AIC).

The centiles() function generates the centiles curves. A local penalty was applied for boys left reach to improve smoothness of the curves while maintaining model integrity. 

All steps are included in [analysis.R](https://github.com/timchen37/balance/blob/main/analysis.R).
  

## Results
<img width="800" alt="image" src="https://user-images.githubusercontent.com/100978347/181094078-53446550-ce0b-432e-afed-b73a955c0409.png">

## Discussion/Conclusion
These centiles are the first results of their kind. The methods used generated robust centiles due to the large sample size and the advanced modeling techniques. The results may be adopted by practitioners and used for clinical practice (e.g., score interpretation) in the respective population. 

Some notable observations: 
- Boys right and left reach 98th centiles were somewhat elevated at the youngest ages, which seems counterintuitive and unexpected. This could be due to less data for younger individuals. 
- Within each sex, right and left reach curves were similar; between sexes, boys 98th centile appeared slightly elevated.
- Limitations: data collection concerns (e.g., data entry, administration consistency); data cleaning procedures; model diagnostics (i.e., worm plots) were not perfect.

### References
1. Lloyd, M., Foley, J. T., & Temple, V. A. (2018). Maximizing the use of Special Olympics International's Healthy Athletes database: A call to action. Research in Developmental Disabilities, 73, 58-66.
2. FUNfitness: Learn how to Organize, Promote and Present
3. Pennell, A. (2021). Postural control and balance. In J. Haegele (Ed.), Movement and visual impairment: Research across disciplines (pp.17-31). Routledge. 
4. Blomqvist, S., Olsson, J., Wallin, L., Wester, A., & Rehn, B. (2013). Adolescents with intellectual disability have reduced postural balance and muscle performance in trunk and lower limbs compared to peers without intellectual disability. Research in Developmental Disabilities, 34(1), 198-206.
5. Enkelaar, L., Smulders, E., van Schrojenstein Lantman-de Valk, H., Geurts, A. C., & Weerdesteyn, V. (2012). A review of balance and gait capacities in relation to falls in persons with intellectual disability. Research in developmental disabilities, 33(1), 291-306.
6. Maiano, C., Hue, O., Morin, A. J., Lepage, G., Tracey, D., & Moullec, G. (2019). Exercise interventions to improve balance for young people with intellectual disabilities: a systematic review and meta‐analysis. Developmental Medicine & Child Neurology, 61(4), 406-418.
7. Duncan, P. W., Weiner, D. K., Chandler, J., & Studenski, S. (1990). Functional reach: a new clinical measure of balance. Journal of gerontology, 45(6), M192-M197.
8. Horak, F. B., Wrisley, D. M., & Frank, J. (2009). The balance evaluation systems test (BESTest) to differentiate balance deficits. Physical therapy, 89(5), 484-498.
10. Stekhoven, D. J., & Bühlmann, P. (2012). MissForest—non-parametric missing value imputation for mixed-type data. Bioinformatics, 28(1), 112-118.
11. Stasinopoulos, M. D., Rigby, R. A., Heller, G. Z., Voudouris, V., & De Bastiani, F. (2017). Flexible regression and smoothing: using GAMLSS in R. CRC Press.
12. Buuren, S. V., & Fredriks, M. (2001). Worm plot: a simple diagnostic device for modelling growth reference curves. Statistics in medicine, 20(8), 1259-1277.


