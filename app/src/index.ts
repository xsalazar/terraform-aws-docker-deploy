import MyServer from './server';
import { APIGatewayProxyEvent, APIGatewayProxyResult } from 'aws-lambda';
import { Server } from '@hapi/hapi';

let server: Server;

export const lambdaHandler = async (event: APIGatewayProxyEvent): Promise<APIGatewayProxyResult> => {
  // Cache server instance
  if (server === undefined) {
    server = await MyServer.start();
  }
  const response = await server.inject({ url: event.path });
  return {
    statusCode: response.statusCode,
    body: JSON.stringify(response.result),
  };
};
