import json
import boto3

# הגדרה של המשאב של DynamoDB והטבלה
dynamodb = boto3.resource('dynamodb')
data_table = dynamodb.Table('UserDataTable')

def get_data_handler(event, context):
    user_id = event['pathParameters']['UserID']

    # שליפת הנתונים מ-DynamoDB
    response = data_table.get_item(Key={'UserID': user_id})

    return {
        'statusCode': 200,
        'body': json.dumps(response['Item'])
    }
