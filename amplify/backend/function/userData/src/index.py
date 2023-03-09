from urllib import request, parse
import urllib
import os
import json
import base64
import boto3
import uuid
from datetime import datetime
from boto3.dynamodb.conditions import Key, Attr
import random
import ast

tableName = os.environ['STORAGE_USERDATA_NAME']
#baseURL = os.environ.get("BASE_URL")
dynamodb = boto3.resource('dynamodb')
tableUserData = dynamodb.Table(tableName)

def handler(event, context):
    print('received event:')
    print(event)
    #print(event['body'])
    if 'GET' in event['httpMethod']:
        print(list(event['queryStringParameters'].keys())[list(event['queryStringParameters'].values()).index('')])
        response = getUserInfo(list(event['queryStringParameters'].keys())[list(event['queryStringParameters'].values()).index('')])
        print(response)
        if len(response['Items']):
            response['Items'][0]['coinAmount'] = int(response['Items'][0]['coinAmount'])
            for i in range(len(response['Items'][0]['storage'])):
                response['Items'][0]['storage'][i] = int(response['Items'][0]['storage'][i])
        print(response)
    if 'POST' in event['httpMethod']:
        body = json.loads(event['body'])
        response = addUserInfo(body['userId'], int(body['coinAmount']), ast.literal_eval(body['storage']))
    if 'PUT' in event['httpMethod']:
        body = json.loads(event['body'])
        response = updateUserInfo(body['userId'], int(body['coinAmount']), ast.literal_eval(body['storage']))
 

  
    return {
        'statusCode': 200,
        'headers': {
            'Access-Control-Allow-Headers': '*',
            'Access-Control-Allow-Origin': '*',
            'Access-Control-Allow-Methods': 'OPTIONS,POST,GET'
        },
        'body': json.dumps(response)
    }

def addUserInfo(userId, coinAmount, storage):
    response = tableUserData.put_item(
        Item={
            'userId': userId,
            'coinAmount': coinAmount,
            'storage': storage
        }
    )
    return response

def updateUserInfo(userId, coinAmount, storage):
    response = tableUserData.delete_item(
        Key={
            'userId': userId,
        }
    )
    response = tableUserData.put_item(
        Item={
            'userId': userId,
            'coinAmount': coinAmount,
            'storage': storage
        }
    )
    return response

def getUserInfo(userId):
    response = tableUserData.query(KeyConditionExpression=Key('userId').eq(userId))
    return response

