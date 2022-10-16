import MyServer from "./server";

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

async function handleSignal(signal: string): Promise<void> {
  console.log(`Received ${signal}`);
  try {
    await MyServer.stop();
  } catch (e) {
    console.log(e);
    process.exit(1);
  }
  process.exit(0);
}
// Listen for signals and gracefully stop the server
process.on("SIGINT", handleSignal);
process.on("SIGTERM", handleSignal);
