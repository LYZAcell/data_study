import urllib.parse
import urllib.request
import json
from openpyxl import load_workbook
import pandas as pd
from IPython.display import display

pd.set_option('display.max_columns', None)
pd.set_option('display.max_rows', None)

client_id = '_pcT5AmlQJmFvdk2EiEY'
client_secret = 'pg5IW1hgHr'

encText = urllib.parse.quote("외대앞 맛집")
num = '&display=20'
sort = '&sort=date'

url = "https://openapi.naver.com/v1/search/blog?query=" + encText + num + sort # JSON 결과
# url = "https://openapi.naver.com/v1/search/blog.xml?query=" + encText # XML 결과
request = urllib.request.Request(url)
request.add_header("X-Naver-Client-Id",client_id)
request.add_header("X-Naver-Client-Secret",client_secret)
response = urllib.request.urlopen(request)
rescode = response.getcode()

if(rescode==200):
    response_body = response.read()
    result = json.loads(response_body)
    df = pd.DataFrame(result['items'])
    display(df)
    df.to_excel('외대 정보.xlsx', sheet_name='맛집 정보')

    # 엑셀 셀 크기 조정하기
    wb = load_workbook('외대 정보.xlsx')
    ws = wb['맛집 정보']

    ws.column_dimensions['B'].width = 100
    ws.column_dimensions['C'].width = 70
    ws.column_dimensions['D'].width = 300
    ws.column_dimensions['E'].width = 50
    ws.column_dimensions['F'].width = 50
    ws.column_dimensions['G'].width = 30
    wb.save('HUFS Info.xlsx')
else:
    print("Error Code:" + rescode)
