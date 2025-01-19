library(tibble)

agenda <- frame_matrix(
  ~Time, ~Topic,
  '10:30', '[Introduction](intro.qmd)',
  '10:45', '[Fundamentals](fundamentals.qmd)',
  '11:30', '[Deployment and IT Hurdles](deploy.qmd)',
  '12:00', 'adjourn'
)

save(agenda, file = 'data/agenda.RData')
