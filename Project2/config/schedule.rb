# The log  file
set :output, "#{path}/log/cron_log.log"

# Job Types created by Mathew Blair for SWEN30006
# contact at mathew.blair@unimelb.edu.au
# script_runner will expect a path to a script, code_runner will
# expect code
job_type :script_runner, "cd :path; rails runner :task :output"
job_type :code_runner, "cd :path; rails runner ':task' :output"

# Run the script every 10 minutes: I am running both the scripts
# for 10 minutes, and the API limit will not be an issue (paid).
every 10.minutes do 
 	script_runner "lib/scraper.rb"
end