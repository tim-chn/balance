# Special Olympics Balance
This is a documentation of secondary data analysis on a special olympics data set.

## Background
There is a dire need for high quality, population-level research relating to the health of individuals with intellectual disabilities (ID). For around two decades, Special Olympics International has been conducting “Healthy Athletes” screenings at (inter)national and regional events. “Healthy Athletes” is the largest known international database related to health outcomes and ID. However, the database is under-utilized from a research perspective. 

One “Healthy Athlete” domain of evaluation is FUNfitness (e.g., cardiovascular fitness, strength, balance, flexibility). Given the large-scale nature of FUNfitness, deriving ID-specific, norm-referenced centiles from its respective tests seems timely and practical. Norm-referenced scores have various advantages (e.g., relative performance, screening, inform interventions). Balance, which has been posited to (in)directly influence movement behaviors and health outcomes, has been found to be impaired in individuals with ID. The forward functional reach test, which assesses stability limits, is a common clinical balance test also found within the FUNfitness battery. 

Therefore, the purpose of this study was to develop North American sex and age specific centiles for right and left functional reaches in individuals with ID (aged 8-21 years) from the FUNfitness dataset. If developed, these results could directly translate to, and immediately benefit, clinical practice (i.e., aid score interpretation and subsequent decision-making). 


## Methods
### Data Access and Prepping
- Received study approval as well as access to the FUNfitness dataset from Special Olympics
- The dataset underwent various cleaning and prepping procedures. The final step was imputation
  - N=12,932, Mage=15.87y (SD=3.51); 62% boys

### Test
- Right and left forward functional reaches (see figure) 
- Distance scored in centimeters (cm).
<img width="210" alt="image" src="https://user-images.githubusercontent.com/100978347/181093649-8e8e046d-236e-4027-a87a-a6dfaf576408.png">

### Analysis
- Generalized additive models for location, scale and shape (GAMLSS)
  - Cutting-edge statistical modeling technique.
  - Location, scale, skewness, *kurtosis.
- Chose the best distribution (lower Akaike information criterion [AIC]): logJSU (boys), logSEP4 (girls).
- Model diagnostics: quantile residual coefficients and visuals; emphasis on worm plots.13
- Create centiles curves
  - Boys left reach: applied a local penalty to improve smoothness of the curves while maintaining model integrity.
  

## Results
<img width="800" alt="image" src="https://user-images.githubusercontent.com/100978347/181094078-53446550-ce0b-432e-afed-b73a955c0409.png">

## Discussion/Conclusion
- First results of their kind; robust centiles due to the large sample size and the advanced modeling techniques.
- These centiles may be adopted by practitioners and used for clinical practice (e.g., score interpretation) in the respective population. 
- Boys right and left reach 98th centiles were somewhat elevated at the youngest ages.
- Within each sex, right and left reach curves were similar; between sexes, boys 98th centile appeared slightly elevated.
- Limitations: data collection concerns (e.g., data entry, administration consistency); data cleaning procedures; model diagnostics (i.e., worm plots).



