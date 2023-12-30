import * as Hapi from "@hapi/hapi";
import { controller, Controller, get } from "hapi-decorators";

@controller("/")
export default class MyController implements Controller {
  public baseUrl: string = "/";

  public routes(): Hapi.ServerRoute[] {
    return this.routes();
  }

  @get("/")
  public healthCheck(
    request: Hapi.Request,
    responseToolkit: Hapi.ResponseToolkit
  ): Hapi.ResponseObject {
    return responseToolkit.response("Hello World! 👋").code(200);
  }
}
