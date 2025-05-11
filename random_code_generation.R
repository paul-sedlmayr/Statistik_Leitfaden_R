

# Load necessary package (if not already installed)
# install.packages("dplyr")
library(dplyr)

set.seed(123)  # for reproducibility

# Set number of participants
n <- 120

# Generate the between-subject factor: therapy (0 = no therapy, 1 = therapy)
therapy <- rbinom(n, size = 1, prob = 0.5)

# Generate baseline wellbeing scores (t0) from a normal distribution (mean = 50, sd = 10)
wellbeing_t0 <- rnorm(n, mean = 50, sd = 20)

# Create error terms for t1 and t2 (you can adjust the standard deviation as needed)
error_wellbeing_t1 <- rnorm(n, mean = 0, sd = 10)
error_wellbeing_t2 <- rnorm(n, mean = 0, sd = 10)

# For therapy group 1: add 5 points per time point; for therapy group 0: add 2 points per time point
# Thus, for t1 the increase is either 5 or 2, and for t2 the increase is twice that.
increment_t1 <- ifelse(therapy == 1, 4, 2)
increment_t2 <- ifelse(therapy == 1, 6, 4)

# Generate wellbeing scores at time t1 and t2
wellbeing_t1 <- wellbeing_t0 + increment_t1 + error_wellbeing_t1
wellbeing_t2 <- wellbeing_t0 + increment_t2 + error_wellbeing_t2

# Create the dataset
data <- data.frame(
  participant_id = 1:n,
  therapy = therapy,
  wellbeing_t0 = wellbeing_t0,
  wellbeing_t1 = wellbeing_t1,
  wellbeing_t2 = wellbeing_t2
)

# Optionally, view the first few rows
head(data)

data$wellbeing_t0 <- round(data$wellbeing_t0, 0)
data$wellbeing_t1 <- round(data$wellbeing_t1, 0)
data$wellbeing_t2 <- round(data$wellbeing_t2, 0)

write_csv(data, '/Users/paulsedlmayr/Library/CloudStorage/OneDrive-UniversitätGraz/UNI/A FM3 Tutorium/Statistik_Leitfaden/data_3.csv')

