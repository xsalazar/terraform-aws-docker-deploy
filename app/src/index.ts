import MyServer from './server';

(async (): Promise<void> => {
  try {
    await MyServer.start();
  } catch (e) {
    console.log(e);
    process.exit(1);
  }
})().catch((e) => {
  console.log(e);
});
