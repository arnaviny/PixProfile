import json
import boto3

# הגדרה של המשאב של DynamoDB והטבלה
dynamodb = boto3.resource('dynamodb')
data_table = dynamodb.Table('UserDataTable')

def save_data_handler(event, context):
    # ניתוח הקלט למידע שיש לשמור
    body = json.loads(event['body'])
    user_data = {
        'UserID': body['UserID'],
        'Details': body['Details']
    }

    # שמירת הנתונים ב-DynamoDB
    data_table.put_item(Item=user_data)

    return {
        'statusCode': 200,
        'body': json.dumps('Data saved successfully!')
    }
