import * as Hapi from '@hapi/hapi';

export default class MyServer {
  private static _instance: Hapi.Server;

  public static async start(): Promise<Hapi.Server> {
    const serverConfig: Hapi.ServerOptions = {
      port: 8400,
    };

    MyServer._instance = new Hapi.Server(serverConfig);

    MyServer._instance.route({
      method: 'GET',
      path: '/hello',
      handler: () => {
        return 'Hello Gunnar!';
      },
    });

    await this.instance.start();
    console.log(`Server is running on ${MyServer._instance.info.uri}`);

    return MyServer._instance;
  }

  public static async stop(): Promise<void> {
    return MyServer._instance.stop();
  }

  public static get instance(): Hapi.Server {
    return MyServer._instance;
  }
}
