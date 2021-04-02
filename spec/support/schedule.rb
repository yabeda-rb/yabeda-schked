# frozen_string_literal: true

at "2020-01-01 00:00:00", as: "SuccessfulJob", blocking: true do
  :ok
end

at "2020-01-01 00:00:00", as: "FailedJob", blocking: true do
  raise StandardError, "Boom!"
end

at "2020-01-01 00:00:00", tag: "without_name", blocking: true do
  :ok
end
