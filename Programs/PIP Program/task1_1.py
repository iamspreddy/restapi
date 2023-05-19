import requests as rq

base_url='https://www.boredapi.com/api/activity'


payload={'participants':1} #insert some paramaeters add to Url
request=rq.get(base_url,params=payload)
data=request.json()
print('Response',data)
print('----')
print('Activity',data['activity'])
print('Type',data['type'])
