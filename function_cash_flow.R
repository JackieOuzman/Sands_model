library(ggplot2)
library(stringr)
library(tidyverse)
library(dplyr)
glimpse(df_rip_zone1_a)

df1_treat_zone_x <- function(df_treatment_zone) {
#work out the econmoic indicators

  df_treatment_zone <- df_treatment_zone %>% 
  mutate(
          benefit = ((current_yld*(yld_resp_since_applied / 100)* yld_resp_perct_crop) * price), 
          cashflow_no_dis_ann = benefit - cost,
          cashflow_dis_ann = ((benefit*pres_value_fact) - (cost*pres_value_fact)), 
          cashflow_cum_disc = cumsum(cashflow_dis_ann),
          ROI_cum_no_disc = (cumsum(benefit) - cumsum(cost))/ cumsum(cost), 
          ROI_cum_disc = (cumsum(benefit*pres_value_fact) - cumsum(cost*pres_value_fact))/ cumsum(cost*pres_value_fact), 
          benefit_cost_ratio_disc = (sum(benefit*pres_value_fact) / sum(cost*pres_value_fact)), 
          npv = (sum(benefit*pres_value_fact) - sum(cost*pres_value_fact))
          ) 
  write.csv(df_treatment_zone, file = "check_on_outputs.csv")
  return(df_treatment_zone)
}

test <- df1_treat_zone_x(df_rip_zone1_a)


