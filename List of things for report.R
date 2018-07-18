# For a second version of this report, create the composite variables below, and include distributions (and equations or explanation for how they are constructed) in the report:
#   
# - First filter out any responses that don't have 3 members in their group. Report how many removed.

# - Study.Others: use the Study variables from the survey, multiply the first number ("studied on my own") by 1, the next by 2, then 3, then 4, then sum those values - it should range from 100 to 400.
# 
# - Parti.Self: Their "My participation" rating - 25.
# 
# - Parti.Range: The maximum participation score minus the minimum.
# 
# - Know.Avg: Convert the Know scores to 0-3 and average them.
# 
# - Parti.Corr: Correlation between other ratings of participation and knowing. Zero if no variation in one variable.
# 
# - Decide.Disc: Decide_1 + Decide_2 * 2 + Decide_3 * 3 (ignore the "most confident" option).
# 
# - G.Exp.Avg: Average of all the G.Exp variables, but with G.Exp2_4, G.Exp3_1 , G.Exp3_2 reversed (i.e. 7-x).
# 
# - G.Exp.SD: Same thing with G.Exp variables, but get standard deviation instead of average.
# 
# - Future.Diff: Recc.Mid - Recc.Final
# 
# 
# Using those composites to replace the variables that make them up, and other variables that might be relevant, construct a correlation matrix for the report using code something like this (from another report). Also do a matrix for all the G.Exp variables.
# 
# suppressMessages(library(corrplot))
# voi <- c("Past.Good", "GF2.Again", "Role.Want", "Role.Did", "GP.Hier", "GP.Follow", "GP.Conflict", "GP.Pace", "PP.Safe", "PP.Value", "PP.Enjoy", "PP.Learn", "PP.Well", "PP.Again", "GE.Weight", "GE.Faci", "GE.Enjoy")
# CorrVals <- cor(S1dat[, voi], use="pair")
# PVals <- cor.mtest(S1dat[, voi], use="pair")
# corrplot(CorrVals, p.mat=PVals$p, type="upper", order = "FPC", addCoefasPercent = TRUE, method="number", diag=0)
# 
# Let me know if you have any questions. Have fun!