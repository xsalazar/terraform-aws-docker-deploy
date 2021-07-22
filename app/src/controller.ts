import * as Hapi from '@hapi/hapi';
import { controller, Controller, get } from 'hapi-decorators';

@controller('/')
export class MyController implements Controller {
  public baseUrl: string;
  public routes: () => Array<Hapi.ServerRoute>;

  @get('/')
  public healthCheck(request: Hapi.Request, responseToolkit: Hapi.ResponseToolkit): Hapi.ResponseObject {
    return responseToolkit.response('Hello World! 👋').code(200);
  }
}
