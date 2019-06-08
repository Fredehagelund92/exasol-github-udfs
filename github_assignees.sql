CREATE PYTHON SET SCRIPT REST_SERVICES.GITHUB_ASSIGNEES (ACCESS_TOKEN varchar(255), CREATOR varchar(255), REPO VARCHAR(255))
EMITS
(
id DECIMAL(36,0),
name varchar(255),
type varchar(255),
url varchar(255)
) AS


import sys
import glob

sys.path.extend(
	glob.glob('/buckets/bfsdefault/default/requests-2.7.0/requests-2.7.0')
)


import json
import datetime
import requests

def run(ctx):


	headers = {'authorization': 'token ' + ctx.ACCESS_TOKEN}

	resp = requests.get('https://api.github.com/repos/{}/{}/assignees'.format(ctx.CREATOR, ctx.REPO), headers=headers)
	resp.raise_for_status()

	# The number of requests remaining in the current rate limit window
	api_limit = resp.headers["X-RateLimit-Remaining"]


	# The time at which the current rate limit window resets in UTC epoch seconds
	api_reset_epoch = int(resp.headers["X-RateLimit-Reset"])
	api_reset_date = datetime.datetime.fromtimestamp(api_reset_epoch).strftime('%Y-%m-%d %H:%M:%S')

	if api_limit <= 0:
		raise Exception('You have reached the api limit for this hour. Wait until: ' + api_reset_date)

	# format response to json
	json_resp = resp.json()


	# raise if error message
	if 'message' in json_resp:
		raise Exception(data['message'])

	for assignee in json_resp:

		identifier = assignee["id"]
		name = assignee["login"]
		assignee_type = assignee["type"]
		url = assignee["url"]

		# map values
		ctx.emit(identifier, name, assignee_type, url)

/
