class Ahoy::Store < Ahoy::Stores::ActiveRecordStore
  # customize here
  Ahoy.track_visits_immediately = true
  # Ahoy.visit_duration = 3.minutes
end
