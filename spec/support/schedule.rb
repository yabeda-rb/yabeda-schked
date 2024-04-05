# frozen_string_literal: true

cron "*/30 * * * *", as: "SuccessfulJob", blocking: true do
  :ok
end

cron "*/30 * * * *", as: "FailedJob", blocking: true do
  raise StandardError, "Boom!"
end

cron "*/30 * * * *", tag: "without_name", blocking: true do
  :ok
end
