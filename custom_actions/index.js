import * as core from "@actions/core";

try {
  const nameToGreet = core.getInput("who-to-greet");
  console.log(`Hello, ${nameToGreet}`);
  // gets the time on the machine running the action,
  // saves it as output called time
  core.setOutput("time", new Date().toTimeString);
} catch (error) {
  core.setFailed(error.message);
}
