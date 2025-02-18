# Chapter 3 Problems

# Preliminaries
library(nycflights13)
library(tidyverse)

# 3.2.5 Exercises
# Problem 1
flights |> 
  filter(arr_delay > 120)

flights |> 
  filter(dest %in% c("IAH", "HOU"))

flights |> 
  filter(carrier %in% c("UA", "AA", "DL"))

flights |> 
  filter(month %in% c(7, 8, 9))

flights |> 
  filter(arr_delay > 120 & (dep_time == sched_dep_time))

flights |> 
  filter(dep_delay >= 60 & (arr_delay <= -30))

# Problem 2
flights |>
  arrange(desc(dep_delay))

flights |> 
  arrange(dep_time)

# Problem 3
flights |> 
  arrange(air_time)

# Problem 4
flights |> 
  distinct(month, day)

# Problem 5
flights |> 
  arrange(desc(distance))
flights |>
  arrange(distance)

# Problem 6
# No, both arrange the data by the necessary requirements.


# 3.3.5 Exercises
# Problem 1
# dep_delay is sched_dep_time - dep_time

# Problem 2
flights |> 
  select(dep_time, dep_delay, arr_time, arr_delay)
flights |> 
  select(starts_with("dep") | starts_with("arr"))

# Problem 3
# Only the first occurrence of the variable is kept.

# Problem 4
# any_of() checks whether the specified column names exist in the data 
# and allows for missing columns without throwing an error.
# when using any_of() with select(), it lets us select the columns even 
# if some of the columns in variables may not exist in the dataset.

# Problem 5
flights |> select(contains("TIME"))
# it surprises me a little because I would expect the data to contain time
# but it also makes sense that the it's the columns that contain time

# Problem 6
flights |> 
  rename(air_time_min = air_time) |> 
  relocate(air_time_min)

# Problem 7
# you're only selecting tailnum, so we can't arrange by arr_delay.
# you should first arrange by arr_delay then select tailnum






# 3.5.7 Exercises
# Problem 1
flights |> 
  group_by(carrier) |> 
  summarize(
    avg_delay = mean(dep_delay, na.rm = TRUE)
  ) |> 
  arrange(desc(avg_delay))
# F9 has the worst avg delays

# Problem 2
flights |> 
  group_by(dest) |> 
  filter(!all(is.na(dep_delay))) |> 
  filter(dep_delay == max(dep_delay, na.rm = TRUE))

# Problem 3
flights_delays <- flights %>%
  filter(!is.na(dep_delay)) %>%
  mutate(hour = dep_time %/% 100) %>%  # Get the hour from the departure time
  group_by(hour) %>%  # Group by hour
  summarize(mean_dep_delay = mean(dep_delay, na.rm = TRUE))  # Calculate mean delay per hour
ggplot(flights_delays, aes(x = hour, y = mean_dep_delay)) +
  geom_line() +
  labs(title = "Average Departure Delays by Hour of the Day", 
       x = "Hour of Day", 
       y = "Average Departure Delay (minutes)") +
  theme_minimal()

# Problem 4
# It does the opposite than what the function is meant to do.

# Problem 5


# Problem 6
df <- tibble(
  x = 1:5,
  y = c("a", "b", "a", "a", "b"),
  z = c("K", "K", "L", "L", "K")
)
# a
# creates 2 groups, a and b
df |>
  group_by(y)
df
# b
# will sort y from a to b
df |>
  arrange(y)
# c
# gets the mean of x by a and b
df |>
  group_by(y) |>
  summarize(mean_x = mean(x))
# d
# gets the mean of x by a, b, K, and L
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))
# e
# gets the mean of x by a, b, K, and L and then removes the groupings
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x), .groups = "drop")
# f
# both create columns called mean_x that gets the mean of x by a, b, K, and L;
# but first one displays only the mean_x column while the second one displays
# all columns
df |>
  group_by(y, z) |>
  summarize(mean_x = mean(x))

df |>
  group_by(y, z) |>
  mutate(mean_x = mean(x))
