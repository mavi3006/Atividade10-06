install.packages("tidyverse")
install.packages("ggplot2")
install.packages("dplyr")
install.packages("tidyr")

library(tidyverse)
library(ggplot2)
library(dplyr)
library(tidyr)

videogames <- read_csv('PS4_GamesSales.csv')

videogames_data_exata <- videogames %>%
    mutate(Year_numerico = as.numeric(Year))%>%
    filter(!is.na(Year_numerico))

videogames_por_ano <- videogames_data_exata %>%
    filter(Genre == "Action" | Genre == "Sports") %>%
    group_by(Year_numerico, Genre) %>%
    summarise(qnt=n(),.groups= "drop")


grafico_plotado <- ggplot(data=videogames_por_ano, aes(x=Year_numerico, y=qnt, group = Genre, fill = Genre))+
    geom_col()+
    scale_fill_manual(values = c("Action" = "pink", "Sports" = "green"))+
    labs(
        title = 'Quantidade de videogames do gênero Action e Sports comprado nos últimos anos:',
        x = 'Ano',
        y = 'Quantidade comprada',
        caption = 'Fonte: PS4_GamesSales'
    )

print(grafico_plotado)