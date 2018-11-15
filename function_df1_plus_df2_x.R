
#function to merge join df1_treat_zone_x to df2_zone_x
glimpse(df1_treat_zone_x)
glimpse(df2_zone_x)

df_treat_zone_x <- function(df1, df2) {
df_treat_z_x <- left_join(df1, df2, by = 'year') %>% 
  select(year, crop = crop.x, cost, yld_resp_since_applied, 
         yld_resp_perct_crop,current_yld, potential_yld, price)
return(df_treat_z_x)
}

df_rip_zone1 <- df_treat_zone_x(df1 = df1_treat_zone_x, df2 = df2_zone_x)
