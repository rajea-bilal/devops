Greeting workflow
Every time you push code to the DevOps repo, GitHub starts the workflow in .github/workflows/greeting.yaml. It runs one job called greeting. All three steps happen on the same Ubuntu machine.

1. Copy the repo files. The checkout step copies the files from your commit onto the Ubuntu machine. The machine now has the custom_actions folder.
2. Greet Rajea. The workflow passes the name Rajea to the custom action. GitHub reads custom_actions/action.yaml, which tells it to run dist/index.js inside that folder. The JavaScript prints Hello, Rajea and saves the current time as an output called time.
3. Show the time. The greeting step has the ID greet. The last step uses steps.greet.outputs.time to read the time from that step and print it in the log.
   To see the result, open the Actions tab on GitHub, select the latest Greeting workflow run, and open the greeting job. Expand Run my greeting action to see the greeting and Show the greeting time to see the time.
   Where ncc fits
   You run ncc build index.js on your Mac before you push. It creates the bundled file at custom_actions/dist/index.js. When you change the action’s JavaScript, rebuild it and commit the updated bundle so GitHub runs your changes.
