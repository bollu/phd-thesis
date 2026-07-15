library(readr)
library(gridExtra)
library(tidyverse)

out <- read_csv("alive.csv")

my_time_out <- 600

bitwidths <- filter(out, did_timeout ==FALSE) %>%
  filter(exitcode == 0) %>%
  pivot_wider(names_from = bitwidth, values_from = time_elapsed, names_prefix = "bw_")

bitwidths <- 
  out %>%
  group_by(name, path) %>%
  filter(time_elapsed > 60 & !is.na(time_elapsed)) %>%
  arrange(bitwidth) %>%
  slice(1) %>%
  ungroup() %>%
  # Arrange by name and path
  arrange(name, path)

bitwidths2 <- 
  out %>%
  group_by(name, path) %>%
  filter(timeout == 300 & did_timeout == FALSE) %>%
  arrange(desc(bitwidth)) %>%
  slice(1) %>%
  ungroup() %>%
  # Arrange by name and path
  arrange(name, path)

bitwidths2 %>%
 ggplot() +
  geom_histogram(mapping = aes(x=bitwidth)) +
  scale_x_log10()

worst <- filter(out, time_elapsed >= 300 & bitwidth <= 1024) %>%
  mutate(identifier = paste(path,name)) %>%
  mutate(all_three = paste(paste(path,name),bitwidth))
worst$all_three[!duplicated(worst$identifier)]

timed_out <- filter(out,timed_out==TRUE)

p1 <- filter(out, time_elapsed > my_time_out) %>%
  ggplot() +
  geom_histogram(mapping=aes(x=time_elapsed)) +
  #geom_vline(mapping = aes(xintercept=my_time_out)) +
  scale_x_log10()  
p1

p2<- filter(out, time_elapsed < my_time_out) %>%
  ggplot() +
  geom_histogram(mapping=aes(x=time_elapsed)) +
  scale_x_log10()  

grid.arrange(p2,p1,ncol=2)
print(filter(out, time_elapsed > my_time_out) )


#some names are duplicated:
out$name[duplicated(out$name)]

#we create a name + the time so that we have unique levels

out %>%
mutate(name_time = paste(name,time_elapsed)) %>%
mutate(name_time = fct_reorder(name_time, time_elapsed)) %>%
ggplot() +
geom_col(mapping=aes(x=name_time,y=time_elapsed)) 

