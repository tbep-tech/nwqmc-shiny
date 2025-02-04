library(tibble)

agenda <- frame_matrix(
  ~Time, ~Topic,
  '10:30', '[Introduction](intro.qmd)',
  '10:45', '[Fundamentals](fundamentals.qmd)',
  '11:30', '[Deployment and IT Hurdles](deploy.qmd)',
  '11:45', 'Q&A and Discussion',
  '12:00', 'Adjourn'
)

save(agenda, file = 'data/agenda.RData')
