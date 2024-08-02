# Instructions to get ffcAPIClient package: https://github.com/ceff-tech/ffc_api_client

library(ffcAPIClient)
library(tidyr)
version <- "V1_0_0"
outer_dir <- dirname(getwd())
path <- file.path(outer_dir, "IFT_files", "IFT Results")
# Instructions to get token: https://github.com/ceff-tech/ffc_api_client
token <- "YOUR_TOKEN_HERE"


# Read in data from csv file
data <- read.csv(file.path(path, paste("All_hydrographs_", version, ".csv", sep = '')))
ifts <- c(unique(data$ift))
streams <- c (unique(data$stream)) 


# loop through all nrow(gagecoms)
counter <- 0
for (ift in ifts) {

  for (stream in streams) {
    print(paste("Running hyrograph for stream ", stream, " and ift ", ift, sep = ''))
    tryCatch({
      if (stream=="indian"){
        comid <- "2664961"

      } else {
        comid <- "8285498"
      }
      data_ts <- data[data$ift == ift&data$stream == stream,][c('date','flow')]
      data_ts$date <- strptime(as.character(data_ts$date), "%Y-%m-%d")
      data_ts$date <- format(data_ts$date, "%m/%d/%Y")
      results <-  ffcAPIClient::evaluate_alteration(timeseries_df = data_ts,
                                                    token = token, 
                                                    comid = comid,
                                                    plot_results = FALSE)
    
      # Add in the stream and ift to the ffc_results dataframe
      results$ffc_results["stream"] <- stream
      results$ffc_results["ift"] <- ift
      results$doh_data["stream"] <- stream
      results$doh_data["ift"] <- ift
      results$alteration["stream"] <- stream
      results$alteration["ift"] <- ift
      results$ffc_percentiles["stream"] <- stream
      results$ffc_percentiles["ift"] <- ift
      results$predicted_percentiles["stream"] <- stream
      results$predicted_percentiles["ift"] <- ift


      # Append data to growing dataframe
      if(counter==0){
        alt <- results$alteration
        res <- results$ffc_results
        per <- results$ffc_percentiles
        pre <- results$predicted_percentiles
        doh <- results$doh_data
        
      } else {
          alt <- rbind(alt,results$alteration)
          res <- rbind(res,results$ffc_results)
          per <- rbind(per,results$ffc_percentiles)
          pre <- rbind(pre,results$predicted_percentiles)
          doh <- rbind(doh,results$doh_data)
      }
      counter <- counter + 1
    }, error=function(e){cat("ERROR :",conditionMessage(e), "\n")})
  }
}

# Write out results to .csv file
write.csv(alt,file.path(path, "alteration.csv"), row.names = FALSE)
write.csv(res,file.path(path, "ffc_results.csv"), row.names = FALSE)
write.csv(per,file.path(path, "ffc_percentiles.csv"), row.names = FALSE)
write.csv(pre,file.path(path, "predicted_percentiles.csv"), row.names = FALSE)
write.csv(doh,file.path(path, "doh_data.csv"), row.names = FALSE)

# Convert results to long format for Tableau and analysis
res_long <- gather(res, ffm, value = 'value', DS_Dur_WS:Peak_Fre_5, factor_key=TRUE)
write.csv(res_long,file.path(path, "ffc_results_long.csv"), row.names = FALSE)
