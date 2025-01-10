# Load required library
set.seed(123)  # For reproducibility

# Generate workers with random salaries and genders
generate_workers <- function(num_workers) {
  workers <- list()
  for (i in 1:num_workers) {
    salary <- sample(5000:30000, 1)  # Random salary between 5000 and 30000
    gender <- sample(c("Male", "Female"), 1)  # Random gender
    workers[[i]] <- list(name = paste0("Worker_", i), salary = salary, gender = gender)
  }
  return(workers)
}

# Assign levels based on conditions
assign_levels <- function(workers) {
  for (i in seq_along(workers)) {
    tryCatch({
      worker <- workers[[i]]
      
      # Validate data
      if (!is.numeric(worker$salary) || !is.character(worker$gender)) {
        stop("Invalid data for worker: ", worker$name)
      }
      
      # Assign levels
      if (worker$salary > 10000 && worker$salary < 20000) {
        worker$level <- "A1"
      } else if (worker$salary > 7500 && worker$salary < 30000 && worker$gender == "Female") {
        worker$level <- "A5-F"
      } else {
        worker$level <- "Other"
      }
      workers[[i]] <- worker  # Update worker in the list
    }, error = function(e) {
      message(sprintf("Error processing worker %s: %s", workers[[i]]$name, e$message))
      workers[[i]]$level <- "Unknown"  # Assign default level in case of error
    })
  }
  return(workers)
}

# Main Execution
workers <- generate_workers(400)  # Generate 400 workers
workers <- assign_levels(workers)  # Assign levels to workers

# Output results (all 400 workers)
cat("\nSample Results:\n")
for (i in 1:400) {
  worker <- workers[[i]]
  cat(sprintf("%d. %s | Salary: $%d | Gender: %s | Level: %s\n",
              i, worker$name, worker$salary, worker$gender, worker$level))
}
