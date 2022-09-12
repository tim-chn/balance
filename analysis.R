datM=read.table("Male_FunF_8+.csv",header=TRUE, sep=",")
library(gamlss)

###CURVE FITTING

m1 <-  gamlss(reach_R ~ pb(age_years),
              sigma.formula = ~ pb(age_years), 
              nu.formula = ~ pb(age_years),  
              tau.formula = ~ pb(age_years), 
              family = BCTo, data = datM, n.cyc=100, c.crit=0.01)

m2 <- chooseDist(m1, type = "realplus", k=c(2,4,log(8134)), parallel="snow", ncpus=4)
#minimum GAIC(k= 9.003808 ) family: GG (GG distribution chosen)


m1_chosen <-  gamlss(reach_R ~ pb(age_years),
                     sigma.formula = ~ pb(age_years), 
                     nu.formula = ~ pb(age_years),  
                     tau.formula = ~ pb(age_years), 
                     family = GG, data = datM, n.cyc=100, c.crit=0.001)

###DIAGNOSTICS

plot(m1_chosen)

term.plot(m2_chosen,what="mu",pages=1)
term.plot(m2_chosen,what="sigma",pages=1)
term.plot(m2_chosen,what="nu",pages=1)
term.plot(m2_chosen,what="tau",pages=1)

wp(m1_chosen, ylim.all=1)
title(main="GG")

wp(m1_chosen, xvar= datM$age_years, ylim.worm=1)
title(main="GG")

###LOG TRANSFORMATION

datM$Lreach_R <- log(datM$reach_R)

l1 <-  gamlss(Lreach_R ~ pb(age_years),
              sigma.formula = ~ pb(age_years), 
              nu.formula = ~ pb(age_years),  
              tau.formula = ~ pb(age_years), 
              family = SHASH, data = datM, n.cyc=50, c.crit=0.01)

l2 <- chooseDist(l1, type = "realline", k=c(2,4,log(8134)), parallel="snow", ncpus=4)
#minimum GAIC(k= 9.003808 ) family: JSU (JSU distribution chosen)

gen.Family("JSU", type="log")

l1_chosen <-  gamlss(reach_R ~ pb(age_years),
                     sigma.formula = ~ pb(age_years), 
                     nu.formula = ~ pb(age_years),  
                     tau.formula = ~ pb(age_years), 
                     family = logJSU(), data = datM, n.cyc=50, c.crit=0.001)

GAIC(m1_chosen,l1_chosen)
#l1_chosen is the better fit

###DIAGNOSTICS

wp(l1_chosen, ylim.all=.5)
wp(l1_chosen, xvar= datM$age_years, n.iter=9)
title(main="logJSU")

###CHECK DEGREES OF FREEDOM
edfAll(l1_chosen)

###LOCAL PENALTY
l1_chosen<-gamlss(reach_L~pb(age_years, method="GAIC", k=4),
           sigma.formula=~pb(age_years, method="GAIC",k=4),
           nu.formula=~pb(age_years, method="GAIC", k=4),
           tau.formula = ~ pb(age_years, method="GAIC", k=4), 
           family=logJSU,data=datM, n.cyc=100, c.crit=0.01)


###CENTILES
centiles(l1_chosen,cent=c(2,5,10,15,25,50,75,90,95,98), xlab="Age (years)", ylab="Reach (cm)")

###REPEAT FOR MALE LEFT, FEMALE LEFT/RIGHT
