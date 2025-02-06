library(tibble)

agenda <- frame_matrix(
  ~Time, ~Topic,
  '2:00', '[Introduction](intro.qmd)',
  '2:15', '[Fundamentals](fundamentals.qmd)',
  '3:00', '[Deployment and IT Hurdles](deploy.qmd)',
  '3:15', 'Q&A and Discussion',
  '3:30', 'Adjourn'
)

save(agenda, file = 'data/agenda.RData')
