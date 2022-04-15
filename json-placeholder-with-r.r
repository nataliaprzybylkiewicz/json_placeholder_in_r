library(jsonlite)
library(httr)
library(dplyr)
library(tidyverse)

even_posts <- fromJSON("https://jsonplaceholder.typicode.com/posts")
even_posts <- even_posts[even_posts$id[seq(2, length(even_posts$id), by = 2)], ]

colnames(even_posts)[2:4] <- c("postId", "post_title","post_body")

comments <- fromJSON("https://jsonplaceholder.typicode.com/comments")
comments <- comments[comments$postId %% 2 == 0, ]
colnames(comments)[2:5] <- c("comment_id","comment_name","commentator_email","comment_body")

final_df <- even_posts %>% 
  inner_join(comments,by="postId") %>%
  subset(select= -c(userId))

its_a_final_countdown_tiririri_tututututum <- final_df %>%                              
  group_by(postId) %>%
  summarise(comments_count = n_distinct(comment_id))


                  